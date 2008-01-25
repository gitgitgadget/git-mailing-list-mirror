From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] Discard "deleted" cache entries after using them to update the working tree
Date: Fri, 25 Jan 2008 15:53:35 -0800
Message-ID: <7v63xh5uo0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801251820330.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIYNI-0006Fc-7w
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 00:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYAYXxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 18:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbYAYXxs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 18:53:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYAYXxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 18:53:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19CBD6E99;
	Fri, 25 Jan 2008 18:53:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FFFB6E98;
	Fri, 25 Jan 2008 18:53:41 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801251820330.13593@iabervon.org> (Daniel
	Barkalow's message of "Fri, 25 Jan 2008 18:24:52 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71756>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It's likely that this should get merged in some way with Linus's series to 
> handle the in-core index differently in general. But this is a simple 
> solution to the problem that's sufficient for this particular series.

Just to let you know, the early parts of lt/in-core-index series
are already in 'next', and it will be one of the first topics to
graduate to 'master' post 1.5.4.

I think we both understand that this round is sent purely for
discussion and I won't be picking them up right now nor later
before the "for possible inclusion" resend you will be making
post 1.5.4, so it should not matter too much which exact version
this round is based on.

It however may be worthwhile for you to plan rebasing your
future rounds on top of 077c48df8a72b046a2f562fedffa1c3d3a73a4e2
(read-cache.c: fix a couple more CE_REMOVE conversion).

Thanks.
