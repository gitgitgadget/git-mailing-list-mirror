From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Mon, 11 May 2009 08:53:49 +1000
Message-ID: <fcaeb9bf0905101553p56f5e8b2o6e6b550e9494b726@mail.gmail.com>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> 
	<49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> 
	<fcaeb9bf0905062230h7ba9526fg6b79ddade72c072a@mail.gmail.com> 
	<robbat2.20090508T190254.538956494Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon May 11 00:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3HuU-00054n-3w
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 00:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbZEJWyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbZEJWyK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 18:54:10 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:24110 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZEJWyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 18:54:09 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1481762yxj.1
        for <git@vger.kernel.org>; Sun, 10 May 2009 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=p3pTHySdDfO7G/ZCM8gRnGZnpX07LqaoS6bGxJew9rs=;
        b=wGlwClQdnQbv7kehFScSuWSgtNHJY2zaCmz90+46hME5yzrhLuNa9t5RTfDjCoiCpw
         41zE9Yhyv8qYH23F1vp9Ka2MHnN8Jw355BPsOTxy6v5VjW2D3VDaek7+57EXXTo5C3W9
         iK6HIGJ7RRkziOf0tdmAhTtC/TQ+o73z0LPeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GnzZopD68SVHA7kLrbBkhND9Xu35j35/eOOU3wSSHvXdKAujak4yQYif3HTd+3oQgV
         jQh+Oe5foleYhpez+jSXDkb6J0l0HAZC8Rd4Yr+trRD29hGcr/921ls6meq0msR5eTDz
         j+WX3AoihPC249GZNlQbhKogzWedPWPRJ+iIY=
Received: by 10.100.12.17 with SMTP id 17mr13660829anl.2.1241996049785; Sun, 
	10 May 2009 15:54:09 -0700 (PDT)
In-Reply-To: <robbat2.20090508T190254.538956494Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118756>

On Sat, May 9, 2009 at 5:03 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>> How about signing the tree SHA-1 and putting the signature in commit
>> message? It's like gpg way of saying Signed-off-by. If the committer
>> wants to sign again before pushing out, he could amend the commit,
>> append his signature there; or make a no-change commit to contain his
>> signature (probably from git-commit-tree because iirc git-commit won't
>> let you make no-change commit)
> Hmm, I like the sound of that, but I'm concerned it might be difficult
> to enforce. If rewrite-history ever happens, it's also invalidated.

Well if you rewrite and touch the trees, then every signature should
be invalidated anyway. If you only touch commit message, it should
remain valid because I only sign trees.
-- 
Duy
