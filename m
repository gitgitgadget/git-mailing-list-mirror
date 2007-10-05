From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: A few usability question about git diff --cached
Date: Fri, 05 Oct 2007 08:40:40 +0200
Message-ID: <vpqwsu2oyhj.fsf@bauges.imag.fr>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<20071004125641.GE15339@genesis.frugalware.org>
	<7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710041534000.4174@racer.site>
	<vpqtzp7ndn3.fsf@bauges.imag.fr> <20071004155147.GA17487@fieldses.org>
	<vpq8x6ix3zm.fsf@bauges.imag.fr> <20071004161935.GC17487@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 08:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idgty-000339-K9
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 08:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXJEGnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 02:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXJEGnA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 02:43:00 -0400
Received: from imag.imag.fr ([129.88.30.1]:65054 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbXJEGm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 02:42:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l956eelW023834
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 08:40:41 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdgrY-0001J2-Ge; Fri, 05 Oct 2007 08:40:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdgrY-0007hh-EI; Fri, 05 Oct 2007 08:40:40 +0200
In-Reply-To: <20071004161935.GC17487@fieldses.org> (J. Bruce Fields's message of "Thu\, 4 Oct 2007 12\:19\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Oct 2007 08:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60039>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> The stat-information, and sha1sum are actually a cache, but they don't
>> have to be user-visible, except for speed.
>
> That's a big exception.--b.

Speed _is_ important, of course. But the user only benefits from
speed, he doesn't have to manipulate it explicitely. I may be
repeating myself, but "diff --cached" doesn't mean "diff using the
stat-cache", it means "diff using the cached _content_", which is
really unrelated from the stat-cache.

Mercurial also has fast diff (perhaps a bit slower that git, but same
order of magnitude), and has no user-visible index.

-- 
Matthieu
