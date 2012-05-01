From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH resend] diff --stat: use less columns for change counts
Date: Tue, 01 May 2012 17:24:49 +0200
Message-ID: <4FA00041.3070909@in.waw.pl>
References: <1335818338-3657-1-git-send-email-zbyszek@in.waw.pl> <7vobq8as95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	peff@peff.net, pclouds@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 17:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPEwp-00054e-A9
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 17:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab2EAPY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 11:24:58 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35773 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab2EAPY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 11:24:58 -0400
Received: from ip-78-30-104-79.free.aero2.net.pl ([78.30.104.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPEwi-0003NX-JF; Tue, 01 May 2012 17:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vobq8as95.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196686>

On 05/01/2012 04:30 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>> This resend applies and tests cleanly against both current next and =
pu.
>=20
> Thanks; will queue.
>=20
>> old diff-stat:
>>  Documentation/gitcore-tutorial.txt                 |    4 +-
>>  diff.c                                             |   48 +++++++++=
+++++++----
>>  t/t0023-crlf-am.sh                                 |    2 +-
>>  t/t1200-tutorial.sh                                |    4 +-
>>  t/t3404-rebase-interactive.sh                      |    2 +-
>>  t/t3903-stash.sh                                   |    2 +-
>>  t/t4012-diff-binary.sh                             |   19 ++++++++
>>  ...
>>
>> new diff-stat:
>>  Documentation/gitcore-tutorial.txt                 |  4 +-
>>  diff.c                                             | 48 +++++++++++=
++++++-----
>>  t/t0023-crlf-am.sh                                 |  2 +-
>>  t/t1200-tutorial.sh                                |  4 +-
>>  t/t3404-rebase-interactive.sh                      |  2 +-
>>  t/t3903-stash.sh                                   |  2 +-
>>  t/t4012-diff-binary.sh                             | 19 +++++++++
>=20
> Having said that, given the above miniscule differences, I am not rea=
lly
> sure if it is worth 2300+ lines worth of code churn, though.
Yeah, I understand that. So I leave it to your decision.

Thanks,
Zbyszek
