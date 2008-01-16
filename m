From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 09:22:53 -0800
Message-ID: <7vhchdsn0y.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBzE-0008MW-Av
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYAPRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYAPRXG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:23:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbYAPRXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:23:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DAEC4440;
	Wed, 16 Jan 2008 12:23:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD154441D;
	Wed, 16 Jan 2008 12:22:55 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 19:26:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70703>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I do not think it's true that "--no-prefix" (or --src/dst-prefix) 
> necessarily implies "no-git" at all. It *can* do so, but it's not a given 
> thing, and almost certainly isn't in the long run with submodule support. 
>
> So it would be kind of sad if we mixed it up with the prefix decision, 
> when it really is something totally separate. Many other SCM's may want a 
> simple "-p1" patch (BK did, for example), and that doesn't make them 
> particularly "git-like". And conversely, git itself will want more than a 
> simple "-p1" patch for subproject handling.

Ok.  That's a sensible argument.
