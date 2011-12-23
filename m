From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch to support proxy authentication through NTLM?
Date: Thu, 22 Dec 2011 18:34:05 -0800
Message-ID: <7vaa6kc8yq.fsf@alter.siamese.dyndns.org>
References: <4CDEC141B5583D408E79F2931DB7708301691B80@GSX300A.mxchg.m.corp>
 <CACBZZX4FS37zqY3eUKHK+FGMjXB4D1DEi17hQSPsmQBS9E8jUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Schmidt\, Marco" <Marco.Schmidt@cassidian.com>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 03:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rduxo-0000oM-34
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 03:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab1LWCeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Dec 2011 21:34:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab1LWCeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 21:34:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EB95878;
	Thu, 22 Dec 2011 21:34:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Vz/rI1Ynmyqm
	9wtdlwiRA4L/4pw=; b=BdgBcLuCteEcLGcQ0mOtL60hkc6BTfuchI0Ytg4E1OQC
	JNNNpCJwXJBZoioT9o0qcVbF7rDEAvc6hRwScAJerXdIcrwZ8LBI4nNlJjg4V1Fp
	lwrbcgVZL2qDDLHlNVa/6jrVtTOzltG2lq902ewa8Yt14m64IxlqJF0d4SONWUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VQrC4g
	i33x5yaVWGRiJFT+BPsCwfXcPl8cj8RLu4bPSmMhT/o24np7sQV0UcAfbcC10mV/
	trokpz5S7aJneu146CR3s+ORg9A0jrRzI2+lNwd/Luctqwf9Yvn9kkx6gvo5Gem9
	QMGRtlJLI0jK2kWD9gDff772uwLv3rYKt3WUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 787805877;
	Thu, 22 Dec 2011 21:34:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7FDE5876; Thu, 22 Dec 2011
 21:34:06 -0500 (EST)
In-Reply-To: <CACBZZX4FS37zqY3eUKHK+FGMjXB4D1DEi17hQSPsmQBS9E8jUA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 23 Dec
 2011 02:43:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9624F360-2D0E-11E1-9644-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187619>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Which means that if you're interested in it the best thing you can do
> is to take that patch, rebase it on top of master, make sure it works=
,
> and re-submit it.

In the case of that particular patch, it appears to take more than that=
,
unless you meant "make it work" by "make sure it works". The discussion
following patch seems to indicate that it was very broken and not worki=
ng
at all, and then the patch submitter disappeared.
