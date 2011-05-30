From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Mon, 30 May 2011 11:17:32 -0700
Message-ID: <7vsjrwm4sj.fsf@alter.siamese.dyndns.org>
References: <7v62osob67.fsf@alter.siamese.dyndns.org>
 <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 20:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR72H-0006QZ-Kj
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 20:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab1E3SRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 14:17:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab1E3SRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 14:17:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 703AF4B4D;
	Mon, 30 May 2011 14:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SQnse6DR47tv
	APfpTV0DmuHSpI4=; b=o9yYChVph+hfb6csgbREmnAX5xEA8wTlGFzYJGI4lzXM
	2pPEuZm2eGWSSRh4k3uqIUr5K8aKaDnYUwgMjvT5HLk0mSbRXt+b1RH/7WSehzV0
	HI0LfhNAosKiraVPPfgyh2QYXADXEoipmaFGCb5v3D2ZuqC007eL0C54Rz3rCxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uoszpl
	evxkib7xna6b710avdOt0hoTm1P3z6g8NzV9I1NDzstND5kK2kgtVor67kW6pQJj
	4dA2cVpWXesJ5MjS9F3ZsX4by+yasa8Ek7iFi3C37pev/u0ax4v4JgowTbUn+bgI
	9z0dB56DHzPBoFCfr3ADfCyth6PgxkXv0Tzqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B5FA4B4C;
	Mon, 30 May 2011 14:19:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BEBF4B4B; Mon, 30 May 2011
 14:19:41 -0400 (EDT)
In-Reply-To: <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 May
 2011 14:08:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65D474DC-8AE9-11E0-B92E-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174767>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, May 30, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> * ab/i18n-scripts (2011-05-21) 48 commits
>> =C2=A0(merged to 'next' on 2011-05-23 at 69164a3)
>> [...]
>> Rerolled.
>> Will cook a bit longer.
>
> This being ready for master is waiting on Johannes Sixt's patches to
> supply a fallback getenv() on Win32.

That getenv thing by itself is actually a non blocker for git.git itsel=
f,
as mingw folks fork from my "next" anyway, I think.

I want to cook this a bit longer independently from that issue, as it
touches quite a many files.
