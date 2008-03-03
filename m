From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] allow git-am to run in a subdirectory
Date: Sun, 02 Mar 2008 23:08:19 -0800
Message-ID: <7vhcfojndo.fsf@gitster.siamese.dyndns.org>
References: <20080301062255.GA27538@coredump.intra.peff.net>
 <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
 <20080301081235.GA31855@coredump.intra.peff.net>
 <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org>
 <20080303065808.GA22810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4nU-0007fw-TP
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYCCHIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 02:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYCCHIe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:08:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYCCHId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:08:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D2461150;
	Mon,  3 Mar 2008 02:08:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E23A8114D; Mon,  3 Mar 2008 02:08:26 -0500 (EST)
In-Reply-To: <20080303065808.GA22810@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 3 Mar 2008 01:58:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75896>

Jeff King <peff@peff.net> writes:

> The only other file parameter is
> $dotest. If I do "cd t && git am --dotest=.foo", then should it be
> "t/.foo" or ".foo"?

That brings up an interesting point.

Have people actually used --dotest=<foo> ever?

As far as I know, I do not think it was useful in the real world.  Too
many things assumed that the spool directory for "am" is .dotest.

And I am very much tempted to say we should remove that option.

