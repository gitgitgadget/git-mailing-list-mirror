From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Tue, 06 Oct 2015 08:32:13 +0200
Message-ID: <vpqr3l8pkwi.fsf@grenoble-inp.fr>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
	<561351FD.9020102@web.de>
	<xmqqoagcwocp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 08:32:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjLnv-0004Rn-7k
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 08:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbbJFGcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 02:32:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50862 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbbJFGcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 02:32:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t966WD4t020867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 6 Oct 2015 08:32:13 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t966WDxr014104;
	Tue, 6 Oct 2015 08:32:13 +0200
In-Reply-To: <xmqqoagcwocp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 05 Oct 2015 22:35:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Oct 2015 08:32:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t966WD4t020867
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444717938.52613@y7ediULC+QVIwvDFNfczBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279122>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=F6gershausen <tboegi@web.de> writes:
>
>> On 06.10.15 00:59, Junio C Hamano wrote:
>>> * gr/rebase-i-drop-warn (2015-10-02) 2 commits
>>>  - rebase-i: loosen over-eager check_bad_cmd check
>>>  - rebase-i: explicitly accept tab as separator in commands
>>>=20
>>>  "git rebase -i" had a minor regression recently, which stopped
>>>  considering a line that begins with an indented '#' in its insn
>>>  sheet not a comment, which is now fixed.
>>>=20
>>>  Will merge to 'next'.
>> This is breaking using a non-gnu sed, which doesn't handle "\t"...
>
> Thanks for catching this, and the other one in the stalled section,
> before they hit 'next'.
>
>> The solution is to replace "\t" with a literal TAB.
>
> Obviously correct ;-)  Will squash in.

Indeed. Thanks.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
