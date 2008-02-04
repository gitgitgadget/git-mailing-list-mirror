From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 03 Feb 2008 19:05:17 -0800
Message-ID: <7vk5llmnf6.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
	<1201975757-13771-1-git-send-email-hjemli@gmail.com>
	<alpine.LSU.1.00.0802021815510.7372@racer.site>
	<alpine.LSU.1.00.0802021825220.7372@racer.site>
	<20080204015707.GH24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLreh-0008Cj-6M
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 04:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbYBDDF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 22:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYBDDFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 22:05:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbYBDDFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 22:05:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C28224B;
	Sun,  3 Feb 2008 22:05:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 52BCF224A;
	Sun,  3 Feb 2008 22:05:19 -0500 (EST)
In-Reply-To: <20080204015707.GH24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 3 Feb 2008 20:57:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72457>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The second biggest problem is checking out the same branch in two
> different directories at once.  This becomes a problem only if you
> modify the branch, but still, its a problem.

I agree.  The biggest benefit I am getting out of the workdir
layout is that it allows me to check out the same branch in two
directories, and let me work further on one while the other one
is compiling and running the testsuite.  The other "compile and
test tree" needs to be reset with --hard once I commit in the
"edit tree", but by definition "reset --hard" is always a safe
operation in a "compile and test tree".

In short, you need to know what you are doing.
