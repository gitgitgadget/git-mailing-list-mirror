From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 01 Feb 2008 09:45:31 -0800
Message-ID: <7vprvg8tac.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<200802011010.41938.robin.rosenberg.lists@dewire.com>
	<7v63x99dt9.fsf@gitster.siamese.dyndns.org>
	<200802011517.28895.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 18:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKzy5-00080v-LM
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 18:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYBARpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbYBARpv
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 12:45:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYBARpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 12:45:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4764735E8;
	Fri,  1 Feb 2008 12:45:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E07135B3;
	Fri,  1 Feb 2008 12:45:36 -0500 (EST)
In-Reply-To: <200802011517.28895.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Fri, 1 Feb 2008 15:17:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72180>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> fredagen den 1 februari 2008 skrev Junio C Hamano:
>
>> Ah, you found breakages.
>> 
>> I could not quite tell what you meant by these tests with
>> test_expect_failure, either they were misuse or "currently fails
>> but they shouldn't".  Coming up with a small reproducible
>> failure case is 50% of solving the problem.  That's very
>> appreciated.
>> ...
> I had those test cases on my machine from my earlier work on absolute
> path names so I just ran them with your code and extracted those that
> failed and put them into your testsuite instead. That's why I sent them
> so early...

Yeah, I initially did not realize that was what you were doing,
hence the above "I could not quite tell, ... but thanks now I
got it".
