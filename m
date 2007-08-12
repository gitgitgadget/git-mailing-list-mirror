From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 13:33:28 +0200
Message-ID: <7C233CA0-D6A4-42F2-B072-B04B1874D991@zib.de>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com> <46BED5AA.7050900@lsrfire.ath.cx>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 12 13:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKBia-0004Q2-Pu
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 13:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760997AbXHLLeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 07:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760837AbXHLLep
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 07:34:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:45387 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759276AbXHLLep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 07:34:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CBWfiv026985;
	Sun, 12 Aug 2007 13:34:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CBWeaV004011
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 13:32:40 +0200 (MEST)
In-Reply-To: <46BED5AA.7050900@lsrfire.ath.cx>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55677>


On Aug 12, 2007, at 11:40 AM, Ren=E9 Scharfe wrote:

>
> git diff passes the output through your pager by default, so you =20
> see the
> exit code of that instead of diff's.  Set PAGER=3Dcat or redirect the
> output to /dev/null to get rid of it.
>
> A test case for diff would be nice regardless, though. :)

Which is not that easy, because of the redirections done
by test-lib.sh. I think git-diff needs a tty to exhibit
the wrong behaviour, which it doesn't get from test-lib
if run in standard mode (non verbose).

I tried to write a test case once, but after it got more
and more complex, I was too lazy to complete it.

	Steffen