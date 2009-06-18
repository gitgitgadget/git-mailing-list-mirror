From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Fix various sparse warnings in the git source code
Date: Thu, 18 Jun 2009 19:45:12 +0200
Message-ID: <vpq8wjpzb9z.fsf@bauges.imag.fr>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
	<alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
	<E1MG32S-0004C6-8A@fencepost.gnu.org>
	<alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
	<E1MH3bD-0004g2-97@fencepost.gnu.org>
	<alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
	<alpine.LFD.2.01.0906171654310.16802@localhost.localdomain>
	<alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302>
	<alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
	<alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302>
	<alpine.LFD.2.01.0906181013390.16802@localhost.localdomain>
	<alpine.LFD.2.01.0906181021520.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLp9-0000Lt-Q2
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbZFRRyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZFRRyp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:54:45 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:58129 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbZFRRyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 13:54:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n5IHjCOS001486;
	Thu, 18 Jun 2009 19:45:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MHLfk-00009B-9b; Thu, 18 Jun 2009 19:45:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MHLfk-0004Uk-8E; Thu, 18 Jun 2009 19:45:12 +0200
In-Reply-To: <alpine.LFD.2.01.0906181021520.16802@localhost.localdomain> (Linus Torvalds's message of "Thu\, 18 Jun 2009 10\:28\:43 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 18 Jun 2009 19:45:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121863>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>    Sparse wwants to see declarations for any functions you export. A lack 
>    fo a declaration tends to mean that you should either add one, or

Patch content is good, but in case it matters, you can s/wwants/wants/
and s/fo/for/ in the commit message.

-- 
Matthieu
