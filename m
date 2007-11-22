From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 01:50:31 -0800
Message-ID: <7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
	<1195648601-21736-2-git-send-email-win@wincent.com>
	<1195648601-21736-3-git-send-email-win@wincent.com>
	<20071121152118.GG24108@sigill.intra.peff.net>
	<7vejejfi28.fsf@gitster.siamese.dyndns.org>
	<C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
	<7vk5obb09a.fsf@gitster.siamese.dyndns.org>
	<20071122091356.GD7153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8hz-00055k-C7
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXKVJuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXKVJuh
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:50:37 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57040 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbXKVJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:50:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 20C602EF;
	Thu, 22 Nov 2007 04:50:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CEE3977CC;
	Thu, 22 Nov 2007 04:50:54 -0500 (EST)
In-Reply-To: <20071122091356.GD7153@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 Nov 2007 04:13:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65766>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 21, 2007 at 04:18:57PM -0800, Junio C Hamano wrote:
>
>> What I meant was that if "git add -i" (unrestricted) shows paths
>> from a set A, "git add -i paths..." should show paths from a
>> subset of the set A and that subset should be defined with the
>> existing ls-files pathspec semantics.
>
> Ah, I think that is definitely the right behavior. But it does raise one
> more question: is going right into the 'add hunk' interface the correct
> behavior, or is that an orthogonal issue?

I am moderately negative about "paths imply jump to patch
subcommand".  An option to git-add--interactive that tells which
subcommand to initially choose is probably acceptable, though.

Would the patch I just sent out (you need to assemble the parts)
make things easier?
