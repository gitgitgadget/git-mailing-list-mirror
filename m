From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 23:53:40 +0200
Message-ID: <vpqiqtnsasb.fsf@bauges.imag.fr>
References: <20080826171012.GO10360@machine.or.cz>
	<20080826171144.21328.82727.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, andi@firstfloor.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY6Vy-0001Im-Oi
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYHZVyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYHZVyq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:54:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:59757 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbYHZVyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:54:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7QLreIm001917
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 23:53:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KY6Ts-0000U4-CU; Tue, 26 Aug 2008 23:53:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KY6Ts-0004D5-A2; Tue, 26 Aug 2008 23:53:40 +0200
In-Reply-To: <20080826171144.21328.82727.stgit@localhost> (Petr Baudis's message of "Tue\, 26 Aug 2008 19\:11\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 26 Aug 2008 23:53:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93826>

Petr Baudis <pasky@suse.cz> writes:

> git <tab><tab> still shows way too many commands, some of them
> are clearly plumbing. This patch hides the plumbing commands
> liberally (that is, in special cases, users still might want to
> call one of the hidden commands, a *normal* workflow should never
> involve these, though - and if it does, we have a UI problem anyway).

Is it possible to have the completion not show them by default, but
fall back to them if no other completion is found?

-- 
Matthieu
