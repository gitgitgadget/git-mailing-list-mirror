From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 09:19:04 -0700
Message-ID: <7vd4oac5qf.fsf@gitster.siamese.dyndns.org>
References: <20080427151610.GB57955@Hermes.local>
 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
 <7vej8rgq62.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:21:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqW5Z-00071w-6y
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbYD1QTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933806AbYD1QTQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:19:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbYD1QTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:19:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10EF35CEA;
	Mon, 28 Apr 2008 12:19:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6D72D5CE9; Mon, 28 Apr 2008 12:19:06 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> (Johannes
 Schindelin's message of "Mon, 28 Apr 2008 11:13:04 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80552>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe an example would help:
>
> -- snip --
> pick abcdefg This is the first commit to be picked
> reset cdefghij
> pick zyxwvux A commit in a side-branch
> merge recursive abcdefg
> -- snap --

Indeed it does.  "reset cdefghij" --- does it reset to the exact cdefghij
commit, or cdefghij commit after rewriting?
