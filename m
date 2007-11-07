From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 18:29:38 -0500
Message-ID: <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <Pine.LNX.4.64.0711072309380.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuLa-0000GE-RD
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbXKGX3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757187AbXKGX3k
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:29:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:33868 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbXKGX3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:29:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3027613wah
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 15:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fIWq5fzXOM99lRcXC0JzsPVTY4U8ycPXt9cyum+LW3o=;
        b=SuWv/VJudvLsifg1KpFexuSYmyOtPe4hnWZNSTYjW0BUkSz/FGl3etiwfEUzuZ2WIOzhtwR06eTUPGVEisVPdgCBqyuQUOhSWncUTT5dsEqlSvGq5ZwYy60kQozNdACa1GFTdyNYN1jKXzXHdLVO9Erfg7DQxOPDUGYMB13M9p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VL8dCXpY6GCz7r1xzAbHtSdfffJyEnbDnuyh3xga6cyUuEKw2GXTvK7EqzVgQEIaeuwgAaPKwJ0p4vG5dDm30O6wWYRoEYwxt4yn35aLcEe1IlsBcTVJLvJKppiBrH3UaYLMfWog8nMqBRwdjsRJAkDTgDFPdxvPJg6hVzwjqts=
Received: by 10.114.14.1 with SMTP id 1mr491271wan.1194478178569;
        Wed, 07 Nov 2007 15:29:38 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 15:29:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711072309380.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63896>

On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 7 Nov 2007, Jon Smirl wrote:
>
> > On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > We also tend to take the approach of viewing the history as that of
> > > the whole project.
> >
> > But if you type 'git log' while cd'd into a subdirectory the whole log
> > is almost never what you want. It's this kind of thing that makes git
> > harder to use.
>
> When I am working in a subdirectory, I often want the whole history.  For
> example, when I am working on the documentation, sometimes I need to look
> up a commit real quick, that touched other parts.
>
> Besides, adding a space and a dot is not what qualifies for "harder to
> use" with this developer.

So if git log is always whole tree, why doesn't this work?

 cd arch/powerpc/platforms/52xx
 git log arch/powerpc/platforms/52xx
fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions

It's not consistent. git log with no parameters is relative to the
project root, git log with a parameter is relative to the current
directory.

-- 
Jon Smirl
jonsmirl@gmail.com
