From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 14:05:26 -0400
Message-ID: <200610131805.k9DI5QDH016016@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: GIT Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 20:05:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYRPw-0006H8-9n
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 20:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWJMSFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWJMSFq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 14:05:46 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6588 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751780AbWJMSFp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 14:05:45 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9DI5RoR002747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Oct 2006 14:05:27 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9DI5QDH016016;
	Fri, 13 Oct 2006 14:05:26 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Thu, 12 Oct 2006 22:35:01 MST." <11607177024171-git-send-email-junkio@cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 13 Oct 2006 14:05:27 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28852>

Junio C Hamano <junkio@cox.net> wrote:
> This new option makes the resulting pack express the delta base
> with more compact "offset" format.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

[...]

> @@ -35,6 +35,12 @@ OPTIONS
>  	about people fetching via dumb protocols from it.  Use
>  	with '-d'.
>  
> +-b::
> +	Pass the `--delta-base-offset` to `git pack-objects`;
> +	see gitlink:git-pack-objects[1].  Do not use this option
> +	if you want the repository to be accessible by older
> +	versions of git.
> +

Need to tell which version is the cutoff (say before 1.4.3 won't work).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
