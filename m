From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: octopus limit
Date: Fri, 27 Jun 2008 08:33:37 +0200
Message-ID: <vpqbq1n5qv2.fsf@bauges.imag.fr>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC7u6-00072c-0w
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 08:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760201AbYF0G45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 02:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760388AbYF0G44
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 02:56:56 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:36788 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760201AbYF0G4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 02:56:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5R6Xb26022112;
	Fri, 27 Jun 2008 08:33:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KC7Wb-0007vt-Jl; Fri, 27 Jun 2008 08:33:37 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KC7Wb-0004c8-HI; Fri, 27 Jun 2008 08:33:37 +0200
In-Reply-To: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain> (Len Brown's message of "Thu\, 26 Jun 2008 22\:44\:23 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 27 Jun 2008 08:33:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86527>

Len Brown <lenb@kernel.org> writes:

> it would be nice if a merge of more than 16 branches failed
> right at the start, rather than chunking along doing merges
> and then giving up, leaving my repo in an intermediate state.

There's a patch around which should remove this limitation (I think
it's the builtin-ification of merge).

-- 
Matthieu
