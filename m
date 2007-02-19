From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 11:01:39 +0100
Message-ID: <vpq1wkm31q4.fsf@olympe.imag.fr>
References: <200702190916.35813.andyparkins@gmail.com>
	<7virdy8p25.fsf@assigned-by-dhcp.cox.net>
	<20070219094955.GE30030@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 11:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ5M9-00061h-83
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 11:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXBSKCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 05:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXBSKCK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 05:02:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:62303 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbXBSKCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 05:02:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1JA1dux025924
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 11:01:39 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HJ5L1-0006UQ-BN
	for git@vger.kernel.org; Mon, 19 Feb 2007 11:01:39 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HJ5L1-0001YN-8x
	for git@vger.kernel.org; Mon, 19 Feb 2007 11:01:39 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070219094955.GE30030@spearce.org> (Shawn O. Pearce's message of "Mon\, 19 Feb 2007 04\:49\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Feb 2007 11:01:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40113>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I did not even realize that was legal C...  Now if the 40 was in
> quotes (e.g. "40") then the concatenate rule would apply and we
> would get a nice argument to printf.

I suppose the solution is to use #HASH_WIDTH_ASCII to tell the
preprocessor to put the quotes around HASH_WIDTH_ASCII.

-- 
Matthieu
