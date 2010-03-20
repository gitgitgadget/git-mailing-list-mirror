From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Use test_expect_success for test setups
Date: Sat, 20 Mar 2010 11:58:24 -0400
Message-ID: <2DDEFE95-02A7-4DAE-B233-ABE1545EDB65@gernhardtsoftware.com>
References: <1269073751-64588-1-git-send-email-brian@gernhardtsoftware.com> <7v7hp7ov8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:58:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt14V-00016N-M5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab0CTP63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:58:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41117 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab0CTP62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 11:58:28 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 98C2E1FFC2ED; Sat, 20 Mar 2010 15:58:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id F324C1FFC2EA;
	Sat, 20 Mar 2010 15:58:21 +0000 (UTC)
In-Reply-To: <7v7hp7ov8c.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142720>


On Mar 20, 2010, at 11:42 AM, Junio C Hamano wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
>> Several tests did not use test_expect_success for their setup
>> commands.  Putting these start commands into the testing framework
>> means both that errors during setup will be caught quickly and that
>> non-error text will be suppressed without -v.
> 
> Nice.  Should the one in 4103 be three separate tests?  They seem to be
> preparing the set of test input files and are not expected to fail (unless
> of course you are futzing with diff-tree, but for that we have t4013).

I don't think they need to be.  t4103 was the first one I did and I did it as three tests since it was three separate "blocks".  I had also tried moving the diff-trees closer to where their result is used until I saw how much they were reused.

~~ Brian