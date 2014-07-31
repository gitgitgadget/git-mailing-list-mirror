From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] nd/multiple-work-trees follow-ups
Date: Thu, 31 Jul 2014 10:00:24 -0700
Message-ID: <xmqq7g2txy3b.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<xmqqr412zqdo.fsf@gitster.dls.corp.google.com>
	<CACsJy8AambnVfbchGrvV0rgN1JyzCXBGgJxbV8JD1BF1DeDdHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 19:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCtid-0002nv-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 19:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbaGaRAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 13:00:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50486 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbaGaRAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2014 13:00:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A202F2D0E9;
	Thu, 31 Jul 2014 13:00:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LDfSXnCjPOMu
	C/ogE7+PCAO4YTs=; b=S86JGhBsv8X5CWTEzLCestJTHzJPXK2A/yVvi2vdORhb
	DreLqjVA47rWCPSRNkhWWqn863yjwmZEHgxrZbkMJkbdmOwy2P8Zy8F75PLsmnPu
	0aSTsPzKA+N4YjXELlmAxAkjMc8aVhpVH9DbtdUCUgLnpi9K90XSG87dKuNZPMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mb2hSw
	JVeaTipmoZZMj8pUAEbKyBy+tcbCIAC6Dm4tfTfoeWn3yJr6oqL+jTH4uQ0RplO8
	wPIcnuC5/CmGn99lv2capAOx8wljXNuEM0/DMZwRyhrvQvsrQm8r4VEljzwWikGn
	aLkutUCcUlFCPiTGbUXSTeNi2ut0wHyLtH5m4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 951CF2D0E8;
	Thu, 31 Jul 2014 13:00:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F24C2D0CB;
	Thu, 31 Jul 2014 13:00:26 -0400 (EDT)
In-Reply-To: <CACsJy8AambnVfbchGrvV0rgN1JyzCXBGgJxbV8JD1BF1DeDdHA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 31 Jul 2014 17:13:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B4E25DE-18D4-11E4-8F1C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254592>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jul 31, 2014 at 12:51 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> The series has entered 'next' so I can't replace patches any more.
>>> Besides the brown paper bag fixes, checkout now rejects if a branch=
 is
>>> already checked out elsewhere.
>>
>> I do not think we would want to rush the entire series to 'master'
>> before the upcoming release, so we could squash these fixes into the
>> original when we rewind 'next' post release, if you wanted to.
>
> Great. Please remove it from next at the next rewind.

I'd likely forget so please remind me when the time comes ;-)  In
the meantime, I made a note in the "What's cooking" report to hold
the topic in 'next' and not advance it to 'master'.
