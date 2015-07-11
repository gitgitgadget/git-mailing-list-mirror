From: X H <music_is_live_lg@hotmail.com>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Sun, 12 Jul 2015 00:21:33 +0200
Message-ID: <BLU437-SMTP311678316C434857657D6BF69E0@phx.gbl>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net> <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net> <20150708183331.GA16138@peff.net>
 <559D9006.20102@kdbg.org> <559EDEE6.1040807@kdbg.org>
 <20150709224830.GA24998@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 00:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE39P-0007J1-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 00:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbbGKWVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2015 18:21:30 -0400
Received: from blu004-omc3s3.hotmail.com ([65.55.116.78]:50786 "EHLO
	BLU004-OMC3S3.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbGKWV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2015 18:21:29 -0400
Received: from BLU437-SMTP31 ([65.55.116.74]) by BLU004-OMC3S3.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Sat, 11 Jul 2015 15:21:28 -0700
X-TMN: [csZHCP2sNf1mgc+X8ykGvRUaD/CRWnhb]
X-Originating-Email: [music_is_live_lg@hotmail.com]
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <20150709224830.GA24998@peff.net>
X-OriginalArrivalTime: 11 Jul 2015 22:21:27.0118 (UTC) FILETIME=[EDAF4EE0:01D0BC27]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273877>

Le 10/07/2015 0:48, Jeff King a =C3=A9crit :
> On Thu, Jul 09, 2015 at 10:51:50PM +0200, Johannes Sixt wrote:
>
>>> Ah! That code is less than a year old. When I began to adopt a work=
flow
>>> requiring force-pushes lately, I wondered why I haven't seen these
>>> failures earlier, because I did do force pushes in the past, but no=
t
>>> that frequently. I thought that I had just been lucky. But this wou=
ld
>>> explain it.
>>
>> And, in fact, with this patch these particular failures are gone! Th=
ank you
>> so much!
>
> Great, thanks for testing. You can temper your appreciation by notici=
ng
> that I introduced the bug in the first place. ;)
>
> -Peff
>
Hi,

Thank you for the patch. I hope it will solve the problem and permit to=
=20
have a second user using the same repository.

How are the permission handled, is it git that is asking to create a=20
file read only or rw on the remote or is it the environment with umask=20
ans so on that decides it, or Windows when the drive is mounted with no=
acl?
