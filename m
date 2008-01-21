From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "pull --rebase" try to be a little cleverer?
Date: Mon, 21 Jan 2008 10:21:02 -0800
Message-ID: <7vir1nxcoh.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 19:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1HG-0000se-Sy
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYAUSVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYAUSVQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:21:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYAUSVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 13:21:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C37D45D4;
	Mon, 21 Jan 2008 13:21:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6DE45D0;
	Mon, 21 Jan 2008 13:21:09 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801211542150.5731@racer.site> (Johannes
	Schindelin's message of "Mon, 21 Jan 2008 15:47:13 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71303>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, if we already have refs/remotes/blabla/master, we could DWIM the 
> --rebase call to
>
> 	git rebase --onto FETCH_HEAD refs/remotes/blabla/master

FWIW, I like it, and I think that is what users expect it to do.
