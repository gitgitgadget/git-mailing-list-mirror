From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 09:47:17 -0700
Message-ID: <xmqq4mauucx6.fsf@gitster.mtv.corp.google.com>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
	<cover.1459946531.git.d.f.fischer@web.de>
	<alpine.DEB.2.20.1604211737170.2826@virtualbox>
	<34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
	<vpqr3dyud3i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dominik Fischer <d.f.fischer@web.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHlF-0007xp-4t
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbcDUQrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:47:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752140AbcDUQrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:47:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D80A713C38;
	Thu, 21 Apr 2016 12:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qysG8HAMWgbJaijjMuyj3NCiXKE=; b=htMqoC
	wQ+kOScMK8uANhTrrANt5KJHPo+A1Zm5lN3e+IopYVom2PH1lmoSoE53uZnXiqE3
	mL3X2J8G+aMfhIvTJ2u5nHbur8uOKxLvTFZLE1LsY4e2tINMUIUhgk9w7/j3aTC3
	60itfxHVCv7YLxR1FHbKunw7dY+YUXUJUGa2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqoIngnj2ai1RzJyZGiFenkXQ2hXvdTS
	K/V8RyPqUeTbq5O7cH/grKojo1bh7dqT+TAAIwsb+IdxDX2vWXH6y9UYuQNwRm6+
	EadR6plNcfSpmmTwwfqO/FiCEMeL4TrqLOqk46s34ZfUMA+627sBzULILYQfD4MA
	ExTpZdY45E0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCCB613C37;
	Thu, 21 Apr 2016 12:47:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A48013C33;
	Thu, 21 Apr 2016 12:47:18 -0400 (EDT)
In-Reply-To: <vpqr3dyud3i.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	21 Apr 2016 18:43:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5945914-07E0-11E6-9DB5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292125>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> A config variable to set an option by default is good when the user
> wants to set it and forget about it. In this case, you clearly can't
> "forget about it", as running "git add" and "git add -p" correspond to
> really different use-cases.

That is the most sensible explanation I've heard so far; the
configuration variable add.patch should not exist, period.
