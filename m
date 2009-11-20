From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitk: add --no-replace-objects option
Date: Fri, 20 Nov 2009 12:55:26 -0800
Message-ID: <7v1vjsx6f5.fsf@alter.siamese.dyndns.org>
References: <20091120194046.4469.53971.chriscool@tuxfamily.org>
 <7vocmxvu7c.fsf@alter.siamese.dyndns.org>
 <200911202142.39520.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaWU-0003r6-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbZKTUzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZKTUzm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:55:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZKTUzl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:55:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A63308196E;
	Fri, 20 Nov 2009 15:55:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1YaeA+aqaaLU8Cir4K5DYQVQrEs=; b=URpXke
	Gh/UV4yH29Gq87tZdGVR/dtojKVuDRw/k+1kCqMvwl8p/tzpCW5ADHvOBZYr1Ee8
	tCzIdcsTZHbAG7U6EawogqePXioHmhPwgQen/KapHkz0fI6nFqB+dK9r2sNZQSET
	TtNDSRb44oN7ao354JDiPthFqgulJhGxiv9hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7gsLmv4hn4yxOsP+vbSZKIQDClvy+HF
	kRpQ2pYd2A8lGazGsIID+lAxq+MtUoevUSKgXpDJNzAGh5lccfy8Ak/rBFlx+KGY
	s+TV2f/rQ1+Qc9RwuXLryuPZpgh2iy7/cJbcK/evKFozRoD8inztIOYRV8Fh9X1l
	K55OwOk3RcQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CFF58196A;
	Fri, 20 Nov 2009 15:55:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4782781966; Fri, 20 Nov
 2009 15:55:28 -0500 (EST)
In-Reply-To: <200911202142.39520.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri\, 20 Nov 2009 21\:42\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0EDE45B4-D617-11DE-98BB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133379>

Christian Couder <chriscool@tuxfamily.org> writes:

>> I wonder if this switch deserves run-time flippability, though...
>
> The following patch in master added run-time flippability to many commands:

What I meant was not that.  I was wondering if the user wants to flip from
the gitk GUI without restarting gitk.
