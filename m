From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 02 Jun 2008 21:29:47 -0700
Message-ID: <7vy75n3zus.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 06:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3OAa-0005Tv-SE
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 06:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbYFCE34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 00:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYFCE34
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 00:29:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYFCE34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 00:29:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B7BB34C2;
	Tue,  3 Jun 2008 00:29:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A0E4E34C1; Tue,  3 Jun 2008 00:29:49 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 2 Jun 2008 19:05:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6F85F02-3125-11DD-845A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83614>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Actually, it's trivial to convert to other SCM's, although I guess the 
> conversion tools haven't really tried. You can always turn it into a 
> series of multiple merges. Yes, you lose information, but it's not like 
> you lose a huge amount.

One thing to worry about is what tree object you would give to each of
these "artificially split" merge commits, though.
