From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/22] builtin/blame.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:22:41 -0800
Message-ID: <xmqqio17cr66.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-3-git-send-email-pclouds@gmail.com>
	<xmqq7fhofyt0.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BvpcwVQuk+kYxCCNcwhQYm1COwpajQamC9z32khMGMVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:22:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaST7-00028q-2O
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbcB2SWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:22:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753340AbcB2SWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:22:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5B3D47039;
	Mon, 29 Feb 2016 13:22:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Z+V9WktLhny
	3S51DgIEoF82+MU=; b=fEyTjhAQmlTu7+XPIGfHWTZepbh1C6zolpfDhDuLHtIC
	yZiLMYEOgYLYHUyD/d0i4dASeJ1CgeRLZdUeaE7DiCLzpgDVluLrXJKrHH/HztG2
	bmDlcBaP8DmvhuOi2MlvT4NHyCs3XOCOQSV9DDL/k03S4E41onZBO//U3hlp+BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ygkM9l
	tvdSWm8RX+0lqBlH/Zjz3OVrFHYuVrVtK21bv7FAS6mUUQZjCtvYPrkw41T4HCs6
	WMz2tNX50FfHOOE0ckNVVbIOi497xu4otl/cMClhf0BFaw4c1jNlg9J44ccy2qXZ
	jQBIizt72610oFI0Arc3haHlOmRn+i2DE1RWg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBEE247038;
	Mon, 29 Feb 2016 13:22:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3571C47037;
	Mon, 29 Feb 2016 13:22:42 -0500 (EST)
In-Reply-To: <CACsJy8BvpcwVQuk+kYxCCNcwhQYm1COwpajQamC9z32khMGMVA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 29 Feb 2016 07:33:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BE5A00E-DF11-11E5-A48C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287856>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Feb 29, 2016 at 1:57 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  builtin/blame.c | 58 ++++++++++++++++++++++++++++-----------------=
------------
>>>  1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> I think most of the strings we see here are not new ones introduced
>> in this cycle.  I doubt it is a good idea to disturb the codebase,
>> distract ourselves and adding last-minute workload to translators
>> with this during the pre-release period.
>
> Yes, it's ok to consider this series a new topic, to be graduated aft=
er 2.8.0.

I wasn't talking about the whole topic, but 02/22 did not look
suitable for the pre-release fix.
