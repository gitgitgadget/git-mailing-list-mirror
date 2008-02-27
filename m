From: Paul Mackerras <paulus@samba.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Thu, 28 Feb 2008 09:36:07 +1100
Message-ID: <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
	<7v7igqyii9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUta-0005qy-Ht
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbYB0WgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbYB0WgS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:36:18 -0500
Received: from ozlabs.org ([203.10.76.45]:47787 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759428AbYB0WgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:36:15 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id B9AE7DDEE2; Thu, 28 Feb 2008 09:36:14 +1100 (EST)
In-Reply-To: <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75313>

Junio C Hamano writes:

> Like this?
> 
> A trivial feature that can be implemented in -4 lines ;-)

Cool!  Yes, that works nicely.

Another thing: I have noticed that git rev-parse --revs-only doesn't
pass the --merge and --left-right flags through, even though the help
for git rev-parse says that --revs-only means "Do not output flags and
parameters not meant for git-rev-list" (which I assume means the same
as "Only output flags and parameters meant for git rev-list"), and git
rev-list accepts and uses the --merge and --left-right flags.  I
assume this is just an oversight in git rev-parse.

Regards,
Paul.
