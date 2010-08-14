From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --mixed option is deprecated with paths
Date: Sat, 14 Aug 2010 12:42:41 -0700
Message-ID: <7v7hjthtfy.fsf@alter.siamese.dyndns.org>
References: <AANLkTik_NuG3YKMknwh4fAK09kTH0tK1f08MzsexUMcV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkMd4-000524-Rd
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0HNTmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 15:42:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab0HNTmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 15:42:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D037ECD6E7;
	Sat, 14 Aug 2010 15:42:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3ncIbcJ4v4mX
	VZ/AEFBVyN/w52U=; b=seChAjUEYfTaaH943OGQ1pdJlGi/ZAdlY77IAlnGhprj
	f9f/OZIsTe6UApUDLKJs1h1lqk1/PB2tNwtJiq2k7ZWfdyvN1H4PIz/ywdosotdz
	eFOXk0jL2n+FriiyKhgHjWfX0oeR6HhR4d73d76u96y8xzLlpJ5mQ0mrSMMzpBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HoXZoN
	HgyJ77U+rbH9Erayk5IjGHOdhd7mqXJQEMauxoYpE7S13r4pGpgJP8mZbaoX4ktN
	t8tmKSzuLLKPgKyO1hY7FgCMOebP73xlUN6vyjyEn68bdCIgQ/F3H6RTw1wpnm+C
	MyGtR3y/M8OO1u8PCdtd++qr6AsVjlgb4NwSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D417CD6E6;
	Sat, 14 Aug 2010 15:42:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEA74CD6E5; Sat, 14 Aug
 2010 15:42:42 -0400 (EDT)
In-Reply-To: <AANLkTik_NuG3YKMknwh4fAK09kTH0tK1f08MzsexUMcV@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat\, 14 Aug
 2010 15\:23\:04 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C6D4EA4-A7DC-11DF-8E76-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153577>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>     $ git reset --mixed t/Makefile
>     warning: --mixed option is deprecated with paths.
>     Unstaged changes after reset:
>     M       t/Makefile
>
> So what should I use instead? 0e5a7faa which introduced it doesn't sa=
y.

You should say nothing.  "git reset [<commit>] <path>" is about resetti=
ng
the index entry selectively, and there is no room for any mode to be
involved (iow "git reset --soft t/Makefile" does not make any sense),
hence deprecation.
