From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 20:53:33 +0200
Message-ID: <vpqwsmstl1u.fsf@bauges.imag.fr>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
	<alpine.DEB.1.00.0804201841570.5084@eeepc-johanness>
	<449c10960804201049o1c8f0be4m36dc5ce2afec2de6@mail.gmail.com>
	<alpine.DEB.1.00.0804201853150.5084@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 20 20:55:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jneh1-0007jE-0B
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 20:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbYDTSy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbYDTSy1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 14:54:27 -0400
Received: from imag.imag.fr ([129.88.30.1]:48741 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564AbYDTSy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 14:54:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m3KIrccl027157
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Apr 2008 20:53:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JnefO-0005mw-0J; Sun, 20 Apr 2008 20:53:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JnefN-0002Nv-Tq; Sun, 20 Apr 2008 20:53:33 +0200
In-Reply-To: <alpine.DEB.1.00.0804201853150.5084@eeepc-johanness> (Johannes Schindelin's message of "Sun\, 20 Apr 2008 18\:54\:06 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 20 Apr 2008 20:53:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79976>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh, I must have missed that.  Nevertheless, I think it should be 
> synchronised with when the dashed commands vanish from the default 
> installation.

I think you missed the point of the patch.

It removes _uses_ of dashed-form in the completion script, but doesn't
remove completion for dashed forms. That could be made clear in the
commit message to avoid confusion.

-- 
Matthieu
