From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 13:20:03 -0800
Message-ID: <7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
 <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
 <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
 <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
 <20121116204017.GX12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTKs-0006e0-9T
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab2KPVUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:20:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab2KPVUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:20:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BA9C9F7A;
	Fri, 16 Nov 2012 16:20:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ehd4nUYRKm15
	CRLfGZtu/IfztEs=; b=JHrPvLj7zFv6RE00VqIuxeDx4PK0+CBiibu8Jxy3lOgq
	BLqtHOCl5SgT5BKWNSvuvke4mChsTyDfMPzcN2BYBUR6+moGQRGXZVqU80zGxfqP
	RMh7s9O1wrVsWGrApA/i/0PdVIAT0Q2ilHHziZ1/Pn63iSlH5Uy1tOdqtZrghfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KamaJ1
	a8x9N/g1QTn1U+XSMwU61GLWrPkuxuUJwqAnODbDVQ2bin87akQ1LRgQcziJzwiZ
	NiBAMoKe11i0HymDrf/V4VD4DuqW3ikTV+a+P/q7X87koBgzBsSoYxKHhZJNNx0p
	d5H7qrAv/lD+erAyk7VE9nHVufH+oLYZbF/d0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87ECE9F79;
	Fri, 16 Nov 2012 16:20:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9EB09F78; Fri, 16 Nov 2012
 16:20:04 -0500 (EST)
In-Reply-To: <20121116204017.GX12052@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Fri, 16 Nov 2012 21:40:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63C222E8-3033-11E2-A8BB-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209913>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> For zsh, perhaps?

Yeah, I was wondering about that.

If we make zsh completion read output from a little stub in bash
completion, just like Felipe steered this series for tcsh, we do not
have to worry about "zsh does not split words unless emulating a
shell and here is a way to tell zsh to do so" kind of stuff in bash
completion.  The point is not about the quality of zsh's emulation
of (k)sh when it is run under that mode, but is about not having to
have that logic in bash-only part in the first place.
