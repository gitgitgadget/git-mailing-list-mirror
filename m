From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitattributes don't work
Date: Tue, 04 Jan 2011 10:33:14 -0800
Message-ID: <7vbp3wh639.fsf@alter.siamese.dyndns.org>
References: <ifr610$3kl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marcin =?utf-8?Q?Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 19:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaBhI-0006xp-Ll
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 19:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1ADSdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 13:33:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab1ADSdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 13:33:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75E0E299A;
	Tue,  4 Jan 2011 13:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7yiySDJ4Fdwy
	fDMuuzEVuXsnNfA=; b=vSykb39Nctl4kqouy4/APCko5dFyB/z2Siew9bDYlzbN
	xJ508kTU5TFb4DsPJ4g1chmi5ZeDbSXxfi4bgUXvrahB+4CvHF+ARaC4hPA3D65n
	lcEkx/0oq1xztkM4qjL+MP32/OCkrkg/HQki3VFBwr/VJeZdcR3K6aWVEZNPgjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=owPqfq
	ib+ITTHvryadanGixES1SpgZEmnSJZfQ4AY1N6CIQ/NstQ9AEdYvyketzOpbP498
	Jwv0ReCMuIcSUKDGhT5mzxhIPmnVyp87rEFQnL35Sjv3MqDVwnCy+HX/yUMF/k4D
	auJrrja5FJpMfOgkKivm2zDVC3zIdtDPm8GUE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5431E2999;
	Tue,  4 Jan 2011 13:33:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 762AB2995; Tue,  4 Jan 2011
 13:33:52 -0500 (EST)
In-Reply-To: <ifr610$3kl$1@dough.gmane.org> ("Marcin =?utf-8?Q?Wi=C5=9Bnic?=
 =?utf-8?Q?ki=22's?= message of "Mon\, 3 Jan 2011 00\:42\:08 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FA73D3E-1831-11E0-BD6C-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164504>

Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com> writes:

> I'm trying to exclude certain paths (those that contain "xmac/gen/") =
from=20
> diff output using .git/info/attributes (not .gitattributes).
>
> According to gitattributes(5) it supports patterns from gitignore(5).
>
> Example path that must be excluded:
> src/byucc/jhdl/CSRC/xmac/gen/and2_dp_g.xmac
>
> What I've tried but didn't work:
> xmac/gen/ -diff

Why not "xmac/gen/* -diff" or even "xmac/gen/*.xmac -diff"?
