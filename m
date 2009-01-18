From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Sat, 17 Jan 2009 18:13:48 -0800
Message-ID: <7vvdsd1hur.fsf@gitster.siamese.dyndns.org>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 03:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LONC3-0001bO-Cd
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 03:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZARCNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 21:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZARCNz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 21:13:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZARCNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 21:13:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DCCE91664;
	Sat, 17 Jan 2009 21:13:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C2C2291663; Sat,
 17 Jan 2009 21:13:49 -0500 (EST)
In-Reply-To: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sun, 18 Jan 2009 01:56:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A750F278-E505-11DD-8AEB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106134>

Thomas Rast <trast@student.ethz.ch> writes:

> I came up with this after sending two incomplete patches on the same
> night, and really like it.  Perhaps others might find it useful.

Any patch worth discussing (on this list at least) would need a nontrivial
commit log message that you need to really think while writing.  It is
natural to assume people would be making them with their editor, not with
"commit -m".  These two incomplete patches could have been avoided if you
paid attention to the status output that is in the commit log message
buffer.  Perhaps we should make it even louder in some way?
