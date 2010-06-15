From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Mon, 14 Jun 2010 20:08:48 -0700
Message-ID: <7v1vc99em7.fsf@alter.siamese.dyndns.org>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
 <m3631lp9oe.fsf@localhost.localdomain>
 <AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
 <AANLkTinsD3WVpldxSS2K1Gk05D87nQv_rA3D-BjlBXGD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 05:09:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOMX6-0008Av-Au
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 05:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab0FODI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 23:08:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab0FODI6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 23:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF9C2BC473;
	Mon, 14 Jun 2010 23:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bfonNA0X5Sz3
	QqRqkUOuYeSHd8E=; b=VY8lqdCrfit+xp+LrkAlSANpXFt5bMxJKJXUoP5Euqy+
	Y4XlKKEOQsSKKu87NLM7jDv81i/Ek32/QClX3Nwa6wtEELvTSrUo/euUkRF5gw4N
	IX3bvgkHx9H/V3wA2TrE/17oOhR87DefXCMHZNliApc89aQu1zeF0A4opFkk8GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=byO9aM
	LySuXO0xzL9pEgFlNfnP8n+929VlMAqJtlD9wFghfTmgqtYVv13H8u1FoQSAIDGg
	5wLHXkHXQ5sQUpqgM1ejj+FpCCIU512M4KBkDoU1wvfdkMZjcwbXGf+WMvVSyy5s
	H+8uQFZ06SwEptqbyAInLHmuVqGXRg+yr1rfA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B0EBC472;
	Mon, 14 Jun 2010 23:08:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2472BC46E; Mon, 14 Jun
 2010 23:08:49 -0400 (EDT)
In-Reply-To: <AANLkTinsD3WVpldxSS2K1Gk05D87nQv_rA3D-BjlBXGD@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 14 Jun
 2010 23\:16\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 541ED5B0-782B-11DF-9F1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149152>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 14, 2010 at 22:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> On Mon, Jun 14, 2010 at 21:49, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> I'll re-submit a version of the patch with a better commit message
>> which addresses all of the below.
>
> Since the series just made it into pu is that still wanted or needed?

It very much is.  There isn't that much difference between being in 'pu=
'
and being in the mailing list archive.  Queuing in 'pu' is just to help=
 me
not to forget about the series, nothing more.  Depending on how further
discussions go, the series can be replaced with an improvement or even =
can
be dropped as a whole as unusable.

In this case, the explanation in the commit messages and/or documentati=
on
are found to be lacking, and you already know what the improved version
should look like, so I think it makes sense to replace the series with =
a
new version (v3?)

Thanks.
