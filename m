From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Avoid non-portable strftime format specifiers in
 git-cvsimport
Date: Sat, 09 Feb 2013 14:20:19 -0800
Message-ID: <7vpq09uo2k.fsf@alter.siamese.dyndns.org>
References: <1360446418-12280-1-git-send-email-bdwalton@gmail.com>
 <1360446418-12280-4-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 23:20:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Imy-0005ob-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 23:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab3BIWUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 17:20:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563Ab3BIWUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 17:20:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF4BB60D;
	Sat,  9 Feb 2013 17:20:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J75HZZE28ylKoW1K+JKkmPfVE6c=; b=VuHI4B
	tAUBGdS2sT0r3A9EclYvmKCxUhwRwNBvf4kc8MxOD56oR63BR01r0/c164ksALA+
	bKGHFaTftCVLvXNbddm/Oc0yI7o5Atir090yLjq65exKOEQ4JAZMybCSIpgFZ3fE
	K7gLz+ctpSWXA+Gvj4PEcNaAOtYL+RYVguPyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gDqgyjmjwfhwzFwJTgVbI/8rSEA1MOSI
	q/h0RYK3gbct/oQRzNLFYpdTkbcRjtpBJP40wrPmaoNXOp+RyskwFcniEu/oqYoU
	pxrib6r17qqlZRSNdNez0aZ1i79R5TFtvLfDt5H/tpYRQGXOKXwTfcZBUKP66s5G
	ZmRUhGEdQS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D88CB60C;
	Sat,  9 Feb 2013 17:20:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F366B608; Sat,  9 Feb 2013
 17:20:21 -0500 (EST)
In-Reply-To: <1360446418-12280-4-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Sat, 9 Feb 2013 21:46:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E446743A-7306-11E2-B1B6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215878>

Ben Walton <bdwalton@gmail.com> writes:

> Neither %s or %z are portable strftime format specifiers.

Well, at least %z is in POSIX; "Some implementations of strftime(3)
lack support for %z format" is fine, tough.

Thanks.
