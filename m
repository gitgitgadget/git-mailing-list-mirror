From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 15:05:44 -0800
Message-ID: <7vvd0mqks7.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:06:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7Uw-0004s1-RU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1BNXGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 18:06:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1BNXGJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 18:06:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 398983E30;
	Mon, 14 Feb 2011 18:07:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0cCgqk1imi/P
	GpExccHSVcL1J6I=; b=Ca44mEiGnJzbieTq9gpAzrRHlssE4g3+RiYQLHlP3kIT
	PGzuM59WwFs2+SDb6sL75+wbq+JPSjca3D7NVzY8wlo1k16hcA/SmzcHsmjFPHh0
	oqT5Lv48TY4GrK1r1tI16CWWC9I0GX6B/vWcKoI6iPYlZFy4mImc4cx9wPYlQfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YUWIZu
	zzJrw1z/K5BzK82OWuX3SiQE/yHtY5FWNGBLQgmSlHx21dPUxdDSrE00kUaYmXRw
	1eRtPlEaRP+Uy/lil8twSKU4PC/2A3X+DLF9n+UmySUBaspfajGUBSJ0RW13Xw4N
	bQSrlMk1DdRvgnPMjjsJBoLJhN7GMDED3oSGY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8DF033E29;
	Mon, 14 Feb 2011 18:07:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA4113E21; Mon, 14 Feb 2011
 18:06:49 -0500 (EST)
In-Reply-To: <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 14 Feb 2011 20\:44\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2224A36C-388F-11E0-A9CA-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166791>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Feb 14, 2011 at 19:53, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>> =C2=A0push.default is unset; its implicit value is changing in 1.8.0=
=2E To squelch
>> =C2=A0this message, set push.default. See push.default in 'git help =
config'.
>
> This is worse than what Junio suggested because it does not tell you
> what to set it to.

But the weatherbaloon patch from me was equally bad in another sense.  =
I
was only showing where the change should go, and not what the precise
wording should be.

The message triggers not just for people who _do_ use and want to keep
using matching semantics (iow, old timers), for whom the weatherbaloon
wording is adequate, but also for people who are new and do not have
anything configured, majority of which are _suspected_ to be better off
using "current" setting (if we don't suspect that, we won't be talking
about possibly switching the default in the future).

So I would imagine the actual wording should at least explain that ther=
e
are two plausible choices, and people who want to get used to the upcom=
ing
default earlier would want to set it to "current", while others who wan=
t to
keep the current default would want to set it to "matching", to avoid
surprises.
