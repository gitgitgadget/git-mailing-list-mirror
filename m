From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: Re: git-clone fails with out of memory,malloc failed7
Date: Tue, 12 Feb 2008 23:22:19 +0530
Message-ID: <6bc632150802120952n2b6abbb4tea8cde0fddbf7a7c@mail.gmail.com>
References: <6bc632150802120757r5dbeee6bmed9ccde4ca6f40d2@mail.gmail.com>
	 <alpine.LFD.1.00.0802121218280.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOzJc-000625-3Y
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760635AbYBLRw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760318AbYBLRw0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:52:26 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:20327 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760267AbYBLRwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:52:25 -0500
Received: by el-out-1112.google.com with SMTP id v27so2045575ele.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8PR+3HW7d0tvmUJnhMZAC3cYYwHFAwzSISW19IXPy+Q=;
        b=eHQe3ZkhPPGuClLJFrZSzh1lMUe9iR8LLUEc7Z8dAHyrhe/7Lt1Y7BjW5gDFfbyMruiwz6CJ3uJAnMkTuO8Brrc1sd9mNLK1nbSEWE3QUWZfVowrtfYz6vV8jBQO1QpnpKxTbRR/BLcHa7oPk7k6m2V64oO2eVlFAg9G+Jz1TjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gkNywRO5ZkfDya00jMb1wiT7ZY4J/Phb4C8F1mZUUpJU73sed9aHdgc9xmTgiX/b3d6EJ4gMB1i7Gn90X/Jd4NFdROUPRk8fS+LiehvgTm0M44TOnxPldyKDh2k1dNWpiPjmEwxubwaokNOHinP5G0+2PB9zSCGLJX0rtdFgyRQ=
Received: by 10.142.127.10 with SMTP id z10mr1243785wfc.216.1202838739978;
        Tue, 12 Feb 2008 09:52:19 -0800 (PST)
Received: by 10.142.102.10 with HTTP; Tue, 12 Feb 2008 09:52:19 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802121218280.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73680>

[...]
>
> > Better if this is a known issue ?
>
> It is not.
>
> > isn't 1 GB of RAM enough for git???
>
> It is plenty sufficient with the repository you tried it on.
>
> > luser@helvella:/opt/repo/archive$ sudo git-clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb.git
> > [sudo] password for luser:
>
> Why do you use sudo to run git?

because I(as luser :) ) did not have write permissions in the
directory where I intend to clone the repo.
>
> > Initialized empty Git repository in /opt/repo/archive/linux-2.6-kgdb/.git/
> > remote: Counting objects: 712950, done.
> > remote: Compressing objects: 100% (124251/124251), done.
> > remote: Total 712950 (delta 591747), reused 708812 (delta 587713)
> > Receiving objects: 100% (712950/712950), 173.74 MiB | 40 KiB/s, done.
> > fatal: Out of memory, malloc failed7)
> > fatal: index-pack failed
>
> I just cloned the above repository with Git v1.5.4 with no problem at
> all, and index-pack never used more than 52 megs of actual memory.
>
> Puzzled.

me too.Thought it may be some git issue so reported.
Seems like it is once in a blue moon situation.
Nevermind, thanks for reply.

Cu,
    --Pradeep

-- 
Pradeep Singh Rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
