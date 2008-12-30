From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -i: learn to rebase root commit
Date: Tue, 30 Dec 2008 00:22:26 -0800
Message-ID: <7vhc4m3we5.fsf@gitster.siamese.dyndns.org>
References: <cover.1230568082.git.trast@student.ethz.ch>
 <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch> <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch> <200812292249.45900.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHZtQ-0005AP-5G
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 09:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbYL3IWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 03:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbYL3IWd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 03:22:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYL3IWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 03:22:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C9278BBFB;
	Tue, 30 Dec 2008 03:22:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3A40F8BBFA; Tue,
 30 Dec 2008 03:22:28 -0500 (EST)
In-Reply-To: <200812292249.45900.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 29 Dec 2008 22:49:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0081EEE8-D64B-11DD-A988-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104168>

Thomas Rast <trast@student.ethz.ch> writes:

> ... is there any sensible
> use/interpretation of -p --root that I'm missing?  Or should it just
> disallow this combination?

If --root is about replaying all the history, wouldn't people want to use
it together with -p to reconstruct the whole history as a substitute for
filter-branch?  IOW, I have a suspicion that they most likely should go
together.

I never felt a need to rebase deep down to --root myself anyway, so I am a
bad judge for people's needs on this topic, though.
