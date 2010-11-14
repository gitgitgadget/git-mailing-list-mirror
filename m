From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 11:08:35 -0800
Message-ID: <7vvd3z205o.fsf@alter.siamese.dyndns.org>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 20:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHhz2-0007ua-9F
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 20:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab0KNTIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 14:08:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab0KNTIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 14:08:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 616B83789;
	Sun, 14 Nov 2010 14:08:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QAPyRcHZHPm1
	6dLaHM8oZ2AAYck=; b=M7lvVJNAyiu26EKl0z/C+UJb4NRFBHcSfgHyeTnIx0i5
	vGSCFObfaYKmzIVobgCf3YJml8lBfoWLVOdtaYYM0HppRg4w2/CwWILUvdU28SAM
	CG6gAa8Udf0/C4P4K1Z7WHdohVY301vUGP21G/bi1lCiofItVzVHVe1pmbVC9DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g6lEnr
	R1EVVZOGjEbCTHXYFin3JdURacr+C+VKmGl/055wMQDW3hi+AcYIFTb9ApgSnIBB
	wGtglzKuRB5S/FxvIoGtltP1lgprGp3NXNJ7ovE2vDCN7CUy5ooIhEPUtJUh65Br
	rEzkAMGG42stOw6xzJx7MAht+Kym6rEz00L6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 312003788;
	Sun, 14 Nov 2010 14:08:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2763D3787; Sun, 14 Nov 2010
 14:08:42 -0500 (EST)
In-Reply-To: <1289745857-16704-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 14 Nov
 2010 14\:44\:14 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B6DE590-F022-11DF-87AC-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161433>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the Makefile so that the "Platform specific tweaks" section
> comes before the assignments to LIB_H and LIB_OBJS.
>
> In the ab/i18n series I only want to build gettext.o (by adding it to
> LIB_OBJS) if NO_GETTEXT is unset. It's not possible to do that withou=
t
> an ugly hack if we haven't applied our platform specific tweaks befor=
e
> LIB_{H,OBJS} gets assigned to.

Isn't this similar to block-sha1, which is controlled by the feature ma=
cro
BLK_SHA1 that can be inferred from platform tweak?  The mechanism is no=
t a
hack but is a way LIB_H and LIB_OBJS are intended to be used, so there
must be something missing in your explanation.
