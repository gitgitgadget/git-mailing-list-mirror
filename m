From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 20:24:16 +0200
Message-ID: <20080725182416.GG27172@leksak.fem-net>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net> <7vvdytsu7n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRyq-00084v-VJ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYGYSY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYGYSY1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:24:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:35975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbYGYSY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:24:26 -0400
Received: (qmail invoked by alias); 25 Jul 2008 18:24:25 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp044) with SMTP; 25 Jul 2008 20:24:25 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX193saoKzCR3uUDOS+FaVaXCtYjALhlDZI3XoFOTAh
	21m+3LDtaqtany
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMRxg-000478-VL; Fri, 25 Jul 2008 20:24:16 +0200
Content-Disposition: inline
In-Reply-To: <7vvdytsu7n.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90084>

Hi,

> diff --git a/Makefile b/Makefile
> index b003e3e..1d14209 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1212,6 +1212,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  
>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>  	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
> +	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
>  
>  ### Detect Tck/Tk interpreter path changes
>  ifndef NO_TCLTK

But then TAR has to be set in test-lib.sh also, to be able to
invoke t5000 and t4116 directly, hasn't it?

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
