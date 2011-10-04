From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Tue, 04 Oct 2011 15:15:55 -0700
Message-ID: <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
 <20111003220659.GA19537@elie>
 <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Marcin =?utf-8?Q?Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 00:16:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBDHQ-0006Zo-G9
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 00:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276Ab1JDWP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 18:15:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab1JDWP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 18:15:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 801CC5133;
	Tue,  4 Oct 2011 18:15:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JQEPCn8jrI3i
	Q80GYCHcgerEJnA=; b=jez8f8G7mFxiUNmFT4NO7eVx5L+LARais8yfT/GMIHxo
	NdfpaOjek8CxvacaCjRI9zN4tS6abhEwhBw/NRRfBhMdX/PurbxMsBO2zGEE+XUF
	IKahOGcPB3Dq63uTTryCJ4Erc3RVZBZotJZ/6uHGtVl39vHm5Pd8DiTvMk+5MYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CYORWK
	doash5GCmg7yH2pWow1oZ5oyeQzGJUWz5Z1EfFB9gY40vAaS1a0TC34OQsGcIHBD
	ZQyfNoGNLR6X9Qmuw94o9zO+LbmQHD1SjcANWRZyITRP7MLhNbwqZBD295eYQRpi
	OQSTW5vsZdBUs0PcQGWiuOU0Ut5Wa1KlCcX/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E2B5132;
	Tue,  4 Oct 2011 18:15:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 017645131; Tue,  4 Oct 2011
 18:15:56 -0400 (EDT)
In-Reply-To: <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 4 Oct
 2011 23:58:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ECD619C-EED6-11E0-BCDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182809>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it's a bit too premature to try to plan this all ahead, why
> not just take patches to po/ and see what the friction points are,
> then address those as they arise?
> ...
>>  3. how can we avoid this making "git log -p" output unusable?

These two are somewhat mutually exclusive. I _suspect_ that Jonathan mi=
ght
have been hinting me to eject everything under the current po/ director=
y,
and bind that part of the tree as a submodule from another repository,
which would give us "git log -p" cleanliness automatically. Taking more
patches to po/ would not help that process, even though it won't hinder
it.
