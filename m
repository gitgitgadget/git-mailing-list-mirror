From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 23:00:09 +0200
Message-ID: <vpqslay1zty.fsf@bauges.imag.fr>
References: <200704171041.46176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 23:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdumn-0000Y2-H2
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031224AbXDQVAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031228AbXDQVAV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:00:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:46075 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031224AbXDQVAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:00:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3HL0AfC014712
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Apr 2007 23:00:10 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HdumY-0002SU-2V; Tue, 17 Apr 2007 23:00:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HdumY-0001Jo-0C; Tue, 17 Apr 2007 23:00:10 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <200704171041.46176.andyparkins@gmail.com> (Andy Parkins's message of "Tue\, 17 Apr 2007 10\:41\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 17 Apr 2007 23:00:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44824>

Andy Parkins <andyparkins@gmail.com> writes:

> This patch adds expansion of keywords support.

I didn't get time to read the whole thread, but just my 2 cents:

Did you have a look at the way Mercurial deals with this?

They have a system where files can be ran through arbitrary filters
when commited:

  http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilter

and it can be somehow abused to do keyword expansion.

  http://www.selenic.com/mercurial/wiki/index.cgi/TipsAndTricks#head-f348f796b9560a1cfbdaf3f3f0f7d9d4339266e9

It surely doesn't solve all the problems mentionned in this thread,
but the experience can be interesting to look at.

-- 
Matthieu
