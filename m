From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Wed, 18 Jan 2012 09:16:09 +0100
Message-ID: <vpqlip5qvcm.fsf@bauges.imag.fr>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
	<CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
	<7vzkdmqebh.fsf@alter.siamese.dyndns.org>
	<CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com>
	<7v1uqxq4jm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 09:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnQgu-0004Ln-42
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 09:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab2ARIQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 03:16:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59362 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab2ARIQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 03:16:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q0I8EVFu009489
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jan 2012 09:14:31 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RnQgj-0000rR-Fe; Wed, 18 Jan 2012 09:16:09 +0100
In-Reply-To: <7v1uqxq4jm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 17 Jan 2012 15:42:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jan 2012 09:14:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0I8EVFu009489
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327479273.38211@HFvdBkWKIyrAyLhfztRZfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188741>

Junio C Hamano <gitster@pobox.com> writes:

> OK, so the issue the patch addresses may not be a regression in the
> upcoming v1.7.9 we want to fix quickly,

I'm running ZSH 4.3.10 (Debian stable), and for me it is a regression.
It seems there is another bug elsewhere affecting more recent ZSH (I
don't have a recent ZSH version installed to test), but fixing the
regression for old ZSH is still worth it. I'm not even sur the issue
with recent ZSH is related.

At worse, my patch is not intrusive and can easily be reworked later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
