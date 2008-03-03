From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] allow git-am to run in a subdirectory
Date: Mon, 03 Mar 2008 09:01:57 -0800
Message-ID: <7vod9vivwa.fsf@gitster.siamese.dyndns.org>
References: <20080301062255.GA27538@coredump.intra.peff.net>
 <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
 <20080301081235.GA31855@coredump.intra.peff.net>
 <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org>
 <20080303065808.GA22810@coredump.intra.peff.net>
 <7vhcfojndo.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803031152270.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWE3x-0006oB-N6
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYCCRCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYCCRCK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:02:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYCCRCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:02:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9C7B14BF;
	Mon,  3 Mar 2008 12:02:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5A1B414BE; Mon,  3 Mar 2008 12:02:00 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803031152270.22527@racer.site> (Johannes
 Schindelin's message of "Mon, 3 Mar 2008 11:53:38 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75945>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Concur.  While at it, we could move both .dotest/ and .git/.dotest-merge/
> to .git/dotest/, no?

We could, yes, while at it, no.
