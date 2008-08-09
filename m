From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Sat, 09 Aug 2008 11:44:12 -0700
Message-ID: <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 20:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRtRs-0005yA-2u
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 20:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYHISoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYHISoU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 14:44:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYHISoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 14:44:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B1E575227A;
	Sat,  9 Aug 2008 14:44:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C654D52278; Sat,  9 Aug 2008 14:44:14 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 9 Aug 2008 16:00:12 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C8B291E-6643-11DD-A5A0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91771>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What does the user most likely want with this command?
>
> 	$ git checkout --track origin/next
>
> Exactly.  A branch called 'next', that tracks origin's branch 'next'.

I like this.

An explicit --track request from the command line (as opposed to happening
to have "branch.autosetupmerge" configuration) is a very good cue that
what the user wants to do is not to take a peek on a detached HEAD but a
more permanent playpen created.
