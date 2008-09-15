From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Tue, 16 Sep 2008 01:47:40 +0400
Message-ID: <20080915214740.GI28210@dpotapov.dyndns.org>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com> <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com> <bd6139dc0809151359i357987c5vb2544b1b5c99802f@mail.gmail.com> <48CED08F.5040602@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Pico Geyer <picogeyer@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfLwG-0005II-3Q
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 23:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYIOVrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 17:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYIOVrr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 17:47:47 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:56019 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbYIOVrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 17:47:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1193128gvc.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Tf80ikgYH/wGrzreIN00hSEnBp3wqbQwZQ5OlsY4eI=;
        b=dltoItu8N9DHLg84Q+0boKTM/yN5epqUs3OTfRGO7NiA23H+rbU6RSkDIjz18tJcS1
         eCz3TZbkSTeWts/IZPoQSBiCeEP8H/Emp6UFK7T3kVladLYXAZDJFb/mGEC8g6bP4YjR
         ch495uTBAlTlAz4+Uwaeknmt0v1WYdIj+Fk58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kP+AVdazTthZnXpZpgf71gt43pjNUKCCkmbKE2UCLrHAjRGdbnWFjMLmueZd7cqGKy
         w83uo2yjdBgSaYrLrMc8v8Ktjh4WMwYn9ktsST2v/0fvCxLmZkfNVZjG37JyPEp3O781
         2gnCXbysY4gvQvzehjUIXwOTcPaCFMaeuJaao=
Received: by 10.86.52.6 with SMTP id z6mr120628fgz.18.1221515264335;
        Mon, 15 Sep 2008 14:47:44 -0700 (PDT)
Received: from localhost ( [85.141.148.169])
        by mx.google.com with ESMTPS id 12sm15660062fgg.0.2008.09.15.14.47.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 14:47:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48CED08F.5040602@drmicha.warpmail.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95946>

On Mon, Sep 15, 2008 at 11:15:59PM +0200, Michael J Gruber wrote:
> Sverre Rabbelier venit, vidit, dixit 15.09.2008 22:59:
> > 
> > I thought this was fixed in a more recent version of git-svn? Didn't
> > it even work both ways?
> 
> Kind of. You can't fake a different author when committing to svn.

This is not exactly correct as you can fake author if you have the right
to change the svn:author property (or what is its name?), but by default
this is not allowed to anyone, and git-svn does not support this method
anyway.

> But
> "--add-author-from" makes dcommit embed the author in the svn commit
> message (if there's no from nor sob), and "--use-log-author" makes fetch
> look for that info and use it.

Yes, it works. And it is very useful especially you are going eventually
convert your SVN repository in Git (so all authorship information will
be retain). Probably, I should have mentioned this possibility.

Thanks,
Dmitry
