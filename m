From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 07 Feb 2008 01:10:02 -0800
Message-ID: <7vmyqdnndh.fsf@gitster.siamese.dyndns.org>
References: <20080206102608.GA1007@coredump.intra.peff.net>
	<47A98F07.4000402@viscovery.net>
	<20080206110131.GA4167@coredump.intra.peff.net>
	<7v4pclvmae.fsf@gitster.siamese.dyndns.org>
	<7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
	<20080207051317.GA32296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN2mR-00021T-S2
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYBGJKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbYBGJKN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:10:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYBGJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:10:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F265F347B;
	Thu,  7 Feb 2008 04:10:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6192A347A;
	Thu,  7 Feb 2008 04:10:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72914>

Jeff King <peff@peff.net> writes:

> In fact, the more I think about it, that makes sense. WORK_TREE munging
> just happens to be the only special behavior right now that depends on
> whether the user manually set GIT_DIR. But what we really want to
> communicate to later code is not "I have corrected this particular
> munge" but "don't run any special behavior as a result of this variable
> being set."

Yeah, that makes sense.
