From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
 branch-name
Date: Sun, 12 Apr 2009 01:22:23 -0700
Message-ID: <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com>
 <200904092119.10520.mlevedahl@gmail.com>
 <7vbpr519jq.fsf@gitster.siamese.dyndns.org>
 <200904111301.31250.mlevedahl@gmail.com>
 <20090412072056.GA25837@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 12 10:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsv1S-0003YH-4R
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 10:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbZDLIWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 04:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756343AbZDLIWe
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 04:22:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZDLIWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 04:22:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4667EEFC9;
	Sun, 12 Apr 2009 04:22:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A0498EFBE; Sun,
 12 Apr 2009 04:22:26 -0400 (EDT)
In-Reply-To: <20090412072056.GA25837@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 12 Apr 2009 03:20:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 109A2FF2-273B-11DE-BDA4-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116371>

Jeff King <peff@peff.net> writes:

> And I can see why you might think of it that way, because that is what
> the synopsis in git-checkout(1) says. :) But it is really:
>
>   git checkout -b <branch> <commit>
>
> I'm not sure if changing that synopsis would really help, or if it is
> a bit too subtle.

I think in many places we used to be stricter in terminology (e.g. when we
only need tree-ish we used to write tree-ish) but during the "usability
and approachiablility drive" people updated doc with "most of the time the
command takes commit, so we say commit".

I think "the apporachable part" aka "synopsis" should be kept the way it
is, but we should clarify in the description when the most general form is
different from the white lie we feed to newbies.
