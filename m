From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Wed, 24 Nov 2010 11:17:13 -0800
Message-ID: <7v7hg2ttty.fsf@alter.siamese.dyndns.org>
References: <m2oc9hkurl.fsf@gmail.com>
 <1290458128.29678.23.camel@drew-northup.unet.maine.edu>
 <m2k4k5ks0b.fsf@gmail.com>
 <1290461070.5468.5.camel@drew-northup.unet.maine.edu>
 <m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
 <1290517990.10366.17.camel@drew-northup.unet.maine.edu>
 <4CEBC8C9.4010905@drmicha.warpmail.net> <m2d3pwj8th.fsf@gmail.com>
 <1290532016.10892.40.camel@drew-northup.unet.maine.edu>
 <m2fwur7olt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	git@drmicha.warpmail.net
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 20:17:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLKqg-0002ij-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 20:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab0KXTR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 14:17:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab0KXTR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 14:17:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E2553FB5;
	Wed, 24 Nov 2010 14:17:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WnirWmlFcZ6BN6sOky8YIYxhBjs=; b=AMq4WJ
	LPMZkcvQENFQ7lk/iTDxIdhdV1DlAJMGA8iGXxAaEXO55IhVs1JK7YNfJ1uo3pBK
	rcLUVC+3BQjEw/RQZTKhGf2hk6cKOMYaXWMHEMeEyNWpsD8w/JWTHI+HcSgMhnCa
	pe6vXxLl8Xowm1MCckz2xXzpT6W9VdTcLrEM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enoU/FIHX7ZAOKojIFyj2Qm3t0uxADpz
	yJYvZYT40nJCRaZ6sWwzyUg9zzhwlaX0ejAcNmAFaeIqY7TLcc3HYjmCMzCVLYpf
	NV+A0MfaRXGxlq6xiVtk+qZLFfO4HHhvstdft0CETNxwFRIrRnGLq8CeoUWE4IUs
	E13MpQqUkLY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B78663FB4;
	Wed, 24 Nov 2010 14:17:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 348243FB3; Wed, 24 Nov 2010
 14:17:28 -0500 (EST)
In-Reply-To: <m2fwur7olt.fsf@gmail.com> (Francis Moreau's message of "Tue\,
 23 Nov 2010 21\:48\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E009356-F7FF-11DF-ADB5-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162073>

Francis Moreau <francis.moro@gmail.com> writes:

> Ok, I fixed the problem by reinstalling the following packages:
>
>     - docbook-style-xsl
>     - docbook-dtds
>
> I suspect something went wrong during Fedora major updates, at least
> that's the one I'm going to blame for now ;)

I vaguely recall that I saw a similar breakage due to broken xml catalog
on the system when k.org updated a few years ago (not the recent move to
FC13 but two updates before that one to FC9) and asked the sysadmin to
reinstall docbook-dtds.

Is it still CANTFIX [*1*], I wonder?

[Reference]

*1* https://bugzilla.redhat.com/show_bug.cgi?id=454097
1
