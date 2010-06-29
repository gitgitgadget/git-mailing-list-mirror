From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Tue, 29 Jun 2010 09:26:38 -0700
Message-ID: <7vfx05by9t.fsf@alter.siamese.dyndns.org>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
 <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:26:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdeA-0007YS-OY
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab0F2Q0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:26:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab0F2Q0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:26:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A63D6C0F04;
	Tue, 29 Jun 2010 12:26:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sN23V1SFGvFjzDVwKcdeou+U78Q=; b=kRcyQv
	z2Jd4PrzhKxpPnrBwoTptSPIkyw6npmGQspdU5kTcn3E8sber66ru+Bdzk2L3eE+
	R38PinJgVxmfWQjekrf6fecPceYepzGbr9O6wp9DjDLiO9RUNxm6t+rXJJwjnFLp
	Wr6D5PDT89wDetTo0yx66WRS4z76/9xXOOBI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdeNEMUG/zB3ynhiqa8rCKvIhXHGhllc
	YHiUqfSgcuIXRiRKE3PgNjN4ZkjU654F+eqMIj+8C2/cptyVpG7deFZjyrf+qRCa
	J961HgidolX2YG41IppcQ/f14drBxS6+1K65mGrPodsQSIhipEai77HMiljgWjbu
	ufSi/dKwbPs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FCDFC0EFB;
	Tue, 29 Jun 2010 12:26:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F49AC0EF8; Tue, 29 Jun
 2010 12:26:40 -0400 (EDT)
In-Reply-To: <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
 (Chris Packham's message of "Mon\, 28 Jun 2010 10\:07\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B3954F2-839B-11DF-9599-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149914>

Chris Packham <judge.packham@gmail.com> writes:

> +HOOKS
> +-----
> +This command can run `pre-auto-gc` hook.  See linkgit:githooks[5] for more
> +information.

Hmm.  "git gc --auto" does, but "git gc" doesn't, and saying "can run"
only adds to the sense of incompleteness of the description here without
giving useful information to the reader (iow, the user will have to check
the referred-to page anyway).  We would need to either remove the first
sentence (leaving only "See ... for information") or clarify the first
sentence a bit better, I think.
