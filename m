From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 1/4] Simplify wildcards for match files to be ignored
Date: Fri, 10 Mar 2006 21:08:36 -0300
Message-ID: <200603110008.k2B08aCO004834@laptop11.inf.utfsm.cl>
References: <fonseca@diku.dk>
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 16:51:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpIy-0007wZ-Ay
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 16:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWCMPtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 10:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWCMPtx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 10:49:53 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19139 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751483AbWCMPtx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 10:49:53 -0500
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k2DFnDl7025134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Mar 2006 11:49:38 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id k2B08aCO004834;
	Fri, 10 Mar 2006 21:08:37 -0300
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: Message from Jonas Fonseca <fonseca@diku.dk> 
   of "Fri, 10 Mar 2006 15:43:08 BST." <20060310144308.GB7920@diku.dk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 13 Mar 2006 11:49:38 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17568>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> 
> ---
> 
>  Documentation/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3aad2fb..661c259 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,4 +1,4 @@
> -CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej ../cg-*.in)
> +CG_IGNORE=$(wildcard ../cg-X* ../cg-*.*)

Nope. Better be specific in what you delete. It is not exactly
performance-critical...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
