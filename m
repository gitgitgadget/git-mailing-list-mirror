From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/22] i18n and test updates
Date: Fri, 27 May 2016 10:11:24 -0700
Message-ID: <xmqq8tyvs9xf.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 19:11:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LIN-0007V2-5w
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbcE0RL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:11:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932320AbcE0RL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:11:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D901DB37;
	Fri, 27 May 2016 13:11:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0rhLWmJ9Udu2s0ZPVAx2/wVlcU=; b=Lr3t5/
	jTSSVK7nDkGK+9cTl+1cOryL6TMqBygd36EHYqrh2yVxY9B1BvjlBVFQtNT8ZmDR
	gRzFW9qqleNQDXvEUkDith+bACIexlQrm3kZ0fv7lF5ggSGEPpbgLrvuV0tXpp7T
	rFjpZ9l5e15UZaNSNclFuCoIbKtrK8bsGveb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TU9HB6sNuC3GEHwUvk5VekdLtYRuP1ef
	jf7y+haeZlESfQhAsskAm5PXaKEWVgezlf54XTPqExOTgdBEMcxsI9pFVOZzuRjr
	NXvy7WAsfy296qwRTRMX6XhLAmU4m2glB5hg1A6X+RO9gD8aA90WI6U9ljzaMbYZ
	C2rFzVbu+U8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69BF51DB36;
	Fri, 27 May 2016 13:11:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D45901DB35;
	Fri, 27 May 2016 13:11:26 -0400 (EDT)
In-Reply-To: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Mon, 23 May 2016 19:27:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BF133EA-242E-11E6-A6B3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295771>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Marks several messages for translation and updates tests to pass under
> GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
> were updated to fit marks made by these patches. Patches that only touch
> test file refer to marks done in commits previous to these ones.

Whew, this series is quite a lot of work.

Most of the changes I only skimmed so if you had typos I wouldn't
have noticed them, but they looked good from my cursory reading.

I looked at the changes to scripted Porcelains more carefully than
other changes, and they all looked good (except for the parts I sent
reviews separately for).

Thanks.
