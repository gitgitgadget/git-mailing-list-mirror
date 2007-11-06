From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 18:51:14 -0800
Message-ID: <7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
	<7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711052325090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 03:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpEXV-00016p-2r
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 03:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbXKFCvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 21:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbXKFCvY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 21:51:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40055 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbXKFCvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 21:51:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0EF3B2F0;
	Mon,  5 Nov 2007 21:51:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C9B592B3B;
	Mon,  5 Nov 2007 21:51:40 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711052325090.4362@racer.site> (Johannes
	Schindelin's message of "Mon, 5 Nov 2007 23:40:46 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63615>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In the same way, I would expect "git revert <commit> -- file" to undo the 
> changes in that commit to _that_ file (something like "git merge-file 
> file <commit>:file <commit>^:file"), but this time commit it, since it 
> was committed at one stage.

Allowing people to revert or cherry pick partially by using
paths limiter is a very good idea; the whole "it comes from a
commit so we also commit" feels an utter nonsense, though.
