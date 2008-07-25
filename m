From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 20:58:18 +0200
Message-ID: <20080725185818.GA13539@leksak.fem-net>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net> <7vvdytsu7n.fsf@gitster.siamese.dyndns.org> <20080725182416.GG27172@leksak.fem-net> <7vmyk5sska.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSVk-0003Lk-S2
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYGYS63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYGYS63
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:58:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750878AbYGYS62 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:58:28 -0400
Received: (qmail invoked by alias); 25 Jul 2008 18:58:26 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 25 Jul 2008 20:58:26 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/sNxRr2aPsI8qCdRkHJ1zXgbJeO8ll/XkkLlCVUV
	MFve2jJTxkmv9G
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMSUc-0003Zc-1a; Fri, 25 Jul 2008 20:58:18 +0200
Content-Disposition: inline
In-Reply-To: <7vmyk5sska.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90089>

Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> >> diff --git a/Makefile b/Makefile
> >> index b003e3e..1d14209 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1212,6 +1212,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
> >>  
> >>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
> >>  	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
> >> +	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
> >>  
> >>  ### Detect Tck/Tk interpreter path changes
> >>  ifndef NO_TCLTK
> >
> > But then TAR has to be set in test-lib.sh also, to be able to
> > invoke t5000 and t4116 directly, hasn't it?
> 
> Dosen't test-lib source GIT-BUILD-OPTIONS?

It does.  Great, then.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
