From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Fri, 07 Aug 2009 21:21:13 +0200
Message-ID: <vpqzlabwhue.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<4A7B3760.2000303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZV37-00039T-Hx
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933141AbZHGTYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933119AbZHGTYL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:24:11 -0400
Received: from imag.imag.fr ([129.88.30.1]:50876 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933112AbZHGTYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 15:24:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n77JLETK013251
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 21:21:14 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZV06-0006tZ-1e; Fri, 07 Aug 2009 21:21:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZV06-0007Vc-0N; Fri, 07 Aug 2009 21:21:14 +0200
In-Reply-To: <4A7B3760.2000303@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 06 Aug 2009 22\:04\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 07 Aug 2009 21:21:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125210>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> May I suggest "Some push was rejected because it would not result in a
> fast forward:\n Merge in the remote changes (using git pull) before
> pushing yours\n or use..."?

Are you sure this is "Some push _was_ ..."? In the general case,
several branches are rejected, so that would be "were", no?

-- 
Matthieu
