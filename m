From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 21:34:55 -0800
Message-ID: <7vk5kyyirk.fsf@gitster.siamese.dyndns.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
 <alpine.LSU.1.00.0802202221130.17164@racer.site>
 <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
 <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
 <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
 <alpine.LNX.1.00.0802202351400.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS46G-0006iZ-Dk
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbYBUFfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYBUFfa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:35:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYBUFf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:35:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 161041201;
	Thu, 21 Feb 2008 00:35:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 C36A011DC; Thu, 21 Feb 2008 00:35:17 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802202351400.19024@iabervon.org> (Daniel
 Barkalow's message of "Thu, 21 Feb 2008 00:04:38 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74599>

Daniel Barkalow <barkalow@iabervon.org> writes:

> [url "rewritten"]
> 	insteadOf = "original"

That's much clearer than anything I've seen in this thread which
one is the one you cannot use yourself and which one is what you
have to use to get it to work.
