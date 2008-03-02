From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] log/show/whatchanged: introduce format.pretty
 configuration
Date: Sun, 02 Mar 2008 09:00:42 -0800
Message-ID: <7vir05oybp.fsf@gitster.siamese.dyndns.org>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
 <1204448753-4471-1-git-send-email-crquan@gmail.com>
 <1204448753-4471-2-git-send-email-crquan@gmail.com>
 <1204448753-4471-3-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrZB-00032p-15
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbYCBRA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbYCBRA6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:00:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbYCBRA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:00:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC85A1333;
	Sun,  2 Mar 2008 12:00:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 24FBC1331; Sun,  2 Mar 2008 12:00:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denis Cheng <crquan@gmail.com> writes:

> When running log/show/whatchanged from the command line, the user may
> want to use a preferred format without having to pass --pretty=<fmt>
> option every time from the command line.  This teaches these three
> commands to honor a new configuration variable, format.pretty.
>
> The --pretty option given from the command line will override the
> configured format.
>
> The earlier patch fixed the only in-tree caller that runs these
> commands for a purpose other than showing the output directly to the
> end user (the other in-tree caller is "git bisect visualize", whose
> output directly goes to the end user and should be affected by this
> patch).
>
> Signed-off-by: Denis Cheng <crquan@gmail.com>

I see you pretty much copied my suggested commit log messages except that
you dropped the warning about the need to adjust out-of-tree scripts by
end users from this one.  I however think that was the most important
part.  We need to warn our users fairly aggressively in Release Notes
about possible compatibility issues, and commit log messages are one of
the most important sources for that.

Incidentally, I noticed only one when I wrote the above but now we have
more, so "the only in-tree caller that runs" part is totally bogus.

No need to resend anything, as I can manage with these three messages.

Thanks.
