From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: More on --pretty with git-diff-tree
Date: Sun, 27 Apr 2008 18:39:12 -0700
Message-ID: <7vlk2yep1b.fsf@gitster.siamese.dyndns.org>
References: <200804271940.44940.jnareb@gmail.com>
 <7vzlrfdmm4.fsf@gitster.siamese.dyndns.org>
 <200804280018.36470.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 03:40:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqILm-0003hW-QF
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 03:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYD1Bj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 21:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbYD1Bj1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 21:39:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYD1Bj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 21:39:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CC674025;
	Sun, 27 Apr 2008 21:39:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 71DDA4024; Sun, 27 Apr 2008 21:39:19 -0400 (EDT)
In-Reply-To: <200804280018.36470.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 28 Apr 2008 00:18:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80496>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, can one choose one of parents to be shown in ''for the
> commit'' mode, or it is only combined (-c, --cc) or all (-m)?

Not without using "diff $C^$N $C", no, I do not think so, and that form
will be two-tree case so you won't get a log.

When you treat all parents as equals, there is no good definition of a
single patch for the commit for a merge.
