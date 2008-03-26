From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 10:48:03 +0100
Message-ID: <vpqve3995po.fsf@bauges.imag.fr>
References: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org>
	<20080326062635.GC26286@coredump.intra.peff.net>
	<0535D2B4-0C4A-40D0-879A-7E0C5B3B48E4@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 10:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeSGR-0003Be-VT
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 10:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYCZJtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 05:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYCZJtE
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 05:49:04 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:38290 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbYCZJtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 05:49:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m2Q9m72V007725;
	Wed, 26 Mar 2008 10:48:08 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JeSEl-00032j-Mc; Wed, 26 Mar 2008 10:48:03 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JeSEl-0008Hl-KO; Wed, 26 Mar 2008 10:48:03 +0100
In-Reply-To: <0535D2B4-0C4A-40D0-879A-7E0C5B3B48E4@faithfulgeek.org> (Joe Fiorini's message of "Wed\, 26 Mar 2008 02\:38\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 26 Mar 2008 10:48:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78280>

Joe Fiorini <joe@faithfulgeek.org> writes:

> Yeah, it warned me, I wasn't being careful enough.  I guess I didn't
> think it would remove from the working tree, just the repository.  My
> err for not reading the docs until _after_ the mistake.

Reading the error message would have done it also :-\.

>>  error: 'file' has changes staged in the index
>>  (use --cached to keep the file, or -f to force removal)
         ^^^^^^^^^^^^^^^^^^^^^^^^^

Good luck with lost+found, still !

-- 
Matthieu
