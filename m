From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Mon, 15 Oct 2012 15:18:19 +0200
Message-ID: <004001cdaad7$8bb72aa0$a3257fe0$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net>	<003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>	<507BF0EA.7000805@viscovery.net>	<003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>	<507BF8FE.1060502@viscovery.net>	<003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>	<507BFD03.7060208@viscovery.net> <m2mwznrk0c.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Andreas Schwab'" <schwab@linux-m68k.org>,
	"'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 15:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNkZP-0004Di-QX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 15:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab2JONSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 09:18:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab2JONSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 09:18:48 -0400
Received: from DualCore (dsdf-4d0a1987.pool.mediaWays.net [77.10.25.135])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M7EPO-1Taca42eog-00wK5e; Mon, 15 Oct 2012 15:18:42 +0200
In-Reply-To: <m2mwznrk0c.fsf@igel.home>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSAptEk9IBw7/mtgF+OhWNAdUX+SMA3Fi1dgIPN99PAv5kh3iWrx62YA==
Content-Language: de
X-Provags-ID: V02:K0:kl97gzIZFNqqPR5gJq08UDp9GsgL2stwdcbjQVfTRJV
 Jf43cz/J4oFFvdLJgZzX40VQA8gv9BfWhh5vt24oMEdbGy4oEE
 vJkG9s3qQLAaRPgz8cB2sWNTHP06Fiyp6l7x1Sk++ie7ybhA/m
 iyq/5jBaiS9i/seQLId+ifzqvZ1lr0xklR/PLmwoYuRh2jnhHw
 nic+CwXdQH9hrVcJ25nOTKszftow65DP6yjuf81/l/bGuloJn1
 Qnughcm9eAzlc5fsgriJswxE/5dspWAVRxhUSI+RP6tNFjblpN
 t/We/bkDY7jourUvxBh84KqApmKBGNhHmLgURaC1TaRmjz3Uhb
 mCWvxdKciw2upO1hy75nz4HxgYnfLcpE/EskDJ/clJ2t6k4BK7
 M4Qxnf20lxr7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207745>

> From: Andreas Schwab [mailto:schwab@linux-m68k.org]
> Sent: Monday, October 15, 2012 2:35 PM
> To: Johannes Sixt
> Cc: Joachim Schmitz; git@vger.kernel.org
> Subject: Re: make test
> 
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Am 10/15/2012 13:58, schrieb Joachim Schmitz:
> >> ++ mkdir failing-cleanup
> >> ++ cd failing-cleanup
> >> ++ cat
> >> ++ chmod +x failing-cleanup.sh
> >> ++ test_must_fail ./failing-cleanup.sh
> >> + eval_ret=1
> >
> > I wonder why the log does not show the commands of function
> > test_must_fail.
> 
> That's because stderr is redirected.
> 

cat err
++ ./failing-cleanup.sh
++ exit_code=0
++ test 0 = 0
++ echo 'test_must_fail: command succeeded: ./failing-cleanup.sh'
test_must_fail: command succeeded: ./failing-cleanup.sh
++ return 1
