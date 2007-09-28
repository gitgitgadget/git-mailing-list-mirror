From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 11:08:54 -0700
Message-ID: <7v641upsqx.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site>
	<Pine.LNX.4.64.0709280046241.5926@iabervon.org>
	<7vhclfqisq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709281259050.28395@racer.site>
	<Pine.LNX.4.64.0709281138270.5926@iabervon.org>
	<Pine.LNX.4.64.0709281711010.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbKGz-00049w-VB
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 20:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbXI1SJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 14:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbXI1SJB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 14:09:01 -0400
Received: from rune.pobox.com ([208.210.124.79]:58788 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbXI1SJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 14:09:01 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E44C913DA0E;
	Fri, 28 Sep 2007 14:09:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C25213D9EC;
	Fri, 28 Sep 2007 14:09:18 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709281711010.28395@racer.site> (Johannes
	Schindelin's message of "Fri, 28 Sep 2007 17:11:47 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59414>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 28 Sep 2007, Daniel Barkalow wrote:
>
>> On Fri, 28 Sep 2007, Johannes Schindelin wrote:
>> 
>> > Further, I am quite sure that the same mistake will happen again, until we 
>> > change the function to get the name length, not the number of bytes to 
>> > allocate.
>> 
>> I agree. But leaving the majority of cases using the old convention is 
>> just confusing.
>
> Yeah, sorry, that patch was only half-cooked.
>
> If people agree with me, I'll redo the patch (fixing all calling sites, 
> too).

I think that is probably a better solution.
