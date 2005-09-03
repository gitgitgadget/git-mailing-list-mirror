From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Replay on arbitrary branches
Date: Sat, 3 Sep 2005 14:17:30 +1200
Message-ID: <46a038f90509021917e0833a2@mail.gmail.com>
References: <46a038f905090218113587f64f@mail.gmail.com>
	 <7vwtlydisj.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 04:18:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBNbP-0001hw-6F
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 04:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVICCRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 22:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVICCRg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 22:17:36 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:37559 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932323AbVICCRf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 22:17:35 -0400
Received: by rproxy.gmail.com with SMTP id i8so446843rne
        for <git@vger.kernel.org>; Fri, 02 Sep 2005 19:17:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fkARpgKAW/7oFBwkou+UhbVgjkgYcYNpIOc+Vaa9dLCv9fJvClaIUMZbQGMhaglNz2tJiwb/bKoe06joZlU0jOJGBJkJmeHzTB6iGYm91e62xEVC34dw3x9GNVAFX/jljg3iBlOX2YUpoib6wa+Ss9fxxZfF80drAIV7toseM6U=
Received: by 10.38.75.68 with SMTP id x68mr49439rna;
        Fri, 02 Sep 2005 19:17:30 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 2 Sep 2005 19:17:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtlydisj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8033>

Agreed on the impossibility of 3-way merges with binary files. In the
branch I want to replay, though, I have commits that add and change
binary files.

> About 'unrelated' trees, if you know of a good tree you can use

<setup snipped>

>     $ git-read-tree -m -u c master b
>     $ git-merge-cache -o git-merge-one-file-script -a
> 
> If the resulting tree looks reasonable, you could now commit it
> telling 'git-commit-tree' that the parents of the new commit are
> master and b, and you practically merged two projects.

Cool! I think this is what I was looking for. The call to
git-read-tree will act as if A and B had branched off at tree "C".
I'll have to read the doco on git-read-tree and git-merge-cache a bit
more to feel comfortable with this voodoo, but it's great.

cheers,


martin
