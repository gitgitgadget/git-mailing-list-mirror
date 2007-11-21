From: Junio C Hamano <gitster@pobox.com>
Subject: Re: quilt/0.46-1 misbehaviour...
Date: Tue, 20 Nov 2007 16:06:27 -0800
Message-ID: <7v4pfgjwcc.fsf@gitster.siamese.dyndns.org>
References: <20071120055149.GQ6372@mea-ext.zmailer.org>
	<20071120183402.GC3461@steel.home>
	<20071120235458.GT6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 01:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iud7E-0003lr-Oi
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 01:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXKUAGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 19:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbXKUAGf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 19:06:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52097 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXKUAGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 19:06:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BBFA42F0;
	Tue, 20 Nov 2007 19:06:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C72D97FDC;
	Tue, 20 Nov 2007 19:06:51 -0500 (EST)
In-Reply-To: <20071120235458.GT6372@mea-ext.zmailer.org> (Matti Aarnio's
	message of "Wed, 21 Nov 2007 01:54:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65584>

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> On Tue, Nov 20, 2007 at 07:34:02PM +0100, Alex Riesen wrote:
> ...
>> Is this the problem: duplicate From: and quadriplicate Cc:?
>
> That kind of header multiples are are triggering spam filters
> all over the place, because spammers used to use such tricks
> as recently as 2 years ago.
>
> Duplicate "From:" is plain simply broken, multiple "Cc:" is
> just questionable..

My condolences.

> git-tools should not produce such.

I have one fundamental question.

What help can git people offer to help you resolve this issue?

What does a message that says:

        Message-Id: <20071120011333.850453474@sgi.com>
        References: <20071120011132.143632442@sgi.com>
        User-Agent: quilt/0.46-1
        Date:	Mon, 19 Nov 2007 17:11:41 -0800

(a part from your original message that Alex did not quote)
have to do with anything with the git mailing list?
