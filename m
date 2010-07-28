From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: Clarify the Signed-off-by rules
Date: Wed, 28 Jul 2010 10:23:16 -0700
Message-ID: <7v62zz5xmj.fsf@alter.siamese.dyndns.org>
References: <1280326379-10257-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAM8-0002yk-1t
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab0G1RX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:23:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0G1RX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C45C8C3A;
	Wed, 28 Jul 2010 13:23:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=MwRC290nNDUpVbCEcnXyWvUmP
	38=; b=CEzPw8ba3wvZ2GlYd3AaCtec92e1+2uKtUdVQxr5C6QV/azQdN6rs3/pv
	rpU6o9+bOZCPfXAITP+WV19PNZtCBlnJcpn4yGW6Wi1x/bBNGBsub1CYKT89uiuy
	6SchE9ggSU9P5FvHsrjjcBrqTAamxjkwCMjlZ+5m2cAvdynIKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EB2rfEnY41M0oL+lyqi
	l0uuYLIRbO3fY1eQPDHWCJP3rvfnSUGCpS2VHvK3e3wgZ3kFdRO7F1ZL8uiVaZcZ
	5W9tJyVYBvKgjjQgLBLpf9c5C4wzBLm/eocNtw3IQbCFAdPFTMVHtShc5uCxbm80
	o5UOYIqHa3HkFlBvXYj51+70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9B12C8C37;
	Wed, 28 Jul 2010 13:23:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B5E1C8C32; Wed, 28 Jul
 2010 13:23:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3F04518-9A6C-11DF-BF5C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152107>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The wording of the Signed-off-by rules could be read as stating that
> S-O-B should only be added when the submitter considered the patch
> ready for inclusion in git.git.
>
> We also want Signed-off-by to be used for e.g. RFC patches, in case
> someone wants to dig an old patch out of the archive and improve
> it. Change the wording to recommend a Signed-off-by for all submitted
> patches.

Ok.  In the past, some people (including Linus) used the lack of sign-o=
ff
as a hint to say it is not meant for inclusion, but I always considered=
 it
a bad practice ("RFC" or whatever word next to "PATCH" in bracket would=
 be
far more descriptive).  I think this is a good change.

Thanks.
