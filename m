From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 19:05:42 +0200
Message-ID: <vpqeiutrl09.fsf@bauges.imag.fr>
References: <1242205190383-2879913.post@n2.nabble.com>
	<m3iqk5l4ps.fsf@localhost.localdomain>
	<20090513160415.GA4097@andros.launchmodem.com>
	<200905131856.46344.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Loewenherz <dloewenherz@gmail.com>,
	Andreas Ericsson <ae@op5.se>, takeshin <admirau@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 19:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Hxk-0002pq-PO
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798AbZEMRJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbZEMRJi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:09:38 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55416 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbZEMRJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:09:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n4DH5hEL021831;
	Wed, 13 May 2009 19:05:43 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M4Htm-0001DM-KP; Wed, 13 May 2009 19:05:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M4Htm-0006Yx-J4; Wed, 13 May 2009 19:05:42 +0200
In-Reply-To: <200905131856.46344.jnareb@gmail.com> (Jakub Narebski's message of "Wed\, 13 May 2009 18\:56\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 13 May 2009 19:05:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119068>

Jakub Narebski <jnareb@gmail.com> writes:

> 2. If you wanted however to have *file* version (like in CVS), then it
>    is impossible because Git doesn't store such info

What could make sense is the commit id where the file was last
modified (i.e. the first item that appears when one runs "git log" on
the file). Not exactly as simple as it could be because of merge, but
not completely meaningless either.

-- 
Matthieu
