From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 15:56:54 -0700
Message-ID: <7vtz2x3ozt.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
	<7vtz2x6mor.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
	<7v8wk96knh.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031504080.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzOH-0000iz-G4
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZFCW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZFCW4x
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:56:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59662 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977AbZFCW4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:56:53 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603225655.KRLM20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Wed, 3 Jun 2009 18:56:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zawu1b00M4aMwMQ04awuer; Wed, 03 Jun 2009 18:56:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=S77OzZnDsBBdd-PZ6LoA:9 a=sq7gGz3X5W3CjYcRO5A9VDDDIAQA:4
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> (Linus Torvalds's message of "Wed\, 3 Jun 2009 15\:17\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120661>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Thinking more about it, we always did have fairly good workarounds for the 
> "we optimized away the history too aggressively" (ie the original 
> --full-history, and then the newer and nicer --simplify-merges).

This is offtopic, but there is a rather funny hidden feature in that
"newer and nicer" option.

    $ git log --simplify-merges -- no-no-no-such-path-ever-existed

will lists the merges that do not have any common ancestors.

I do not know where it comes from, or if it is worth fixing.
