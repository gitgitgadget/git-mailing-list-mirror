From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] config: Codestyle cleanups.
Date: Wed, 18 Feb 2009 11:02:23 -0800
Message-ID: <7v8wo3y3eo.fsf@gitster.siamese.dyndns.org>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <bd6139dc0902170833r7e6672f4p831dacb2ed841b32@mail.gmail.com>
 <94a0d4530902180118j4746a690q7a42ea087e23488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZriH-0000gU-R7
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZBRTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZBRTCd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:02:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZBRTCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:02:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 146142B686;
	Wed, 18 Feb 2009 14:02:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 291042B683; Wed,
 18 Feb 2009 14:02:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0C421A2-FDEE-11DD-8D78-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110567>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hmm, right. I was thinking on Junio and Johanness that already know
> the context, so they don't need an introduction, but I forgot about
> other people that might be interested in giving this a review.

Also please don't assume anything about what other people may remember
from your earlier series, after you received "this round is not ready to
be applied because of this and that" comments.  As far as the reviewer is
concerned, that's the end of the story about the entire series, until you
send a revised one.  The reviewers are not promising to remember the fine
details of the code and to help you improve the series, thinking about the
series all the time until its next round materializes by reviewing the
first round, and it is unrealistic to expect them to.  There are a lot
more patches and patch writers than there are people who review them.

The reason you are encouraged to say want was changed since the previous
series when you are sending v(n+1) patch in each patch after three-dash
lines is exactly because by default we expect reviewers remember nothing
about the previous round and jogging their memory in such a way would help
reviewing the new round.
