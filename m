From: Junio C Hamano <gitster@pobox.com>
Subject: What's in "What's cooking"
Date: Thu, 01 Aug 2013 14:44:59 -0700
Message-ID: <7v7gg5qe5g.fsf@alter.siamese.dyndns.org>
References: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 23:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V50gI-0008UE-Fh
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 23:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311Ab3HAVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 17:45:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227Ab3HAVpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 17:45:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A78593551C;
	Thu,  1 Aug 2013 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b+d5t5bxX/AAFerMJ/VH3+eZVCg=; b=hUy1Q2
	DOZOlCqFaoYIkVs5MaIPmMvguHTLYUm5QqXdWvY/LD8iKfQGkBaRB6TejUXO5meG
	3bNMbgvQg29TWy1TZlGCGOCxlyiJbCq3ZAGrZcxscwU5jl5R4o9pHPfFGXalIPoy
	A5nZzcQju+abcgANQWVptQVi/3S/lU9o20uX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Czz2zDZE31dfXJL4oIcxhS0EIo/q2URi
	4bjHDj46dVln0iG/ExQJC8sAa01fzZX87vZHRnx/qdCUTMJyIYljZj5nv+zkoNfg
	lyQA4y8AANL6fcE+bFFyyFen+DhVpij8lGK4Mdb2aSqdjzyjm0L5pKonqA+b+TH8
	STQhj/O8eYM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE383551B;
	Thu,  1 Aug 2013 21:45:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D06BE35516;
	Thu,  1 Aug 2013 21:45:01 +0000 (UTC)
In-Reply-To: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Aug 2013 14:44:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E8DC4C8-FAF3-11E2-A4CB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231509>

Here is a note to explain various sections and what the readers on
this list are expected to read from them in the periodic "What's
cooking" summary.  This probably should be integrated in the periodic
"A note from the maintainer" posting eventually.

The first part is mostly a boilerplate message, but the second
paragraph of it often explains where in the development cycle we are.
The latest one (issue #1 of this month) said:

    The first release candidate v1.8.4-rc1 has been tagged; only
    regression fixes and l10n updates from now on.

The preamble is followed by various sections, each listing topics in
different "doneness".

Each topic looks like this:

  * nd/sq-quote-buf (2013-07-30) 3 commits
    (merged to 'next' on 2013-08-01 at dc7934a)
   + quote: remove sq_quote_print()
   + tar-tree: remove dependency on sq_quote_print()
   + for-each-ref, quote: convert *_quote_print -> *_quote_buf

   Code simplification as a preparatory step to something larger.

   Will cook in 'next'.

A line that begins with a '*' has the name of a topic, the date of the
last activity on the topic and the number of changes in the topic.
Then each commit on the topic is listed with prefix ("+", "-" or ".").
The ones with "+" are already on 'next', and the dates when they were
merged to 'next' also appear on this list. This will give readers the
rough idea of how long the topic has been cooking in 'next' (the
branch active bug hunters and early adopters are expected to be
running) to measure the "doneness".

The list of commits on the topic is often followed by a few lines of
free-form text to summarize what the topic aims to achieve. This often
goes literally to the draft release notes when the topic graduates to
'master'.  Also I annotate my short-term plan for the topic ("Will
cook in 'next' in the above example); it is very much appreciated if
readers raise timely objections to this plan (e.g. "Don't merge it
yet, it is broken --- see that discussion thread").

The [New topics] section lists topics that were not in my tree when
the previous issue of "What's cooking" was sent.

The [Graduated to "master"] section lists topics that have been
merged to 'master' since the previous issue. Even if you are not an
active bug hunter, please exercise the features/fixes these topics
brings to the system, as breakages or regressions caused by these
will appear in the next release if they are not noticed and fixed.

The [Stalled] section lists topics whose discussion has stalled, or
re-rolled patches have not been seen for a while after the topic
received review comments. This section is listed here so that people
interested in the topics in it can help the owners of them to move
things forward.

The [Cooking] section lists the remainder of the topics. They are
making normal progress and are no cause for worries in general.
Those whose commits are all in "next" are often just simmering to
give time to active bug hunters find unexpected problem in them.
those whose commits are not in "next" yet are still going through
review/revise cycle until they become ready.
