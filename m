From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 04 Oct 2007 18:02:21 +0200
Message-ID: <vpq8x6ix3zm.fsf@bauges.imag.fr>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<20071004125641.GE15339@genesis.frugalware.org>
	<7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710041534000.4174@racer.site>
	<vpqtzp7ndn3.fsf@bauges.imag.fr> <20071004155147.GA17487@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTCx-0005AP-Dc
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761581AbXJDQDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761370AbXJDQDi
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:03:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:53166 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761562AbXJDQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:03:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l94G2RwV016669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Oct 2007 18:02:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdT9Z-0007WW-IY; Thu, 04 Oct 2007 18:02:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdT9Z-0006Q0-G6; Thu, 04 Oct 2007 18:02:21 +0200
In-Reply-To: <20071004155147.GA17487@fieldses.org> (J. Bruce Fields's message of "Thu\, 4 Oct 2007 11\:51\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 04 Oct 2007 18:02:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59975>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Yes, the index differs from the work tree or HEAD temporarily, 

Temporarily, yes, but the _point_ of having it is to have it differ
from HEAD (otherwise, you can't create a new revision), and from the
tree (otherwise, index-related commands are useless).

The stat-information, and sha1sum are actually a cache, but they don't
have to be user-visible, except for speed. "diff --cached" has nothing
to do with the stat information for the user.

-- 
Matthieu
