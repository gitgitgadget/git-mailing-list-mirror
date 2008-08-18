From: "Peter Waller" <peter.waller@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Mon, 18 Aug 2008 13:16:47 -0500
Message-ID: <d3d284ca0808181116t26e2eac3u5b8da4a8f5a91b65@mail.gmail.com>
References: <19035412.post@talk.nabble.com> <20080818173511.GC6014@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV9Ig-0004WA-7R
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbYHRSQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYHRSQt
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 14:16:49 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43892 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYHRSQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 14:16:48 -0400
Received: by gxk9 with SMTP id 9so4045116gxk.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6ODULZr8c7RIjDGX1buJaHjw7iy8zIm3PKEeHJR79Vg=;
        b=DYat7EdXsBSFedU96lWlqFkROGBf624ce3xTK/JwDEDeSbg4avgjDqcVeSZYitIFA5
         Qzr4ooSR3cspyKgMtIStPbCFb6j+VOSV7c6yLbBycr2gt6HuOjOXfrKIl6g73bQchNv3
         fnBnvdKAElIX6US7eO4D4AQvjPM+ShSXxry0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I6hWpZOdN53+BHxpYlOddMXWMgPJLyt2tvsVlcV3iE9SBnaMt/Nm4svD5AKZh/q1v3
         hO0miyGczL7cSyTGxFSIcuNxV6CEttSernjSF3uuNSUVH5hN8B5B6r3eDpNChwW7xI7+
         eVNEqzgctkJ4Kl1cw5PIfthylw6UxVfIbIlyI=
Received: by 10.151.156.15 with SMTP id i15mr10131874ybo.184.1219083407587;
        Mon, 18 Aug 2008 11:16:47 -0700 (PDT)
Received: by 10.151.101.8 with HTTP; Mon, 18 Aug 2008 11:16:47 -0700 (PDT)
In-Reply-To: <20080818173511.GC6014@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92723>

I don't quite understand what you are suggesting I do.

I have looked over the filter-branch manpage.

What would I first do? Copy all three repositories to
./Archive/{A,B,C}? Then rewrite their histories?

- Peter

2008/8/18 Alex Riesen <raa.lkml@gmail.com>
>
> Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
> >
> > I have three repositories, A, B and C. I wish to bring them together to only
> > one repository (.), where they are in a directory called ./Archive, so..
> > ./Archive/{A,B,C}. Then I plan at a later date to move files arbitrarily
> > from ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
> > example, but illustrates what I want to do).
>
> If this transition is meant to be persistent (IOW, the A, B and C stop
> existing as repos on their own) you can rewrite their histories to be
> in the directories (with git filter-branch) and just merge them in
> one. Then the histories will look like as if they have never grown
> separately.
>
