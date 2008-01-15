From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] treat any file with NUL as binary
Date: Tue, 15 Jan 2008 15:11:07 -0800
Message-ID: <7vsl0yd6r8.fsf@gitster.siamese.dyndns.org>
References: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEuwo-0005rm-Kc
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbYAOXLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbYAOXLb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:11:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYAOXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:11:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 860C3763E;
	Tue, 15 Jan 2008 18:11:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 16A66763D;
	Tue, 15 Jan 2008 18:11:23 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70575>

Dmitry Potapov <dpotapov@gmail.com> writes:

> So, please, consider it for inclusion as a bug fix.

Somebody has to go back to the "git log" output and the list
archive to see if you two did not forget other ramifications,
because I vaguely recall this 1% thing was done for a reason and
Linus had a very good argument (at least back then the argument
sounded very good to me) supporting the deliberate difference
between the two "binary" heuristics.

If I did not have that vague recollection and all I had to judge
the proposed change were the issue in this thread, I'd probably
agree this is a good change, though.
