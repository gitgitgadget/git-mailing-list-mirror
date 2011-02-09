From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Move test-*.c to test/ subdirectory
Date: Wed, 09 Feb 2011 14:15:23 -0800
Message-ID: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
References: <1297264469-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 23:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnIK2-0008Uc-8Z
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 23:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab1BIWPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 17:15:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1BIWPc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 17:15:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78FB645A1;
	Wed,  9 Feb 2011 17:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NQ3RJDM/5hme
	lmIrebckfgpij8U=; b=HWFG6ZUzEeB+3QN7H2a4gvzvQr53PxNqfeyBcI83y2ab
	POac11bfcK6S5KqLUbYHbXQOKyztjrxrHFUsjnV2d7HeRP44N3w1Ev27TV/HCeQa
	Vkp1gvkE7oDfn8B9IZ0WETPSbn+H/Q+GbSaF9YIMopGQ5HTMOI/3Gk2ZYYsfODE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lkUBDF
	8Wy0GKGIfvOojmv1Z3RY4Fij/M3MxGkI9CHnUP8MfGHJkCd/9jJorskgnc2PpTlK
	PhbRx8FHl29uUf9Ahna1S615A9tS4l6MOmnKYUsPXcmQfp20WFMxCpWEP4dYx7ry
	vbqeKeLdrnR/RndnNA1mP5/1+KZulPQGGQahY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C048459D;
	Wed,  9 Feb 2011 17:16:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5DAA0459A; Wed,  9 Feb 2011
 17:16:26 -0500 (EST)
In-Reply-To: <1297264469-13675-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\,  9 Feb
 2011 22\:14\:29 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E192D20-349A-11E0-9BE2-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166448>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

I like the idea of moving test-*.c out of the top-level directory, but =
at
the same time I do not think it is a sane thing to have a new directory
called test/ to have only test helper commandlets.

With both t/ and test/ directories present at the top-level, even peopl=
e
with Perl background may spot test/ before they notice t/ and expect to
find actual test scripts in test/ directory.

Perhaps move them to t/helper/ directory instead?
