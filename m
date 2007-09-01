From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Sat, 01 Sep 2007 02:40:22 -0700
Message-ID: <7vabs6u3jt.fsf@gitster.siamese.dyndns.org>
References: <tzqfsijk.fsf@cante.net>
	<7vy7frzfzg.fsf@gitster.siamese.dyndns.org> <hcmesrse.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRPSx-0002Ob-DF
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbXIAJk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 05:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXIAJk1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:40:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbXIAJk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 05:40:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E21BF12C253;
	Sat,  1 Sep 2007 05:40:46 -0400 (EDT)
In-Reply-To: <hcmesrse.fsf@cante.net> (Jari Aalto's message of "Sat, 01 Sep
	2007 11:39:45 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57265>

Jari Aalto <jari.aalto@cante.net> writes:

> Like:
>
>     HEAD, HEAD~1, HEAD~2
>
> If the syntax is changed in the middle (as it was in manual page),
> that interrupts the kognitive flow of reading.
>
>     HEAD, HEAD^, HEAD~2
>

I still would prefer to teach people HEAD^ earlier.  If you _REALLY_
insist, I can live with spelling the HEAD~2 as HEAD^^ for
consistency.

Wasn't with you that earlier I discussed that very basic things
such as revision naming and range notation should be moved from
rev-list documentation to more central place, and sructure the
documentation in such a way that these should be read even
before individual manual pages are consulted?  If we follow
that, then by the time people read these examples, they _ought_
to know that HEAD~1 is a longer-to-type way to say HEAD^ already.
