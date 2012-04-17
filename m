From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: test-mergesort conflict with stdlib.h
Date: Tue, 17 Apr 2012 14:09:15 -0400
Message-ID: <341E3693-9E1A-4356-A632-F5703E2829E8@gernhardtsoftware.com>
References: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com> <7vd376ntem.fsf@alter.siamese.dyndns.org> <7v8vhunsg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCqA-0004U6-IY
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab2DQSJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:09:18 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35279 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2DQSJR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:09:17 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2AC611FFC0EB; Tue, 17 Apr 2012 18:09:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from bcg2784.student.rit.edu (bcg2784.student.rit.edu [129.21.210.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 26B4A1FFC015;
	Tue, 17 Apr 2012 18:09:11 +0000 (UTC)
In-Reply-To: <7v8vhunsg5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195780>


On Apr 17, 2012, at 2:06 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Unfortunate.  OS X shouldn't contaminate the user namespace by adding such
>> names in stdlib.h (which incidentally has qsort()), but the damage is done
>> already, so I am not opposed to rename it to llist_mergesort() or something.
> 
> Something like this.  While we are touching the code, let's add some
> documentation to the header.
> 
> commit.c         |    4 ++--
> mergesort.c      |    8 ++++----
> mergesort.h      |   16 ++++++++++++----
> test-mergesort.c |    2 +-
> 4 files changed, 19 insertions(+), 11 deletions(-)

This is basically identical to what I was going to send and it does, in fact, fix my build problem.

Thanks,
~~ Brian Gernhardt
