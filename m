From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv14 0/7] Expose submodule parallelism to the user
Date: Fri, 19 Feb 2016 13:04:46 -0800
Message-ID: <xmqqtwl4bedt.fsf@gitster.mtv.corp.google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 22:05:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWsEX-0008Nl-CG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 22:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993777AbcBSVEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 16:04:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992692AbcBSVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 16:04:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C947D44E77;
	Fri, 19 Feb 2016 16:04:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gs/i3qtryiUpVie9zye77MMpmWo=; b=OQmHd2
	fDc2JDcrsdEe7g/DMta1FEKkr8LBGTvbM92FmzFgX+56iJgADiLJgrPEBaWg2/yn
	1+8ObXvx1qJnI2/3JOUkxCF4kbnuPkczEXrebFiPRo0sfH1yJgJnpQd/IoZnU4nr
	O344VnW/p3aOrLQJ6dvTPHZQUqlp73NxgM4Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DacWgWWrAwC2SbsTwxad51lP8JDZcDJl
	I4ZN3y5qw6pbwKX96gHFP8q8qkUE9xj3M5KxeCI49QFWgrFYN6FUSPHEKg6qtZxu
	5HfaFiR4ISCXqStpJ+PQh1+kc9yi+bJ/6Z0c/lSoces2ImchXynwByu0CJ/EifRZ
	iTrxh75M2tc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C122B44E76;
	Fri, 19 Feb 2016 16:04:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D8B644E75;
	Fri, 19 Feb 2016 16:04:48 -0500 (EST)
In-Reply-To: <1455905833-7449-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 19 Feb 2016 10:17:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68EAC720-D74C-11E5-906C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286750>

Looks good.  I didn't notice these unnecessary blank lines while
reading the previous rounds, and it is good to see them go.

Let's wait for a few days and merge them to 'next'.  David's ref
backend topic textually depends on this, and we'd better give it a
solid foundation to build on soon.
