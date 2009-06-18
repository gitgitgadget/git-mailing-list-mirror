From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify the git-branch documentation of default start-point
Date: Wed, 17 Jun 2009 22:48:49 -0700
Message-ID: <7vprd2148u.fsf@alter.siamese.dyndns.org>
References: <1245303673.24201.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 07:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHAUe-0008RG-0z
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 07:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZFRFst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 01:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbZFRFss
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 01:48:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34944 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbZFRFss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 01:48:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618054849.EBOT17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 01:48:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Hoq1c0094aMwMQ04HoqTo; Thu, 18 Jun 2009 01:48:50 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=pSkz-GRO83QA:10 a=pGLkceISAAAA:8
 a=iI5lSj6Mwn6nidUcx7kA:9 a=B1u8XedBA7ZLeVwmDHkA:7
 a=nwdUGdUSLAWYwNF1dR5IxH4-GB4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245303673.24201.3.camel@localhost.localdomain> (Martin Nordholts's message of "Thu\, 18 Jun 2009 07\:41\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121795>

Martin Nordholts <enselic@gmail.com> writes:

> -	is omitted, the current branch is assumed.
> +	is omitted, the current branch is assumed.  Note that checking
> +	out a remote branch does not make it the current branch.  If a
> +	remote branch is desired as start-point it must be an explicity
> +	specified.

The first new sentence says

	$ git checkout origin/next

does not mean you will be _on_ the remote branch, 'next' you got from me
in this example.  By definition you cannot be on anything but a local
branch, so the sentence is correct.

But "it" in the second new sentence is unclear.

You probably wanted to answer "If I wanted to have _my own 'next' branch_
that tracks 'next' from the remote, what should I do?"

And the answer would be either

	$ git checkout -t -b next origin/next

or its shorthand invented by Dscho which is

	$ git checkout -t origin/next

Now, is "it must be (an) explicit(l)y specified" a correct instruction to
lead the readers to these solutions?
