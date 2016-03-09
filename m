From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Tue, 08 Mar 2016 16:32:19 -0800
Message-ID: <xmqq7fhcjxt8.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	<xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AgPQ__aVgoJc860yapWs_rTbXfBuGSBNRG-FT+v+rK1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 02:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adSha-0004IH-BX
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 02:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbcCIBN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 20:13:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752246AbcCIAcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:32:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A47F4BD4B;
	Tue,  8 Mar 2016 19:32:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nzzS9NUMXUTEjs8okrxNsIquwkU=; b=xpp0F0
	exvyMjpUUmaStONIDrzQwOxMoceNyEp++oCHC4Yr8UPPIsHnlaulmaWTFyOM5nuG
	q88SpJE0Tm1bAgTlmQ772UM2LR5m9RuGZLNpo1xhPF6C++2YyzTd2/Bg8yvBGbtW
	Ptc7KOIK2VXZX70fBxuy7EP1eBAvQ9+5Seb44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gpu1IaXvnT71/SzhX8zeBTsPTwIYpTOk
	svTrOrpkrCW83w3P0sYhtrrtCb6Ud+CDuNSyUt11CrG0lMRTulCecvttDQQtxic1
	zxsHVXbjs0COsppMLSXCd1UVgO+uRpBNU6ajxjXeM2UJKxN+VqU69YjpwwP1OEbl
	GN7wSz355hw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8184E4BD49;
	Tue,  8 Mar 2016 19:32:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E532B4BD48;
	Tue,  8 Mar 2016 19:32:20 -0500 (EST)
In-Reply-To: <CACsJy8AgPQ__aVgoJc860yapWs_rTbXfBuGSBNRG-FT+v+rK1w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 9 Mar 2016 07:18:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 62BFAD34-E58E-11E5-8060-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288469>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 9, 2016 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> So what do we want to do for the upcoming release?
>
> I don't know. Befoire 2.8.0, all three matching cases are broken. With
> the current changes on 2.8.0, one case is fixed with the other cases
> broken. I guess it can create even more confusion. Yeah documentation
> helps a bit.
>
>> I am OK to leave
>> the code as-is for now and describe it as a known bug that is still
>> being worked on (as long as it indeed is being worked on, that is),
>
> I do want to fix it. I don't know how much code is impacted yet (and
> how many more bugs I'll be introducing while attempting to fix it). It
> may take a few cycles before the fix can be released.

Sorry, but I should have been more clear.  At this point in the
release cycle, I do not think it is an option to pile on more
"fixes" to risk destabilizing the end-user experience even more
before 2.8.0 final happens.

It is between (1) the current code is good enough that with a
(temporary) limitation clearly described in the documentation users
can work around the implementation deficiency and get a benaviour
that is closer than 2.7.2, or (2) the half-way implementation we
have does not give enough advancement toward the final goal
(i.e. the !dir re-inclusion behaves consistently with the dir
that ignores the whole thing underneath, while allowing subpaths
ignored with follow-on entries in the same .gitignore file), and we
are better off reverting the whole thing to go back to 2.7.2
behaviour, planning to do a better job in the next cycle.

I was hoping that (1) would be the case.
