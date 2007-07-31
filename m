From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC (take 2) Git User's Survey 2007
Date: Tue, 31 Jul 2007 02:45:55 +0200
Message-ID: <200707310245.56077.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200707302256.38251.jnareb@gmail.com> <20070731003251.GW20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 02:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFfsH-0003vC-8s
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 02:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbXGaAqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 20:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbXGaAqE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 20:46:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:16665 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbXGaAqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 20:46:02 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2510338mue
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:46:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VG0TVZ/EtMqd0m2WGMRUNZb/ADJteIwGRcL2Gw5DXKuOVFUM1olJDRgNvna2Sb9nlzMjOKTdj8p3Q3R+jGiwALSQtPY7VoT6Kw7/2CrSTM1v2ccfirFm7ZkaJgRfeE62zZBiXvLXSvl2IlZmjOntPWz2ypPb68KhNxJM0dYGPYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iof7G34OJEEw89Tfp5OitLfBuiWe9zCL/J3SavUu88/0izMIMpE5n+4msNbIJ3Rj51+wq3gD8keI4BKIf6S1PPK60SooIKKJE6laqQ8cPE4wwxJ5MIhyelpNhFkuYGdLxx3ctVQp9iUdnMUR9161PkH/souNZgMg2PdEjjH+TgM=
Received: by 10.86.28.5 with SMTP id b5mr4312358fgb.1185842759385;
        Mon, 30 Jul 2007 17:45:59 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p9sm1596779fkb.2007.07.30.17.45.57
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2007 17:45:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070731003251.GW20052@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54298>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > How you use GIT
> > 
> >     8. Which porcelains do you use?
> >        (zero or more: multiple choice)
> >     -  core-git, cogito, StGIT, pg, guilt, egit (Eclipse), other
> >     9. Which git GUI do you use
> >        (zero or more: multiple choice)
> >     -  gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
> >        (h)gct, qct, KGit, other
> 
> I'll give you git-gui as a GUI here instead of a porcelain.
> 
> But I *seriously* object to calling egit a porcelain.  egit is a
> complete reimplementation of git in Java.  Calling it a porcelain
> is wrong.  Robin, David and myself have put a considerable amount
> of effort into keeping egit 100% pure Java, so it is Write Once,
> Test Everywhere.
> 
> The _only_ code that egit has borrowed from core Git has been the
> packfile delta decompressor.  Everything else is a reimplementation.
> Just not 100% blackbox, as the egit developers have looked at the
> core Git source before.  Heck, we have even been known to contribute
> a patch here or there to core Git.  :)
> 
> All of the other porcelains that you listed reuse the core Git
> plumbing and are thus true porcelain.  But egit doesn't.

O.K. I was not sure where to put egit (if put it at all). 
Implementations? Currently we have core-git in C, egit in Java (what is 
the progress report on this front?), and there was GSoC project of 
Git.NET (but it didn't start I think).

Do you want question about egit in the survey?

-- 
Jakub Narebski
Poland
