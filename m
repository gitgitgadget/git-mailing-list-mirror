From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/22] i18n and test updates
Date: Sun, 29 May 2016 17:03:01 -0700
Message-ID: <xmqqeg8kpg3u.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqq8tyvs9xf.fsf@gitster.mtv.corp.google.com>
	<57495473.2010903@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Mon May 30 02:03:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Aft-0005wD-ND
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 02:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbcE3ADH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2016 20:03:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752025AbcE3ADG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 20:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF9E52032A;
	Sun, 29 May 2016 20:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sQySIcawhS19
	RwPo+qf7bsEZmBs=; b=DPSyvQh3nTTnYBnNt/XETWyLsvJe1qPEf5JamirHFXYK
	FIhYJx5+Z3MQZhMfCIuG+iTlGMiMDYldAQafta6cJ4m1XsZCP4eOESSc3645m9w6
	MTV6DePdbTuRZYOPFoWOCFDAK4YO6O66C4pOUOsZUIph/2hkqbV7To1xgKpTz1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oIq9i4
	Yg7ypHLf7nEIa23frX8aavWvCelLcxSb9xAYmqtQ1g7nRGl6tnjXddQeaq3o9N+W
	Q+PEiwTQ7GTIz8XlTossWtr1xIbGocr0pPfm7TaSLRoslN4QPNOC42wxH50cDIJh
	bjTZ5D040Zban6kdXcdc6zTLZfp2rmPkVCMbY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E724B20328;
	Sun, 29 May 2016 20:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72E2F20327;
	Sun, 29 May 2016 20:03:03 -0400 (EDT)
In-Reply-To: <57495473.2010903@sapo.pt> (Vasco Almeida's message of "Sat, 28
	May 2016 08:18:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1204692-25F9-11E6-ABD9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295847>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> =C3=80s 17:11 de 27-05-2016, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>=20
>>> Marks several messages for translation and updates tests to pass un=
der
>>> GETTEXT_POISON. Some tests were updated to fit previous i18n marks,=
 others
>>> were updated to fit marks made by these patches. Patches that only =
touch
>>> test file refer to marks done in commits previous to these ones.
>>=20
>> Whew, this series is quite a lot of work.
>>=20
> Do you mean review work?

If I answered No to "Was it a lot of work to review it?", then I'd
be lying ;-)

But my comment was "Whew, it must have been a lot of work to prepare
this series; thanks for tackling the topic".
