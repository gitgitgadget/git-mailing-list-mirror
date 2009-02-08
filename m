From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] GIT 1.6.2-rc0
Date: Sun, 08 Feb 2009 09:23:03 +0100
Message-ID: <vpqprhte3rs.fsf@bauges.imag.fr>
References: <7vvdrlsyjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 09:50:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW5Mh-0001HS-Qf
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 09:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbZBHIZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 03:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZBHIZy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:25:54 -0500
Received: from imag.imag.fr ([129.88.30.1]:46763 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbZBHIZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:25:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n188N3HR029481
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Feb 2009 09:23:04 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LW4wR-0001hu-UU; Sun, 08 Feb 2009 09:23:03 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LW4wR-0000Ex-QO; Sun, 08 Feb 2009 09:23:03 +0100
In-Reply-To: <7vvdrlsyjm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 07 Feb 2009 13\:54\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 08 Feb 2009 09:23:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108930>

Junio C Hamano <gitster@pobox.com> writes:

> GIT v1.6.2 Release Notes (draft)
> ================================
>
> With the next major release, "git push" into a branch that is
> currently checked out will be refused by default.  You can choose
> what should happen upon such a push by setting the configuration
> variable receive.denyCurrentBranch in the receiving repository.

Perhaps this paragraph should tell _why_ this is a dangerous
operation. There's probably a better wording, but what about

---- 8< ---
With the next major release, "git push" into a branch that is
currently checked out will be refused by default: Pushing to a
checked-out branch changes the HEAD for this branch, and would confuse
further local operations in the target repository.

You can choose what should happen [...]
---- 8< ---

?

-- 
Matthieu
