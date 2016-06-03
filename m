From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 03 Jun 2016 08:50:50 -0700
Message-ID: <xmqq8tymqnj9.fsf@gitster.mtv.corp.google.com>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
	<57511B2D.7040501@kdbg.org> <20160603094544.GA3865@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8rQg-0000kg-4H
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcFCPuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:50:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485AbcFCPuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:50:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DC191F719;
	Fri,  3 Jun 2016 11:50:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0YTXQ4fDIGhoxkHdtyla8GAmvFs=; b=lEBlPa
	yp9Nhdb40Uyc+kPU7E3L53gPMUookeA9vkH8VKjXweTKo8SfpQJHM+RlkESovSnZ
	b509GuAUO3HLiqqenECfm+HzlKqpVNz3SyzyuqFw2Glb2NTsSKpFgV96gXAOkV33
	QIApvHOJkgjJLvjzO7DDbUJLGP5rTFBiCD6zY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2qri3QKNccygiwRKbkJWOH7GeCzoekW
	/77kz++bOZgxI6c3GqwDPyaWKr4Mf9ZC9wb+mj6+SEaJd++5PlealCxDwSJ8b73Z
	/bCBAwvqHcb7KnANzVEcz89VCD09JUdt+k7FtyqjXoz/4PF2XvHu/yFcUFA7paoR
	juctWqv0Mec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 165B81F717;
	Fri,  3 Jun 2016 11:50:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8744A1F716;
	Fri,  3 Jun 2016 11:50:52 -0400 (EDT)
In-Reply-To: <20160603094544.GA3865@Messiaen> (William Duclot's message of
	"Fri, 3 Jun 2016 11:45:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F364F260-29A2-11E6-940C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296341>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> Here I have to disagree (with you and Junio): the IPATTERN is
> case-insensitive only on the "pattern" regex, not the "word_regex"
> regex.

Ahh, OK.  Obviously both of us overlooked that.  Thanks for pushing
back.

> On the identifier line, I have "A-F" instead of "A-Z" though

Yeah, that does need updating.
