From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Chronicles, updated?
Date: Thu, 08 Jul 2010 06:31:10 -0700
Message-ID: <7viq4qqew1.fsf@alter.siamese.dyndns.org>
References: <201007081057.51946.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 15:31:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWrCK-0000zv-Fn
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 15:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0GHNbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 09:31:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab0GHNbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 09:31:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5141DC2FE1;
	Thu,  8 Jul 2010 09:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xkVyf8t12mm90pZegFTOo6NBak=; b=HAfl7T
	zaninoNyrB/X6ULvPq928AYaWQs2vUyeIDYEsUSjn5GZcWJbDZzE8fd5lrbhvv3p
	dHOefwyrqLtahnbWvXs2LLUTQ0w8jLXGHqcQh1TafVLLWvzrGjUCDDozeaZa6qI8
	Qu5ACivlbrXsG4WFON/86/PldsEndDomAl8HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MLpEZwWm3sR6I/ZfH4Afn/3vA0RGbs06
	0SM0RRBydSlfXC4y+QF/k9gS36yLSHzfnFqIgkX65tQOAWoDPGnH+8+qyFU7gD2p
	T61tyk+8phbGAIsDMFQwyay0py8KGb6++r8rks+un0sz8hfjADnctxzHO1zgO+Kl
	h7LVQpucXWY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19F99C2FDE;
	Thu,  8 Jul 2010 09:31:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34B88C2FDC; Thu,  8 Jul
 2010 09:31:15 -0400 (EDT)
In-Reply-To: <201007081057.51946.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 8 Jul 2010 10\:57\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1755985E-8A95-11DF-9EF1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150573>

Jakub Narebski <jnareb@gmail.com> writes:

> Now that's Git Together '10 comes near, I wonder if it would be possible
> to have updated "Git Chronicles".  It was two years of development ago.
> Hopefuly Junio still has tools he used to generate data for this talk.

The tools are unfortunately very small parts of the story.

> One of graphs shown was growth of git codebase and of git contributors.
> Did git development stabilized during those two years since 2008, or
> does it still reads as active rather than stable development?
>
> Another interesting graphs was plot showing number of surviving lines 
> added in a give release relative to mumber of all lines added in said 
> release.  This was used to detect which releases were important ones.
> Were there any releases between 2008 and 2010 of significant importance?

These two are both interesting questions to ask, and luckily they are
mostly mechanical.  I'll try to dig up the tools to help generate them.

> The slides for "Git Chronicles" from 2008 closed with timelines of git 
> features.  Were there any important user-visible features added since 
> 2008 (notes, sparse checkout, "smart" HTTP)?

This was produced manually, out of release notes, blame output from the
Documentation/, as "feature dates" cannot be discerned mechanically
(e.g. history of "blame annotate shootout" needs to be written by somebody
who can tell that the current "git blame" came from "git pickaxe"
experiment, and all three variants were written from the general algorithm
description without code I wrote a long time ago).

> What might be also interesting is a descriotpion of how some important 
> feature came into being, with hint of an idea, discussions, prototypes, 
> failed starts, dropped patches, reworkings, accepted version and then
> improvements.  If one is not watching git mailing list regularly for a 
> longer time, what one sees is the final product.  One doesn't know what 
> it might to take to get a large feature into git...

Yes, it would be very interesting.  Will you volunteer to be one of the
git chroniclers?  It was a lot of work back then, and I don't think I can
do this properly as a two-day hack-job by myself.
