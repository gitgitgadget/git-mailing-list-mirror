From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Announcing 3 git docs: Best Practices, fixing mistakes,
 post-production editing
Date: Sun, 04 Mar 2012 15:26:44 -0800
Message-ID: <7vhay46j7v.fsf@alter.siamese.dyndns.org>
References: <201202281304.q1SD4U8W018223@no.baka.org>
 <7v399uxxkq.fsf@alter.siamese.dyndns.org>
 <201203041920.q24JKk3h024813@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KpH-0006os-QH
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2CDX0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:26:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515Ab2CDX0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:26:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF6DD6322;
	Sun,  4 Mar 2012 18:26:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LM4dC/A8wbbrBVkCcCZc3KrQdTU=; b=LV9S3N
	idO2UL0nzpE+LbVGBDFbXKVvZtwSf6K/ss/PWbGbVluhsvGXozVM0w2gtGzTJsSC
	EVmYDq/q+9qQN/8yo+4zWJ9IDH/Qx8flVHYu+IH9FTCS2s0AYs6QEnkXYML/4xuB
	1YmVx7FZ3ytRfFlLQ0qPdpUE9xiefDP0z5MqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oK6Y02vN8RHLxKpM0sm2/4qxVsafmqMA
	TwGvFGxph6GV8KERA3Yaa/aZmm+bbay5KFmbTGA37Q5fEh3LIKvFkQWdf241mBFC
	v6hQpNW4A0yVr7218LCgohrO2Pz7aGMmnJQBtw3bL4DA2W2pvwaH5QOzU6VSbMfq
	3Oy/gEtbcr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D68EA6321;
	Sun,  4 Mar 2012 18:26:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AD916320; Sun,  4 Mar 2012
 18:26:45 -0500 (EST)
In-Reply-To: <201203041920.q24JKk3h024813@no.baka.org> (Seth Robertson's
 message of "Sun, 04 Mar 2012 14:20:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81D5C728-6651-11E1-85D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192181>

Seth Robertson <in-gitvger@baka.org> writes:

> In message <7v399uxxkq.fsf@alter.siamese.dyndns.org>, Junio C Hamano writes:
>     Just a few I noticed that are dubious to be in a document that is meant to
>     describe "best practices".
> ...
>     "Don't panic"
>     -------------
>
>     * As we never "auto-stash", anything that is on stash is by definition
>       what the user deliberately placed, just like a commit on a branch that
>       the user may have forgotten.  So it is strange to count it as one of the
>       three places that "lost" commit may be hiding.  If you make it four and
>       add "a branch you might have forgotten" to the mix, it would make a bit
>       more sense, though.
>
> I do.

You don't.  You say "There are THREE places where "last" changes can be
hiding" and list these three things, not four.

>     "Do keep up to date"
>     --------------------
>
>     * You explained in "Do choose a workflow" section that different workflows
>       suite different projects.  ... it
>       would be more useful to say in what workflow and the workflow elements
>       such as "pull --rebase" you advocate in this section are suited (you do
>       not have to say in what other workflow they are inappropriate).
>
> In the pull --rebase section, I spend one short paragraph talking
> about why I think it is a good idea and four providing arguments
> against it.  In my opinion,...

I do not know if you have updated the version seen on the web since the
review comments, but I was merely suggesting that "what I recommend here
may not be desirable for some workflows" without spelling out what these
workflows are would be less helpful to readers than being more explicit,
i.e. "these suggestions are good for this and that workflows".

This section by nature of what is discussed is bound to be incomplete and
will not be "universal truth" as there does no "universal truth" exist.
Letting the users know that for what kind of workflows these are good
suggestions upfront will help them to decide if the recommendations are
applicalble to them.
