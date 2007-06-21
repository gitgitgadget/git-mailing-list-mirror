From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 15:25:34 +0200
Message-ID: <vpqfy4lxwvl.fsf@bauges.imag.fr>
References: <20070621030622.GD8477@spearce.org>
	<200706211050.03519.andyparkins@gmail.com>
	<Pine.LNX.4.64.0706211252190.4059@racer.site>
	<200706211344.47560.andyparkins@gmail.com>
	<vpqodj9zcxf.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0706211417090.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Mfr-0004Iq-35
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbXFUN0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbXFUN0H
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:26:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:38204 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbXFUN0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:26:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l5LDPYFL022715
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 15:25:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I1MfG-0007H9-Ea; Thu, 21 Jun 2007 15:25:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I1MfG-0000Sk-C8; Thu, 21 Jun 2007 15:25:34 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Andy Parkins <andyparkins@gmail.com>,  git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <Pine.LNX.4.64.0706211417090.4059@racer.site> (Johannes Schindelin's message of "Thu\, 21 Jun 2007 14\:18\:37 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 21 Jun 2007 15:25:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50625>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Have you checked the files? They are all some blobs in the test scripts. 

Yes, but how does it make any difference? You still want git to manage
them properly, don't you?

-- 
Matthieu
