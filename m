From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Tue, 27 Nov 2007 16:11:29 -0800
Message-ID: <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
	<alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
	<Pine.LNX.4.64.0710260007450.4362@racer.site>
	<7v3avy21il.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710261047450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxAWw-00019H-UE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 01:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbXK1ALg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 19:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758171AbXK1ALg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 19:11:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52601 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048AbXK1ALf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 19:11:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6D3782EF;
	Tue, 27 Nov 2007 19:11:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EDCC79A61B;
	Tue, 27 Nov 2007 19:11:52 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0710261047450.4362@racer.site> (Johannes
	Schindelin's message of "Fri, 26 Oct 2007 10:52:26 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66278>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> I do not want to go into _that_ many details here, since the place to look 
> for it is git-rebase.txt.  Probably I should have done that in the first 
> place.
>
> So how about this instead:
>
> \--rebase::
>         Instead of a merge, perform a rebase after fetching.
>         *NOTE:* This is a potentially _dangerous_ mode of operation.  
> 	It rewrites history, which does not bode well when you
> 	published that history already.  Do _not_ use this option
> 	unless you have	read gitlink:git-rebase[1] carefully.
>
> Hmm?

Okay.
