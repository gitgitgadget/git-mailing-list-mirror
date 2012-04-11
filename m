From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Wed, 11 Apr 2012 23:51:27 +0200
Message-ID: <4F85FCDF.9040207@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl> <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl> <7vfwcakvfw.fsf@alter.siamese.dyndns.org> <7vbomykv6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5Rz-0007Oz-3k
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761177Ab2DKVve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:51:34 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34700 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756217Ab2DKVvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:51:33 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI5Rs-0007s4-JH; Wed, 11 Apr 2012 23:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <7vbomykv6x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195270>

On 04/11/2012 07:57 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>>
>>> +error_message () {
>>> +	(cd clone&&
>>> +	 test_must_fail git rev-parse --verify "$@")
>>> +}
>>> ...
>>> +test_expect_success 'branch@{u} error message when no upstream' '
>>> +	cat>expect<<-EOF&&
>>> +	error: No upstream branch found for ${sq}non-tracking${sq}
>>> +	fatal: Needed a single revision
>>> +	EOF
>>> +	(cd clone&&
>>> +	 test_must_fail git rev-parse --verify non-tracking@{u}) 2>actual=
&&
>>
>> Why not use "error_message" as other new tests?
There _was_ some reason, in some earlier version of the patch, but now =
it
is gone. Will use error_message.

> I think the remainder of the message should be ignored.  Will comment=
 on
> individual steps.
>
> Thanks.
I'll try to improve the description in first patch to not confuse peopl=
e :)

Thanks,
Zbyszek
