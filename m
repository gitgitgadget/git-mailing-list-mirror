From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --since --until
Date: Wed, 04 Jan 2012 14:16:47 -0800
Message-ID: <7v62grp0z4.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi30FL+hRSqr3XRNgvOr4yBcTsbTpiNXpxJ=CN1Q=JVo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:16:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ8g-0002v7-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab2ADWQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:16:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757080Ab2ADWQu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:16:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF13695B;
	Wed,  4 Jan 2012 17:16:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DCKuy9gQQcDKWFsLbZFR0KykAyg=; b=BQ5tIj
	eLSV174nU/Ov/R8gzYomPNESjAq+uKFWiJNrvExrJHQ0nO0gabLjGRGO2iexOPXZ
	BJu0BGCr/TJ73I2XOddnnVT/rMu20cJ4g+SiI+6+JvHePEh73+/bOVUzjEKuEZv/
	zUdLKOd7vMv5pQ4xXGSB89Qtgb9wo+Fmul/30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HmzrMaoQW7WAkjb0li8D5bB6GtrQH8/Z
	a2DZG3kco1l+TX/rgP4vCgibmpmtSG7BqS1HsZAic1yFkXz+ZHSXj6EGN/V764Eq
	oGvMXx7mm1g9gGbCXgB1CfZcO/8GV8+hO2bRExJXjv9FOXgcOOlNpxVRsgxIxJqU
	+M22GRznIu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97300695A;
	Wed,  4 Jan 2012 17:16:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C2556959; Wed,  4 Jan 2012
 17:16:49 -0500 (EST)
In-Reply-To: <CAE1pOi30FL+hRSqr3XRNgvOr4yBcTsbTpiNXpxJ=CN1Q=JVo3w@mail.gmail.com> (Hilco
 Wijbenga's message of "Wed, 4 Jan 2012 13:46:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBE2B1A0-3721-11E1-8B0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187950>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> git log --since="01-Dec-2011" --until="31-Dec-2011"
>
> The returned list of commits also included a few from November.

These limits act on committer dates. Are you by any chance looking at
author dates instead?
