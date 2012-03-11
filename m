From: Junio C Hamano <gitster@pobox.com>
Subject: What's in "What's cooking"
Date: Sun, 11 Mar 2012 01:25:18 -0800
Message-ID: <7vaa3nzdz5.fsf@alter.siamese.dyndns.org>
References: <7vboo52q6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 10:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6f21-00060Z-Sw
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 10:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab2CKJZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 05:25:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab2CKJZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 05:25:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B36545D1C;
	Sun, 11 Mar 2012 05:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yH/6Yvv9LfW7DGChLCtOOeqv+js=; b=NsgrRP
	9lzSBH7zxBxDA7B4mifCe3x/XKZ4wwzm2P755btiSNiwcwt9z6O9uRbZvW0Cfl17
	DDGNu7cQRzXW4Jh1wKYKRxtC8KiRT/5ykOCpDi3t38tk2zfw5UOwrWLFLQ2pbBha
	spUayhq92NGSyczB74zkOd+XAlPxJwoO+JJJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVAwFCICr23vErzRc1jL9SdA+GKdiHbQ
	7It28FU6ra/b8AqczfkVKFh3yPH2dHBCq26EMdMR4rp2Ubv3TuBPo3mamUzzTlfn
	jQDKzYhyWl07kWjUIjh3Sj6SWR7GmSk925IlNCJLXiOo9Zzcds83V6vMdjtcii6N
	/6zkZbniC2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB6F55D1B;
	Sun, 11 Mar 2012 05:25:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2325A5D1A; Sun, 11 Mar 2012
 05:25:20 -0400 (EDT)
In-Reply-To: <7vboo52q6l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Mar 2012 17:35:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F25A192-6B5C-11E1-A4EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192799>

Here is a note to explain various sections and what the readers on
this list are expected to read from them in the periodic "What's
cooking" summary.  This probably should be integrated in the
periodic "A note from the maintainer" posting eventually.

The first part is mostly a boilerplate message, but the second
paragraph of it often explains where in the development cycle we
are.  The last one (issue #4 of this month) said:

   Trivially correct fixes to old bugs may still graduate to 'master',
   but otherwise we are mostly in "regression fixes only" mode until
   1.7.10 final (see http://tinyurl.com/gitCal for schedule).

The preamble is followed by various sections, each listing topics in
different "doneness".

Each topic looks like this:

  * cn/pull-rebase-message (2012-03-04) 1 commit
    (merged to 'next' on 2012-03-04 at 5a6cd58)
   + Make git-{pull,rebase} message without tracking information friendlier

  The advise message given when the user didn't give enough clue on what
  to merge was overly long.
  Will merge to 'master'.

A line that begins with a '*' has the name of a topic, the date of
the last activity on the topic and the number of changes in the
topic.  Then each commit on the topic is listed with prefix ("+",
"-" or ".").  The ones with "+" are already on 'next', and the dates
when they were merged to 'next' also appear on this list. This will
give readers the rough idea of how long the topic has been cooking
in 'next' (the branch active bug hunters and early adopters are
expected to be running) to measure the "doneness".

The list of commits on the topic is often followed by a few lines of
free-form text to summarize what the topic aims to achieve. This
often goes literally to the draft release notes when the topic
graduates to 'master'.  Also I annotate my short-term plan for the
topic ("Will merge to 'master' in the above example); it is very
much appreciated if readers raise timely objections to this plan
(e.g. "Don't merge it yet, it is broken --- see that discussion
thread").

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
