From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Sat, 09 Feb 2008 23:49:43 -0800
Message-ID: <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
	<vpq63x5swsj.fsf@bauges.imag.fr>
	<m3tzkp6eqz.fsf@localhost.localdomain>
	<20080210011203.GL25954@genesis.frugalware.org>
	<alpine.LSU.1.00.0802100125510.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 08:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO6xM-0006oD-FP
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 08:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbYBJHt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 02:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbYBJHt4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 02:49:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYBJHtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 02:49:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7E123D6;
	Sun, 10 Feb 2008 02:49:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AC78623CD;
	Sun, 10 Feb 2008 02:49:45 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802100125510.11591@racer.site> (Johannes
	Schindelin's message of "Sun, 10 Feb 2008 01:26:44 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73324>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you touch builtin-mv.c already, why not just move cmd_cp() in there?  
> It's not like it would be the first cmd_*() function living in the same 
> file as other cmd_*() functions.

Why do we even want "git-cp", especially when git-mv and git-rm
are already pretty much redundant commands?

Especially, why do we even encourage copy-and-paste?
