From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: add setup instructions for Travis CI
Date: Mon, 02 May 2016 10:21:53 -0700
Message-ID: <xmqqoa8ov0i6.fsf@gitster.mtv.corp.google.com>
References: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com>
	<1462176732-5163-1-git-send-email-larsxschneider@gmail.com>
	<vpqwpncq1zx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org, sbeller@google.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 02 19:22:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHXl-0007nR-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbcEBRV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:21:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754224AbcEBRV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:21:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BE64517FDD;
	Mon,  2 May 2016 13:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lOiXIIWamv0+XmUtoWuHkZcfLX8=; b=kRtG5g
	erQ8WKyGaMaVkMzbAkaK8ztpDC9PkXhEycKO1570f8SkPUTy2NIGYmDhT2JIcunw
	f8Oud5sypxY34kW40Z2+uEKIWGSGHNVx8CCRIa3UKTkAlI+/syqlazPSYKrhMLEP
	5pQZql4qXoMUBotkSnvc9C5mDPXiFq2TvcMzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lXGq857iArYiDzipABTPs5mhyYsunWhl
	eKJ52aZ7zkUk+Dndk7sZTQjQF6oM/qOpJ4JPQMkXh/MtI3wS3RSnCB7SiW0SqVrw
	CC8tt75n6dEB5RdjhsCn473ak67KfugMo/ScG9acRbzVbPQj4E70OOrNdXZNlYtg
	tu93hhUBM20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B684E17FDC;
	Mon,  2 May 2016 13:21:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E266317FDB;
	Mon,  2 May 2016 13:21:54 -0400 (EDT)
In-Reply-To: <vpqwpncq1zx.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	02 May 2016 10:48:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DF789E4-108A-11E6-8A88-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293244>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> larsxschneider@gmail.com writes:
>
>> +on open source projects), you can use their Travis CI integration to
>> +test your changes on Linux, Mac, and (hopefully soon) Windows.  See
>
> Nit: I'd write Linux, Mac (and hopefully soon Windows). Doesn't deserve
> a reroll IHMO.
>
> Other than that, the patch looks good to me.

Thanks; I can do two replacements in place ;-)
