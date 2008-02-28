From: Paul Mackerras <paulus@samba.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Thu, 28 Feb 2008 22:21:57 +1100
Message-ID: <18374.39253.408961.634788@cargo.ozlabs.ibm.com>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
	<7v7igqyii9.fsf@gitster.siamese.dyndns.org>
	<18373.58839.636432.448970@cargo.ozlabs.ibm.com>
	<7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 12:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUgqY-0000vC-OA
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 12:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbYB1LWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 06:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbYB1LWF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 06:22:05 -0500
Received: from ozlabs.org ([203.10.76.45]:44244 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbYB1LWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 06:22:04 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9C310DDEB8; Thu, 28 Feb 2008 22:22:02 +1100 (EST)
In-Reply-To: <7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75385>

Junio C Hamano writes:

> Yeah, the option list is not maintained well for the last few
> years and needs to be updated.

Ah.  OK.  I am currently using git rev-parse in the gitk dev branch to
determine what starting commits git log will use, so that when the
user does an update, I can construct a git log command that will stop
when it gets to any of those previous starting points.  That way the
second git log will only give me new stuff that has been added since
the first git log.

Can you suggest an efficient way to do that that doesn't use git
rev-parse?

Thanks,
Paul.
