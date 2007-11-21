From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add transfer encoding header with content-type
Date: Tue, 20 Nov 2007 22:58:38 -0800
Message-ID: <7vbq9ohyox.fsf@gitster.siamese.dyndns.org>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com>
	<20071116104907.GA13087@sigill.intra.peff.net>
	<7vlk8xwvbu.fsf@gitster.siamese.dyndns.org>
	<20071119104950.GB8645@informatik.uni-freiburg.de>
	<20071120125404.GB7998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org,
	Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujYF-0006mH-Vc
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbXKUG6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXKUG6w
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:58:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57096 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXKUG6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:58:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 16FDB2EF;
	Wed, 21 Nov 2007 01:59:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 799AA94DAA;
	Wed, 21 Nov 2007 01:59:04 -0500 (EST)
In-Reply-To: <20071120125404.GB7998@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 Nov 2007 07:54:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65603>

Jeff King <peff@peff.net> writes:

>> I think we should add
>> 
>> 	Content-Transfer-Encoding: 8bit
>
> Even though Brian's mail turned out to be hand-generated, this problem
> does exist in git-send-email. I don't know why I didn't add the encoding
> header in the first place, since it is clearly required.
>
> Junio, I think this is maint-worthy.

Yeah, looks good.
