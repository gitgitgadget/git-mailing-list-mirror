From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Documentation: merge: add an overview
Date: Mon, 11 Jan 2010 02:09:38 -0800
Message-ID: <7vbph1t0kd.fsf@alter.siamese.dyndns.org>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch> <20100110044949.GA8974@progeny.tock> <7vskaefp2v.fsf@alter.siamese.dyndns.org> <20100111021322.GA8480@progeny.tock> <7vzl4lbcfl.fsf@alter.siamese.dyndns.org> <20100111041318.GA9806@progeny.tock> <20100111082123.GA23742@progeny.tock> <20100111083028.GB23806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 11:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUHDh-0004HN-T4
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 11:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab0AKKJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 05:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051Ab0AKKJv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 05:09:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab0AKKJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 05:09:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94010906B9;
	Mon, 11 Jan 2010 05:09:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AsGPkzPIjcPddb0SSefO1LO2whg=; b=VMcwzD
	yWEHv9RbidsbOTWTRr5Ojbw6PNvk2AhZL9PJN7q9//Bk86/2ZK2CoCUVv/WzJfzj
	Z5lzqPaDK8X7KLWjq4Ct+Czs8JG/1QlV4M++AlCnG+E/JzB5cyeBH0BGAfdm3h8K
	p8hOzuUpEyfd2+MeX8aBFePvbZJ0IZ2OQ7z+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyjsTL+LTh9Fg0Bl6iCc38LvvB53Xs6/
	ZnepVfbRhb9j9gliw3jwEyLvkmGeEQtqGQ9uUtLl9VO6V1I1FTLtuZaiKw+NC3V8
	soxTvQPUroTZIZhgKAR+teh2vk1y7eig3ckOFuwM9Muv1moWDrUoRDXP8NMBy42y
	jZfbwPqIaLM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4910D906B0;
	Mon, 11 Jan 2010 05:09:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46713906A9; Mon, 11 Jan
 2010 05:09:40 -0500 (EST)
In-Reply-To: <20100111083028.GB23806@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 11 Jan 2010 02\:30\:28 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7150D86A-FE99-11DE-BF07-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136629>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The reader unfamiliar with the concepts of branching and merging
> would have been completely lost.  Try to help him with a diagram.

Good idea.

>  DESCRIPTION
>  -----------
> -This is the top-level interface to the merge machinery
> -which drives multiple merge strategy scripts.
> +Incorporates changes leading up to the named commits into the
> +current branch.

Having "since the histories diverged" somewhere in this first sentence
would clarify the concepts better, I think.

> +Assume the following history exists and the current branch is
> +"`master`":
> +
> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +Then "`git merge topic`" will apply the changes from `A`, `B`,
> +and `C` to the work tree, and if they do not conflict with any
> +changes from `master`, will store the result in a new commit along
> +with the names of the two parent commits and a log message from the
> +user describing the changes.

 - Don't spell A, B and C out; technically we don't do that, and
   conceptually "changes since E until C" is exactly the same.

 - Don't talk about "what it does" first, but talk about "what it is used
   for" iow "why do you want to use it".

 - "What it is used for" doesn't have to talk about "if it does not
   conflict" yet; it is merely a lower-level detail that the main part of
   the document can teach the users to help the tool achieve its goal
   (i.e. "what it is used for") when it cannot do so automatically.

	`git merge topic` is used to replay the change the topic has made
        since it diverged from master's history (i.e. E) until its current
        commit (i.e. C) on top of master, and store the result in a new
        commit along with....

> +------------
> +          A---B---C topic
> +         /         \
> +    D---E---F---G---H master
> +------------
>  
>  The second syntax (<msg> `HEAD` <remote>) is supported for
>  historical reasons.  Do not use it from the command line or in
> -- 
> 1.6.6
