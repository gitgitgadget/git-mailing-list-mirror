From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 23:54:43 +1000
Message-ID: <2cfc4032050419065472ef3db0@mail.gmail.com>
References: <20050416233305.GO19099@pasky.ji.cz>
	 <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org>
	 <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com>
	 <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz>
	 <1113905110.1262.1.camel@nosferatu.lan>
	 <20050419105008.GB12757@pasky.ji.cz>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNt7f-0004eF-9U
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 15:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDSNyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVDSNyq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:54:46 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:33383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261527AbVDSNyo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 09:54:44 -0400
Received: by rproxy.gmail.com with SMTP id j1so1208209rnf
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 06:54:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WM5uBheDzB+yhyBS/nEVzlVqFoUgkFaZ/1KPpfGs+DJ//KPbguk3VE9RHgsNQSEL+TomAhtFVdtRO9DbJySNQUcMdkOYfyL7MhK215VQ+DwSgY7ufzLGH7pg+cpLTqKPjmXW7ea11DX4CqVmc0QcM9XA4h3vBVZ0Gr7G2Pg9CpI=
Received: by 10.38.66.58 with SMTP id o58mr766681rna;
        Tue, 19 Apr 2005 06:54:43 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Tue, 19 Apr 2005 06:54:43 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419105008.GB12757@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I disagree. This already forces you to have two branches (one to pull
> from to get the data, mirroring the remote branch, one for your real
> work) uselessly and needlessly.
> 
> ...
> These naming issues may appear silly but I think they matter big time
> for usability, intuitiveness, and learning curve (I don't want git-pasky
> become another GNU arch).
> 


Not that it is worth that much, but my $0.02 is that Petr is right on
this one. I want something that allows me to get the objects into my
local repository without funking with my working directory.

As a long time CVS user, "git update" would do what I expect it to. I
don't have any pre-conceptions about what "pull" does, so it doesn't
phase me if pull is used for this purpose. However, perhaps pull means
something in some other SCM that would cause confusion for others?

Some alternatives to "pull" are offered: hoard, gather, make-local, download.

Regards,

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
