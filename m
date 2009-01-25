From: Junio C Hamano <gitster@pobox.com>
Subject: The lifecycle of a patch and the maintainer involvement
Date: Sun, 25 Jan 2009 12:35:30 -0800
Message-ID: <7v3af7dsz1.fsf@gitster.siamese.dyndns.org>
References: <18805.64312.289059.660023@hungover.brentg.com>
 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
 <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
 <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
 <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
 <18808.39712.351656.138702@hungover.brentg.com>
 <alpine.LNX.1.00.0901221117110.19665@iabervon.org>
 <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
 <18809.60512.654436.59819@hungover.brentg.com>
 <alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
 <18811.32772.728276.923430@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBj7-0001Bq-Ju
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbZAYUfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbZAYUfk
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:35:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbZAYUfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:35:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62D5993269;
	Sun, 25 Jan 2009 15:35:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7E9FA93266; Sun,
 25 Jan 2009 15:35:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA599666-EB1F-11DD-87F6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107098>

Brent Goodrick <bgoodr@gmail.com> writes:

> While I'm at it, what is the standard procedure for submitting git
> patches for review once I've cooked up and validated it on my end? I'm
> guessing posting the patch into this mailing list is part of the
> answer to that question.

Yes, a guideline is in Documentation/SubmittingPatches for the initial
submission.  After that, the lifecycle of a patch submitted on the list
goes like this:

 (1) A patch is shown to the list participants.

 (2) People may like it, or may have issues with it, and responds with
     their comments describing problems, suggestions for improvements,
     etc.  People who are not interested in the topic may stay silent.

 (3) The original author responds with updated patch.  Sometimes people
     who commented on in step 2 may even send "here is how I would do this
     one; don't you think this is better?", and the original author may
     say "Yeah, let's use yours instead".

 (4) After steps 2 and 3 repeats zero or more times, the latest patch may
     become one that everyone likes, or at least nobody has trouble with
     inclusion.  The author sends such a patch saying "this is meant for
     inclusion based on discussion and refinements in these threads...".

 (5) The maintainer picks it up when it looks polished enough.

Your patch may appear in the periodical "What's cooking" or "What's in"
summary with zero iteration of steps 2 and 3 if it is obvious enough.

I act as just one of the list participant during steps 1-3.  I may stay
silent during this period but that only means the topic is not interesting
to me and nothing more.  It does not mean that the topic has no chance of
getting included.

I act as the maintainer for steps 4 and 5.  If you do not hear from me
after step 4, then I am either being lazy, busy, or sick, or the patch got
lost in the noise and I need a reminder.  Note that I may reject or ask
further refinement at step 4 to ensure overall quality throughout the
system even in areas I am not interested in and didn't say anything during
steps 1-3.
