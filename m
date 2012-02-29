From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/3] parse-options: disallow --no-no-sth
Date: Wed, 29 Feb 2012 19:06:10 +0100
Message-ID: <4F4E6912.7060204@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx> <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org> <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org> <4F4BC3B3.7080000@lsrfire.ath.cx> <7vzkc457g3.fsf@alter.siamese.dyndns.org> <4F4D3545.6060704@lsrfire.ath.cx> <7vlinmy80x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2nuz-0006k5-3r
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992Ab2B2SGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 13:06:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:38353 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642Ab2B2SGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 13:06:20 -0500
Received: from [192.168.2.105] (p579BEC5C.dip.t-dialin.net [87.155.236.92])
	by india601.server4you.de (Postfix) with ESMTPSA id 504922F8039;
	Wed, 29 Feb 2012 19:06:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vlinmy80x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191838>

Am 28.02.2012 22:15, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> Now that options whose definition starts with "no-" can be negated
>> by removing said "no-", there is no need anymore to allow them to
>> be negated by adding a second "no-", which just looks silly.
>
> Thanks.  But accepting them silently and do what the user would have
> expected, especially if we do not advertise it, would not hurt anybod=
y,
> no?

Yes, that's why I didn't include this fourth patch from the beginning.=20
However, I understood your comment "Among the existing 13 that you
listed, I do not think there is any that tempts any existing user to as=
k
for negation with "--no-no-foo" form, so I think we should be Ok." to=20
mean that nobody uses the double-no form of the existing negative=20
options anyway, and therefore we should disallow it.

Please drop this extra patch if I misunderstood you, in order to keep=20
backward compatibility.

Ren=C3=A9
