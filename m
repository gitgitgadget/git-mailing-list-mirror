From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git
 push)
Date: Sat, 16 Feb 2008 23:37:31 -0800
Message-ID: <7vy79k2fus.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802162202310.5496@iabervon.org>
 <7v4pc843yg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802170114440.5496@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 08:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQe6w-0004Pf-VI
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 08:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbYBQHhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbYBQHhu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:37:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbYBQHht (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:37:49 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D07E266E;
	Sun, 17 Feb 2008 02:37:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 BCEC1230F; Sun, 17 Feb 2008 02:37:33 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802170114440.5496@iabervon.org> (Daniel
 Barkalow's message of "Sun, 17 Feb 2008 01:39:27 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74097>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'm also in part worried about the lack of publicity "struct branch" has 
> gotten; it would have saved you having to write 64 of 136 lines, so it's 
> worth you knowing about.

Actually, I initially took a look at branch.h and tried to reuse
find_tracked_branch() but then realized it was a wrong interface.
The "struct branch" in remote.h (Heh) looks like the right
interface.

Documentation/technical/api-*.txt should really talk about
what's in remote.c.
