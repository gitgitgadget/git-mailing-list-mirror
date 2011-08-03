From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why do some commits not appear in "git log"?
Date: Wed, 03 Aug 2011 11:57:35 -0700
Message-ID: <7vipqeb9wg.fsf@alter.siamese.dyndns.org>
References: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
 <CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
 <CAMOZ1Bt+Z4XDPNBQyUeVk30aEOuXFAuh8jhdhFke-CDZt2pEDg@mail.gmail.com>
 <CA++fsGGhzVkXTPLui+DfTFcjve7w80Kud4RxC0p=5AenOcBSDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Dov Grobgeld <dov.grobgeld@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QogdT-00033r-7z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab1HCS5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:57:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab1HCS5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:57:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8ABE4472;
	Wed,  3 Aug 2011 14:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SRrDbF2N9W1UFea1faQLBauIj/w=; b=PKtloS
	rFA04YGzSSdjL9RC8R3VYdcYQ5+ziZ/vBTBPvARMPlUSi4ido5iwngmG7RbSER5u
	E93+UcQDO4LI+Qs+UPNTXk7hglUyBYcIsXtKguSzCJVF/GUlVBX+ifkt0jv9u0Ym
	XE7My19jcpaRGUw5aC1riqvMnZWMlfMRPeaBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7M4T8Y9dz6xYkoLokj1pjkyTacBREZt
	quG2N5M/PMj7G/AE/I3Rl0zrqUaYWyyMP6e6ySr64gVdPaCZkXs6/dKZuZawS9Bo
	cDRGHq+by3VqWvB96NCfs9hCgVndovZwAzbYWdtmYjXu/3U1r7wI3tIEGLChGsSM
	Ud48c/fAuko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C001B4471;
	Wed,  3 Aug 2011 14:57:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AFED4470; Wed,  3 Aug 2011
 14:57:37 -0400 (EDT)
In-Reply-To: <CA++fsGGhzVkXTPLui+DfTFcjve7w80Kud4RxC0p=5AenOcBSDw@mail.gmail.com> (Dov
 Grobgeld's message of "Wed, 3 Aug 2011 08:47:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745C1EDC-BE02-11E0-9BD6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178608>

Dov Grobgeld <dov.grobgeld@gmail.com> writes:

> --full-history indeed made the missing commits show up! So why was the
> commit pruned? It contains some substantial source changes...

I suspect that these "substantial changes" did not make any contribution
to the end result. Read

http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=90659

These days, the --post-simplify option implemented in that discussion
thread is called --simplify-merges or something, I think.
