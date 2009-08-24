From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Pulling one commit at a time.
Date: Mon, 24 Aug 2009 13:07:08 +0200
Message-ID: <vpqskfhbhcz.fsf@bauges.imag.fr>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	<4A9172D0.6030507@microchip.com>
	<20090824060710.6117@nanako3.lavabit.com>
	<4A92318F.6050105@microchip.com> <20090824102242.GA70861@gmail.com>
	<4A92703E.90007@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 13:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfXQy-00070M-5z
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 13:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZHXLJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 07:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZHXLJp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 07:09:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:47871 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbZHXLJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 07:09:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7OB78h4008182
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Aug 2009 13:07:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MfXOG-0007wc-5q; Mon, 24 Aug 2009 13:07:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MfXOG-0000cK-4M; Mon, 24 Aug 2009 13:07:08 +0200
In-Reply-To: <4A92703E.90007@microchip.com> (Sanjiv Gupta's message of "Mon\, 24 Aug 2009 16\:19\:34 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 24 Aug 2009 13:07:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126916>

Sanjiv Gupta <sanjiv.gupta@microchip.com> writes:

> I was looking for post-mortem change-that-introduced-bug.

If so, then you don't need to test every commit. As David mentionned,
"git bisect" is your friend, and will do a binary search, finding the
culprit commit much more efficiently (run the testsuite log(n) times
instead of n times).

OTOH, if you want some kind of quality insurance (i.e. check that
every commit is OK, including the case where a commit introduces a
bug, and the next one fixes it), bisect is rather helpless.

-- 
Matthieu
