From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 15:28:20 -0800
Message-ID: <7v7ijc6gvf.fsf@gitster.siamese.dyndns.org>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com>
	<20071217195658.GB13515@fieldses.org>
	<1197921847.27386.16.camel@localhost>
	<20071217201219.GC13515@fieldses.org>
	<1197922971.27386.32.camel@localhost>
	<20071217205134.GB2105@coredump.intra.peff.net>
	<7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
	<20071217230558.GD2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Perches <joe@perches.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4POq-0006NW-Or
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937686AbXLQX2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937689AbXLQX2f
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:28:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937688AbXLQX2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:28:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF584DDA;
	Mon, 17 Dec 2007 18:28:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A0D724DD9;
	Mon, 17 Dec 2007 18:28:22 -0500 (EST)
In-Reply-To: <20071217230558.GD2105@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 17 Dec 2007 18:05:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68663>

Jeff King <peff@peff.net> writes:

>> I wonder if stripping existing "Message-Id:" away just like we strip
>> away "Date:" from @xh would be a much saner fix.
>
> That is definitely wrong if we expect to re-use the in-reply-to and
> references headers that already exist (though obviously we could strip
> out all three of those headers and re-add our own).

Ah, you are right.

And undef $message_id you squashed in definitely belongs there --
"prepare for the next round" section.
