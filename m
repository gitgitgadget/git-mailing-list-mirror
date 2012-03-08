From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Thu, 08 Mar 2012 18:46:18 +0100
Message-ID: <4F58F06A.1070108@lsrfire.ath.cx>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com> <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com> <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <4F57D18B.5090506@lsrfire.ath.cx> <7vzkbskr71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hQ5-0003lQ-41
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab2CHRqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 12:46:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:39050 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab2CHRqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:46:24 -0500
Received: from [192.168.2.105] (p579BE4A1.dip.t-dialin.net [87.155.228.161])
	by india601.server4you.de (Postfix) with ESMTPSA id 560B32F8037;
	Thu,  8 Mar 2012 18:46:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vzkbskr71.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192623>

Am 07.03.2012 22:59, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> Am 05.03.2012 22:34, schrieb Junio C Hamano:
>>
>>> +#define util_as_int(elem) ((intptr_t)((elem)->util))
>>
>> Something that actually returns an int would fit the name better. ;)
>
> The particular type would not matter to the callers of the helper
> macro, would it?

Three of the five callers introduced in that commit cast the result to=20
int and the remaining two don't care, so it actually does seem to matte=
r=20
for most of them, strictly speaking.  When I see a nit, I can't resist=20
the urge to pick it, apparently.

Ren=C3=A9
