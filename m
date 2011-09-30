From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri, 30 Sep 2011 11:37:51 -0700
Message-ID: <7vwrcpoozk.fsf@alter.siamese.dyndns.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:38:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9hyC-0006FG-DO
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 20:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194Ab1I3Sh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 14:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755879Ab1I3Shz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 14:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF655F3F;
	Fri, 30 Sep 2011 14:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L2TA7lJEcZzTRdyasx7xK3bNCvM=; b=Fw+kwT
	rVuKJ0YpclBljX6Yz6x3E1NEOaw/HviKnLR4j4PQOvDgLusZgUcczlyI67Omnqny
	4KR2wD6EnmpzQg4P13KtsBdHLI3CYxixUaUzRu9Rpe65r9QHmNmLzD9x6krD2ZpV
	dni1O8znTRPL6RaD6cbpsDJI7QaYtiC80GCQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pf98gIaTaSKsq4TsS1GiWI+Glfw07VzK
	UlYMkCY4FYsItzLRFNUSqFfhZcHepvZLBllLt3G+LmmD2kF1U6v36gqt8gc+BsBH
	FdTfUx2KS3vVdyLPzxHaYm44a9YNNpQVmrha6TNPeWDunqgM56Z4CGNHHtS0fSIf
	m9LuKqK1jvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E3E5F3E;
	Fri, 30 Sep 2011 14:37:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB7A15F3D; Fri, 30 Sep 2011
 14:37:53 -0400 (EDT)
In-Reply-To: <loom.20110930T041939-332@post.gmane.org> (Peter Shenkin's
 message of "Fri, 30 Sep 2011 02:51:21 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EF3E71A-EB93-11E0-A5F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182500>

Peter Shenkin <shenkin@gmail.com> writes:

> Perhaps it will be useful to say what would have been most
> helpful for me. In the current documentation for "fetch
> --tags", one sentence reads, "This flag lets all tags and
> their associated  objects be downloaded." The following small
> modification would, IMO, be sufficient: "This flag causes all
> tags and their associated objects (only) to be downloaded."

Hmm, from time to time we seem to see this kind of documentation
suggestion where:

 - We (try to) describe what xyzzy does by saying "This is what xyzzy
   does". We specifically do not say "In addition to what normally
   happens, xyzzy causes these additional things to happen."

 - The reader (somehow) assumes xyzzy does more than what we described in
   the documentation, even we did not say "In addition to..."; and then

 - A patch is proposed to add "these other things are _not_ done", after
   existing "This is what xyzzy does".

And it is not limited to the description of this particular option.

I think in general our documentation aims to spell out _all_ that happens,
and explicitly say "In addition to what normally happens", "This page
lists only the most common ways", etc., when such a clatification is
needed.

I am wondering if there is a systemic failure that gives an impression
that by default the documentation is incomplete and all other unspecified
thing also happens to the readers? If so are there things that we could
do better without going through individual description?
