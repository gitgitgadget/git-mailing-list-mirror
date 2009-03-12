From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] Add a test for checking whether gitattributes is honored by checkout.
Date: Thu, 12 Mar 2009 10:47:01 +0100
Message-ID: <vpqr613jcoa.fsf@bauges.imag.fr>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
	<1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
	<1236850575-27973-2-git-send-email-kristian.amlie@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:51:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhZf-0000BR-Ie
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZCLJuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZCLJuE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:50:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:49884 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbZCLJuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:50:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2C9l2N1006185
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Mar 2009 10:47:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LhhVF-0000md-V5; Thu, 12 Mar 2009 10:47:01 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LhhVF-0006bR-Se; Thu, 12 Mar 2009 10:47:01 +0100
In-Reply-To: <1236850575-27973-2-git-send-email-kristian.amlie@nokia.com> (Kristian Amlie's message of "Thu\, 12 Mar 2009 10\:36\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 12 Mar 2009 10:47:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113032>

Kristian Amlie <kristian.amlie@nokia.com> writes:

> +test_expect_success 'setup' '

If you have two separate patches for test and bugfix, you probably
want the first to introduce test_expect_failure, and the second to
change it to test_expect_success. This way: 1) the test-suite passes
for all commits (and git-bisect will be your friend again), and 2) the
second patch is self-explanatory about the bug it fixes.

-- 
Matthieu
