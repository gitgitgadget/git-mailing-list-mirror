From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sun, 31 Aug 2008 10:27:23 +0200
Message-ID: <vpqk5dxmvx0.fsf@bauges.imag.fr>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
	<32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
	<7vljyefaps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org,
	arman@twinsun.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 10:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZiLP-0000DP-5F
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 10:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYHaI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 04:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYHaI3v
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 04:29:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:44330 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbYHaI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 04:29:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7V8RVjk017949
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 31 Aug 2008 10:27:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KZiHL-0002Pb-Kn; Sun, 31 Aug 2008 10:27:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KZiHL-00059P-HQ; Sun, 31 Aug 2008 10:27:23 +0200
In-Reply-To: <7vljyefaps.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 30 Aug 2008 14\:34\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 31 Aug 2008 10:27:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94463>

Junio C Hamano <gitster@pobox.com> writes:

> +	Unsetting the `crlf` attribute on a path is tells git
> +	not to attempt any end-of-line conversion  upon checkin/checkout.

If you apply it, and to be picky: typo ("is tells") and strange
formatting (double space before upon).

Other than that, it seems to be a good change, yes.

-- 
Matthieu
