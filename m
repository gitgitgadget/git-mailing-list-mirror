From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Thu, 10 May 2007 10:00:58 +0200
Message-ID: <vpq1whp5cqt.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	<vpqbqgxak1i.fsf@bauges.imag.fr>
	<46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
	<alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
	<20070509134151.GT4489@pasky.or.cz>
	<alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
	<7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
	<4642831C.2090401@midwinter.com>
	<alpine.LFD.0.98.0705091934440.4062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 10:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3aH-000319-Nc
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbXEJIBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXEJIBF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:01:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:57414 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269AbXEJIBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:01:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4A80w4p029982
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 10:00:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hm3a6-00054w-OT; Thu, 10 May 2007 10:00:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hm3a6-0002gc-M2; Thu, 10 May 2007 10:00:58 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.98.0705091934440.4062@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 9 May 2007 19\:39\:01 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 10 May 2007 10:00:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46842>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yeah, I don't think "git add -i" is a horrible flow - it just shouldn't be 
> the only or the primary one (ie apparently it *is* the primary one for 
> darcs, and that's a mistake!)

Note that darcs has a way to test before commit even for partial
commits. It re-creates your working tree, hardlinking unmodified
files, and runs a command there as a precommit hook.

I still prefer the old good "you commit what's in the tree, and run
whatever you want before commit", but their approach seems interesting
also in this case.

-- 
Matthieu
