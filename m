From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove "nohup" from git-help--browse
Date: Sat, 09 Feb 2008 18:02:24 -0800
Message-ID: <7vbq6p7emn.fsf@gitster.siamese.dyndns.org>
References: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
	<1202502982-6822-1-git-send-email-dpotapov@gmail.com>
	<200802090653.43280.chriscool@tuxfamily.org>
	<20080209200351.GC30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1XS-0006Xf-In
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYBJCCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYBJCCk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:02:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYBJCCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:02:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B781225F;
	Sat,  9 Feb 2008 21:02:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B8816225C;
	Sat,  9 Feb 2008 21:02:31 -0500 (EST)
In-Reply-To: <20080209200351.GC30368@dpotapov.dyndns.org> (Dmitry Potapov's
	message of "Sat, 9 Feb 2008 23:03:51 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73289>

Dmitry Potapov <dpotapov@gmail.com> writes:

> So, I want to hear what other people think. If there is no objection,
> I will add this redirection.

I personally feel that we should not hide output from the
backend browsers by redirection.  Some may be chattier than
others, but then we would know against which browser to file bug
reports.

Just my two yen.
