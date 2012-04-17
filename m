From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: test-mergesort conflict with stdlib.h
Date: Tue, 17 Apr 2012 13:55:40 -0400
Message-ID: <D6A62F9A-EB46-4736-BFDA-0044A993443E@gernhardtsoftware.com>
References: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com> <7vd376ntem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:55:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCd1-0001NJ-EH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2DQRzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 13:55:43 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35901 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2DQRzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 13:55:42 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 8D7461FFC0EB; Tue, 17 Apr 2012 17:55:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from bcg2784.student.rit.edu (bcg2784.student.rit.edu [129.21.210.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 356051FFC015;
	Tue, 17 Apr 2012 17:55:36 +0000 (UTC)
In-Reply-To: <7vd376ntem.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195778>


On Apr 17, 2012, at 1:46 PM, Junio C Hamano wrote:

> Unfortunate.  OS X shouldn't contaminate the user namespace by adding such
> names in stdlib.h (which incidentally has qsort()), but the damage is done
> already, so I am not opposed to rename it to llist_mergesort() or something.

This seems to be inherited from BSD's userspace which also has a mergesort (radixsort as well).  I'll make a patch to rename it and if anyone doesn't like llist_mergesort, they can repaint the bikeshed themselves.

~~ Brian Gernhardt
