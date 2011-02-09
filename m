From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Add function per_branch_config.
Date: Wed, 09 Feb 2011 15:27:32 -0800
Message-ID: <7v4o8cokkb.fsf@alter.siamese.dyndns.org>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-3-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJRp-0004a0-Nb
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab1BIX1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:27:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1BIX1j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:27:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A57E14ED7;
	Wed,  9 Feb 2011 18:28:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nv7aPgD8IBAMKHFrtveo7s5ZJb4=; b=Jb+fPh
	Mc4j5H+AhXAw+WM/4FOEJR5XAQz78/DLVPea2186oIn2cs09ZjW6UGZKFnp0aIY1
	zexDmV9ZdPhG+r0ipUm8MJzXv8+CcpTJK8HyNqcMlFbiKniNjuXT3ewOAz1eisCv
	cnsb0/g6tbj7sLR4wQh0V9rNY6/Nm0IIksI9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ue7DVdYD90sVamUiZNARciHHsAcJW9G9
	dagIdxtgG/0RVhnABCcvp7XjvtG8c1pE0L9OomQX4fWZF+7a7NCEFju67WsdyAte
	EyzHS3pckc3RRfR81dGCZ5I7jVvrBFoT0W9OcN1dr8qOg8VG60+JNqkWsD1jYqd4
	jwde3AnLSt0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80B2B4ED5;
	Wed,  9 Feb 2011 18:28:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74CAF4ED4; Wed,  9 Feb 2011
 18:28:34 -0500 (EST)
In-Reply-To: <1297211028-14382-3-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Tue\,  8 Feb 2011 19\:23\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51ED1262-34A4-11E0-9506-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166455>

Jared Hance <jaredhance@gmail.com> writes:

> Adds a configuration function to be filled up more in the next patch.

Again, "to be filled up more" is not the primary purpose of the new
function that was refactored from the existing one.  State what it does,
and what it is for instead, perhaps like...

    Split a part of the configuration callback into a separate function
    to handle per-branch configuration.
