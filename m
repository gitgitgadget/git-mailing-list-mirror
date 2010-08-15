From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sat, 14 Aug 2010 18:47:59 -0700
Message-ID: <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Ralf Ebert <info@ralfebert.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 03:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkSKe-0004wE-V5
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 03:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732Ab0HOBsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 21:48:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757723Ab0HOBsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 21:48:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77FEBCD90C;
	Sat, 14 Aug 2010 21:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uwZ8CHGFPZLNzMIsJCmDuZ4GI/w=; b=lgdLH+
	z29BkOoxhBeRWDBgJnZ7luJE/2IqvygNg0b3m9pX3+lcBzvGReLV0yyRJ4tq3ZQw
	KOgKPQ3fxVlQFXV95OrnGupf81g2+xCdtOOx3p4kwkCcUNkj4d5FuZl4972OHI2S
	VH6WzpqEWoGuZQ1qlQ8xoduHhShXGSUScAZKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5l48shPEqiOYQAROrHN1N/lobfGVGvV
	AvzhidqTG5hNbnSzu0jISwE90w46EcTxK2XAzBdhmryyIL9Pd7AHlcZRZzmr+9nT
	nrlp4DkuFbjow2kFm58jBfB74btTmSAZpkC89A6tvKHnck+vbbbj4BnnYEsz0ruz
	j++4MQJCMvA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C41CD90B;
	Sat, 14 Aug 2010 21:48:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64CBBCD90A; Sat, 14 Aug
 2010 21:48:01 -0400 (EDT)
In-Reply-To: <20100814210505.GA2372@burratino> (Jonathan Nieder's message of
 "Sat\, 14 Aug 2010 16\:05\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 261E15FE-A80F-11DF-97EB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153591>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe:
>
>  warning: --mixed with paths is deprecated; use 'git reset -- <paths>' instead

That sounds helpful.

We've been saying this form is deprecated since 1.5.4; a better
alternative may be to make this into an error in the next release,
though.
