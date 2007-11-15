From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rehabilitate some t5302 tests on 32-bit off_t machines
Date: Thu, 15 Nov 2007 11:03:14 -0800
Message-ID: <7vsl3749hp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home>
	<200711151938.29617.johannes.sixt@telecom.at>
	<alpine.LFD.0.9999.0711151349480.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isk0G-0006My-Ml
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 20:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760736AbXKOTDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 14:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763871AbXKOTDX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 14:03:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34779 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760335AbXKOTDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 14:03:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3F5092F2;
	Thu, 15 Nov 2007 14:03:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C07B0950C3;
	Thu, 15 Nov 2007 14:03:38 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711151349480.21255@xanadu.home> (Nicolas
	Pitre's message of "Thu, 15 Nov 2007 13:51:47 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65151>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 15 Nov 2007, Johannes Sixt wrote:
>
>> Since you changed this test, I assume that the remaining
>> tests that you put back failed only because this one did
>> something wrong. If so, please mention that in the commit
>> message.
>
> It did nothing wrong.  It was simply relying on the product of
> a previous test that might still be disabled.

Thanks for a fix-up and clarification.   Hannes, otherwise this
passed in your environment?
