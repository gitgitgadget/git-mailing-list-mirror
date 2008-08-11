From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Mon, 11 Aug 2008 11:54:08 -0700
Message-ID: <7vbpzzxu0f.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org>
 <7vvdya55ur.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808111256260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScY3-0007Bj-9S
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYHKSyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbYHKSyQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:54:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYHKSyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:54:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8028555C01;
	Mon, 11 Aug 2008 14:54:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2A5D55BFD; Mon, 11 Aug 2008 14:54:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808111256260.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 11 Aug 2008 13:01:40 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E47EBA6A-67D6-11DD-BC15-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91973>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Don't get me wrong.  I do not need that patch in git.git desperately.  
> But if it is rejected, I want it to be rejected for reasons I understand.

You are the second person in the past few days to talk about rejection
after my comments.  I'll try to do better in the future, but if it was not
clear, I thought the original is good enough for inclusion as-is.

My comments were about potential improvements on top of what was
presented, and I say "potential" not in the sense that yours is inferior
than the ideal because it lacks such improvements, but in the sense that
the suggested line of thought might not be even an improvement (iow, I do
not mean "the code your patch brings is has potential to improve and not
good enough as it stands", but "I think we might also want to do these on
top of it, but I may well have overlooked downsides in my suggestion hence
I am bringing it up for discussion").
