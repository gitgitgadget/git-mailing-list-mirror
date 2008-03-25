From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] test_must_fail: 129 is a valid error code from
 usage()
Date: Tue, 25 Mar 2008 11:01:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803251100520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241502.21465.barra_cuda@katamail.com> <7vwsnrubmd.fsf@gitster.siamese.dyndns.org> <200803242218.44026.barra_cuda@katamail.com> <7vbq53nvaz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5zF-0004Pg-6J
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYCYKBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYCYKBq
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:01:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:36815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752660AbYCYKBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:01:45 -0400
Received: (qmail invoked by alias); 25 Mar 2008 10:01:43 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 25 Mar 2008 11:01:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193pI0iUpx3UBL//G6AH57Za5IBrFm+qLYCtAt85q
	rrHGVZUXtZaEqf
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbq53nvaz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78168>

Hi,

On Mon, 24 Mar 2008, Junio C Hamano wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 870b255..7c2a8ba 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -300,7 +300,7 @@ test_expect_code () {
>  
>  test_must_fail () {
>  	"$@"
> -	test $? -gt 0 -a $? -le 128
> +	test $? -gt 0 -a $? -le 129

IIRC exit status is a signed byte on Win32.  Can somebody check?  I'll be 
in a hurry in 1.5 hours and travelling for two days.

Ciao,
Dscho
