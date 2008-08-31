From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Announce: gitbuilder, an autobuilder for git-based projects
Date: Sat, 30 Aug 2008 20:29:32 -0700
Message-ID: <7v1w05g8v7.fsf@gitster.siamese.dyndns.org>
References: <32541b130808302007r3d570aa8ka221f210251944ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 05:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZdez-0000os-4x
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 05:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbYHaD3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 23:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbYHaD3i
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 23:29:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbYHaD3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 23:29:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C4FB6E173;
	Sat, 30 Aug 2008 23:29:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6CD3F6E172; Sat, 30 Aug 2008 23:29:34 -0400 (EDT)
In-Reply-To: <32541b130808302007r3d570aa8ka221f210251944ba@mail.gmail.com>
 (Avery Pennarun's message of "Sat, 30 Aug 2008 23:07:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09A457C4-770D-11DD-B7EB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94450>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> I set up the same autobuilder tool for a couple of our projects at
> work, which have more interesting output since our developers are
> somewhat less careful to make sure the tests pass before committing.
> git.git is a bit boring to look at because Junio is apparently so good
> at his job.

Thanks for the compliments, but it is easy for the integrator to be "so
good".  I only have to apply patches and if the result or the result of
merging that to 'next' does not pass the test, I just reject it to have
the original submitter handle the fallouts ;-).

It is quite a different story for leaf level developers.
