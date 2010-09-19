From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Adding a commit message to the index
Date: Sat, 18 Sep 2010 18:29:01 -0700
Message-ID: <7AA1261F-8DDD-4599-9A11-753334634DB2@gmail.com>
References: <3347.4c955dd6.4a79e@getafix.xdna.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Cameron Hutchison <lists@xdna.net>
X-From: git-owner@vger.kernel.org Sun Sep 19 03:29:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox8iN-0000lI-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 03:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab0ISB3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 21:29:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46681 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab0ISB3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 21:29:04 -0400
Received: by pxi10 with SMTP id 10so881649pxi.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=bfdxvvdv/lly0/z7JtQVql5I6Ewd/6iED/PVm7w3ZMg=;
        b=Jg6tEHNSk+xhlpFW3yH2Np5XHs3e0o7hNkTlATDCStfdTGoI3fuTaOBraZ9b5tgY2m
         PsSEycxbgaBddP8Bz+5qNI5fPjPljQc4eiejyApO9maQ28CkCwLZ+mhesHMevU+zdMsE
         dWpZgdyuEW/rfcJMxiK7fiLBMsLr4tuvJI7Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=TldLYim6SDh9NcaVnPlCRQMqfjTqrB4XZpDnh1aVGz1LK5coChaeyKXCnYG5pv9g+K
         r45bXrPdiMYQUmRC22tWLql99CBk9oDnAH5AEjSPwG4e2Ga2Q2knSHEQW7YR2uQlGW72
         AnJzqTrcqFxfeS/J4qY8I50JFmJlWILYuMaoI=
Received: by 10.142.248.9 with SMTP id v9mr5939072wfh.250.1284859744035;
        Sat, 18 Sep 2010 18:29:04 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id e12sm6507416wfh.13.2010.09.18.18.29.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 18:29:03 -0700 (PDT)
In-Reply-To: <3347.4c955dd6.4a79e@getafix.xdna.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156483>

On Sep 18, 2010, at 5:48 PM, Cameron Hutchison wrote:

> Is it possible to add a commit message to the index, and have it  
> used as
> the final commit message, or as the template for the final commit
> message?
>
> Witnessing AKPM's ongoing efforts on linux-kernel to get better commit
> messages out of people, it seems it would be beneficial to be able to
> stage a commit message and refine it over the course of the  
> development
> of the commit. The first cut is rarely the best, so being able to  
> refine
> a commit message as one can refine a commit by incrementally using the
> index seems like a good idea.

One of the reasons for having a local repo is so you can check in work  
in progress without committing it to public history.

If you're ready to write a commit message, then make a commit.  You  
can refine it incrementally with `git commit --amend`.

Also, consider making multiple fine-grained commits, and then use  
interactive rebase to squash them into fewer larger commits (and edit  
commit messages) as appropriate.  It's a lot easier to squash fine  
commits than to split course ones.

To summarize:  Commit first, answer questions later.

Josh
