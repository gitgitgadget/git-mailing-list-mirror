From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Mon, 06 Jun 2016 11:00:38 -0700
Message-ID: <xmqqinxmxkmx.fsf@gitster.mtv.corp.google.com>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
	<57511B2D.7040501@kdbg.org> <20160603094544.GA3865@Messiaen>
	<xmqq8tymqnj9.fsf@gitster.mtv.corp.google.com>
	<20160606072800.GA3803@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:00:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ypS-00079X-GF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbcFFSAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:00:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcFFSAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:00:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 63F9F22D12;
	Mon,  6 Jun 2016 14:00:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AI28ZRgn3pNauQ+0gBgDuwqM5uw=; b=X71Oam
	G4PXbBZXglAozFbQGZbc9fA+iFqDz6FcROTB5m/L5sHtisbpTkOlQglcOHGbr3gi
	5vIhUbiyXGcBBi5yxnP4h30/RTqaSofMAHls8TR0JdwgwDEGsQWJLWneOD8exhJb
	dsDXHOQy/pyVS4FWDnxji3lqSWWS4tWdXLnbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+zN3ZYz6ji4Eo0bgs5d3x93F5gq2g8f
	G0r+QvDTiwIG3jL1rNWvLQGL07y02X5JrbeIfuiKojOJPP5wa0BdHyN89P+xqcKr
	AiBO0QtHsN8SF9rtZWztp2aeABPmwvtSlG3lURAMbLx8Eu4+xqqOkCNYTDqKlB0t
	p1hmveg74No=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BC4222D11;
	Mon,  6 Jun 2016 14:00:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAEA322D0F;
	Mon,  6 Jun 2016 14:00:39 -0400 (EDT)
In-Reply-To: <20160606072800.GA3803@Messiaen> (William Duclot's message of
	"Mon, 6 Jun 2016 09:28:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94409E54-2C10-11E6-9128-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296544>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> On Fri, Jun 03, 2016 at 08:50:50AM -0700, Junio C Hamano wrote:
>> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
>> 
>> > Here I have to disagree (with you and Junio): the IPATTERN is
>> > case-insensitive only on the "pattern" regex, not the "word_regex"
>> > regex.
>> 
>> Ahh, OK.  Obviously both of us overlooked that.  Thanks for pushing
>> back.
>> 
>> > On the identifier line, I have "A-F" instead of "A-Z" though
>> 
>> Yeah, that does need updating.
>
> Note that I sent a V4 :)

Yup, thanks.  Isn't that what I queued as 0719f3ee (userdiff: add
built-in pattern for CSS, 2016-06-03)?
