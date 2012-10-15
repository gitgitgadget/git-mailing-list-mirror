From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Mon, 15 Oct 2012 13:58:46 +0200
Message-ID: <003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de> <507BF0EA.7000805@viscovery.net> <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de> <507BF8FE.1060502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:59:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjKP-0004HT-PH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab2JOL7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:59:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50191 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab2JOL7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:59:14 -0400
Received: from DualCore (dsdf-4d0a1987.pool.mediaWays.net [77.10.25.135])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lwnl2-1TPfC13PqK-016npU; Mon, 15 Oct 2012 13:59:11 +0200
In-Reply-To: <507BF8FE.1060502@viscovery.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSAptEk9IBw7/mtgF+OhWNAdUX+SOW3leCIA==
Content-Language: de
X-Provags-ID: V02:K0:qLxLIr3ar0rBHW0zITyf8xWVH2Rw0MoiY0t+72nvdUn
 09SQHCrTlygb15Q/TYtlOITrY/afa0wf57yACdJ7RRNf+P1o7B
 bBC6/wdAhqH16zOZmSTK3F6EfHGmTamfe999LlAe+b3HzPWvbY
 LixlU16Vf9fxmBPYQxpV++/hDQwXVgi///52+wjEFkn+cn71Wn
 /GNtWjnDmYUSc2tm//1BiUxQJP0NwIOdY5GQM8o39ku/Tn/KFh
 3l6WvxF7A8rCNe9buvKHR7UjMlBnMbzfxsWuW2Jp033vYbwxMK
 rbahX8niBSDo2LuCyXDaXmc0WDnneVIukbVA9bXftf8VP7ONZT
 WK7Go5nXiKlLWk2XRI1t7VXBDGrGhK2lTSuUr5wbZ2fvxj26RP
 ZSDaVGctMrGrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207741>



> -----Original Message-----
> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Monday, October 15, 2012 1:53 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: make test
> 
> Am 10/15/2012 13:37, schrieb Joachim Schmitz:
> > ...
> > + eval '
> >         find .git/objects -type f -print >should-be-empty &&
> >         test_line_count = 0 should-be-empty
> > '
> > ++ find .git/objects -type f -print
> > ++ test_line_count = 0 should-be-empty
> > ++ test 3 '!=' 3
> > +++ wc -l
> > ++ test 0 = 0
> > + eval_ret=0
> 
> This is the key line. If it is 'eval_ret=1' (or other non-zero value),
> then the test failed, and the lines above it usually indicate where in the
> test snippet the failure occurred.


...
++ mkdir failing-cleanup
++ cd failing-cleanup
++ cat
++ chmod +x failing-cleanup.sh
++ test_must_fail ./failing-cleanup.sh
+ eval_ret=1
+ test -z t
+ test 1 = 0
+ test -n ''
+ test t = t
+ test -n ''
+ return 1
+ test_failure_ 'tests clean up even on failures' '
...

This part?
