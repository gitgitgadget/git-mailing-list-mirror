From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Sun, 02 Nov 2008 01:30:46 -0700
Message-ID: <7vprle1qdl.fsf@gitster.siamese.dyndns.org>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
 <20081029164253.GA3172@sigill.intra.peff.net>
 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 09:33:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwYOs-00022W-Si
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 09:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYKBIbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 03:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYKBIbK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 03:31:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYKBIbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 03:31:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 33C52777D5;
	Sun,  2 Nov 2008 03:31:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 58F30777AD; Sun,  2 Nov 2008 03:30:53 -0500 (EST)
In-Reply-To: <20081029171122.GA12167@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Oct 2008 13:11:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 979B993E-A8B8-11DD-9F5D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99821>

Jeff King <peff@peff.net> writes:

> If we assume that we have only the word "stage" and variations
> available, then there aren't too many options.
>
>   only the staging area:
>     --stage-only, --staged-only
>
>   both:
>     --staged (as opposed to --staged-only) --stage-and-worktree (too
>     long), --both (not descriptive enough), --stage-too (yuck)

A flag "--staged" that means "staged changes and changes in the work tree"
is no worse than the current "--index".  If we were to shoot for clarity,
how about --staged-only (aka --cached) vs --staged-and-unstaged (aka --index)?

I am actually actively unhappy about the latter, but I like more
descriptive --staged-only for the former a lot better.
