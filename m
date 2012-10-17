From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Wed, 17 Oct 2012 10:30:11 +0200
Message-ID: <002901cdac41$a0d381c0$e27a8540$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net>	<003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>	<507BF0EA.7000805@viscovery.net>	<003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>	<507BF8FE.1060502@viscovery.net>	<003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>	<507BFD03.7060208@viscovery.net> <m2mwznrk0c.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Andreas Schwab'" <schwab@linux-m68k.org>,
	"'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 10:30:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOP1k-0004L4-0T
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 10:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab2JQIao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 04:30:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab2JQIam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 04:30:42 -0400
Received: from DualCore (dsdf-4db5f37b.pool.mediaWays.net [77.181.243.123])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lm6Wf-1Ty0tA0LsP-00a6qk; Wed, 17 Oct 2012 10:30:38 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSAptEk9IBw7/mtgF+OhWNAdUX+SMA3Fi1dgIPN99PAv5kh3iWrx62YIAC0+dw
Content-Language: de
X-Provags-ID: V02:K0:BNtSN0YhTQ7S4pSm8TSeDx2+KrK1Vk0oLtLIf92jPVr
 oJXFoU6yx3yiPuG4xWXF2OTc2bOHxWJ1WvzkS9r/YFvyYiVPhJ
 2YWWSSCmGOq755CuNv7Kp4bGOH/9gp3J3nJDcHUWqKhK5A4Hlc
 IlfFIks/1gTKrSWSnPgVImR+mZw7nZc2/uEStu2JdOMsLj0MH9
 84apXhhEeiyHjlLNtnXtO7wwdAtkNYq6nfRTbce5ooWgelvS0y
 Aq/J8M/kpJ8Z+iq96N9SLJPt2PUp6yrJCcD612nOHv9WY/IptI
 XPM7wdw7bsZ+wuul06oQD0jCI1gaoBYsjnJS2ZyqmhFflDuXY4
 rQnUXiwOU+sBGNFAEWB//efl+lLXC3hJo/6NjYH0aoYS0Wyf37
 +icq7AYVg2Heg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207906>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Monday, October 15, 2012 3:18 PM
> To: 'Andreas Schwab'; 'Johannes Sixt'
> Cc: 'git@vger.kernel.org'
> Subject: RE: make test
> 
> > From: Andreas Schwab [mailto:schwab@linux-m68k.org]
> > Sent: Monday, October 15, 2012 2:35 PM
> > To: Johannes Sixt
> > Cc: Joachim Schmitz; git@vger.kernel.org
> > Subject: Re: make test
> >
> > Johannes Sixt <j.sixt@viscovery.net> writes:
> >
> > > Am 10/15/2012 13:58, schrieb Joachim Schmitz:
> > >> ++ mkdir failing-cleanup
> > >> ++ cd failing-cleanup
> > >> ++ cat
> > >> ++ chmod +x failing-cleanup.sh
> > >> ++ test_must_fail ./failing-cleanup.sh
> > >> + eval_ret=1
> > >
> > > I wonder why the log does not show the commands of function
> > > test_must_fail.
> >
> > That's because stderr is redirected.
> >
> 
> cat err
> ++ ./failing-cleanup.sh
> ++ exit_code=0
> ++ test 0 = 0
> ++ echo 'test_must_fail: command succeeded: ./failing-cleanup.sh'
> test_must_fail: command succeeded: ./failing-cleanup.sh
> ++ return 1

That test (as well as quite a few more) do pass when using bash rather than our sh (which really is a ksh)

Bye, Jojo
