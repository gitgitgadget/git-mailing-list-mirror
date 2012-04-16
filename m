From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Tue, 17 Apr 2012 00:06:57 +0200
Message-ID: <4F8C9801.9030607@in.waw.pl>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki> <4F8C3E0F.2040300@in.waw.pl> <7vmx6bwqmj.fsf@alter.siamese.dyndns.org> <20120416212215.GA5351@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:07:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu4n-0005RZ-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071Ab2DPWHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 18:07:07 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34991 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab2DPWHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:07:06 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SJu4c-00018S-TF; Tue, 17 Apr 2012 00:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120416212215.GA5351@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195705>

On 04/16/2012 11:22 PM, Clemens Buchacher wrote:
> On Mon, Apr 16, 2012 at 10:09:08AM -0700, Junio C Hamano wrote:
>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>>
>>> So my patch was totally bogus, it was just probably changing the ti=
ming.
>>>
>>> Now your patches (on top of next):
>>> 'git-daemon wrapper to wait until daemon is ready' fixes the proble=
m, thanks!
>>>
>>> (I now see that they are both in pu: pu runs fine too.)
>>
>> Sorry, I think one of the "both" you mean is 7122c9e (git-daemon wra=
pper
>> to wait until daemon is ready, 2012-04-15), but which one is "the ot=
her
>> one" (which I should discard)?
>
> I believe he is referring to 1bcb0ab4 (t5570: use explicit push
> refspec), which is also necessary to run the tests on pu.
Exactly.

-
Zbyszek
