From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] gettext docs: the git-sh-i18n.sh Shell interface
Date: Fri, 10 Sep 2010 15:54:17 -0700
Message-ID: <7vaanpgqg6.fsf@alter.siamese.dyndns.org>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
 <1284147353-18000-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCUI-0005M9-9f
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab0IJWyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:54:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0IJWyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:54:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F777D5075;
	Fri, 10 Sep 2010 18:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ufb6I/C88KQD
	w2+CdKNEPHjIqzI=; b=hVzz7dni9io0zKxqdXTUr+U5MMICx9urlaBAUxGDbH7G
	U2klONLnOwp42UCEJrCSaA07yDQkcz9ZLNi0UoLEHXpy6izpxgXaXsCmypjpJtD4
	WKsFoWH28vK+XygehvbjlVfjBv1poRihjed2RgyddMYXvT0NuAUtjA5m2dVioCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RklTas
	iay5S5NqR0i8PqBY82maMtXkUoiYOZO42nqudCyD1aP3+N9nMuNhzKco0y5742fk
	85yvI4p96tVY4BhtVo2BhZKRuScl3+9fZMNVPJLPdLuzXeN+0MeV+X6YKccCrYG3
	pQw9y4FL86M5QMaZNiNUb4mTeBfD+EBr4q8C0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4844D5072;
	Fri, 10 Sep 2010 18:54:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7156D5070; Fri, 10 Sep
 2010 18:54:18 -0400 (EDT)
In-Reply-To: <1284147353-18000-5-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 10 Sep
 2010 19\:35\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59E032B2-BD2E-11DF-AE52-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155979>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +       git log --reverse -p --grep=3Dgettextize git-am.sh

Running this from the tip of ab/i18n reveals that one commit introduces=
 a
whitespace breakage ;-).
