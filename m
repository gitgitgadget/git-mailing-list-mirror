From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Sat, 09 Feb 2008 18:07:34 -0800
Message-ID: <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<20080209030046.GA10470@coredump.intra.peff.net>
	<6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
	<alpine.LSU.1.00.0802091307160.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1cE-0007LU-6D
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbYBJCHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbYBJCHt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:07:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYBJCHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:07:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0992724F7;
	Sat,  9 Feb 2008 21:07:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6796924F4;
	Sat,  9 Feb 2008 21:07:41 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802091307160.11591@racer.site> (Johannes
	Schindelin's message of "Sat, 9 Feb 2008 13:10:21 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73291>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The way would be like this, I think:
>
> - introduce a command line option for push, like "--push-common-refs", and 
> issue a warning whenever "git push" is called without command line 
> options (along the lines "This default behaviour is deprecated; please use 
> --push-common-refs").
>
> - in a waaaay later version, just take away the default action of "git 
> push", instead showing the usage.

I do not think that is a right approach.  To please both camps
without forcing people to

 (1) change what they are used to, and
 (2) type overlong command line,

I think the traditional "matching refs by default", combined
with "'git push HEAD' defaults to pushing the current branch to
the default location" would be a well balanced compromise.
