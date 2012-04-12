From: Brian Gernhardt <brian@silverinsanity.com>
Subject: non-fast-forward advice breaks tests on OS X
Date: Thu, 12 Apr 2012 01:49:14 -0400
Message-ID: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>,
	Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SID1V-0003Eh-A5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab2DLF4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 01:56:44 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49396 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2DLF4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 01:56:44 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2012 01:56:44 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 127D91FFC008; Thu, 12 Apr 2012 05:49:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 492871FFC008;
	Thu, 12 Apr 2012 05:49:03 +0000 (UTC)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195299>

After a break in regularly compiling git on my Mac 10.7.3 laptop, I had a few tests fail:  t5540.15, t5541.{12,15}.  All of these tests use test_i18ngrep to test the output of git-push for the string "To prevent you from losing history, non-fast-forward updates were rejected".

Bisecting traced it back to f25950f: "push: Provide situational hints for non-fast-forward errors".

I'm sending this off to the list in case someone else has some idea of the root cause.  I'll get back to this problem myself sometime tomorrow.

~~ Brian Gernhardt
