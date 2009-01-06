From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 06 Jan 2009 18:17:49 +0100
Message-ID: <vpqzli45p6q.fsf@bauges.imag.fr>
References: <49635BF8.1010700@sadau-online.de>
	<vpqiqosa3fc.fsf@bauges.imag.fr> <49638625.3090109@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Sadau <lars@sadau-online.de>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 18:23:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKFe0-0002WY-7W
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 18:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZAFRVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZAFRVp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 12:21:45 -0500
Received: from imag.imag.fr ([129.88.30.1]:64582 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbZAFRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 12:21:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n06HHp5W015473
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Jan 2009 18:17:51 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LKFYr-0006aU-V6; Tue, 06 Jan 2009 18:17:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LKFYr-0005ci-Si; Tue, 06 Jan 2009 18:17:49 +0100
In-Reply-To: <49638625.3090109@tedpavlic.com> (Ted Pavlic's message of "Tue\, 06 Jan 2009 11\:26\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 06 Jan 2009 18:17:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104701>

Ted Pavlic <ted@tedpavlic.com> writes:

> According to the INSTALL doc, the default prefix should be ~.

I didn't read that in INSTALL. What I read is that if I only run "make
install", the prefix is $HOME, which is true. Now, ./configure uses a
default value which is not the one of the Makefile, but that's another
point.

-- 
Matthieu
