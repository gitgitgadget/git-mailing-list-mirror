From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 07 May 2007 10:02:59 +0200
Message-ID: <vpqd51duklo.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	<vpqbqgxak1i.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705070146140.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 10:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyBo-0007xY-B8
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXEGIDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXEGIDS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:03:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:54790 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbXEGIDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:03:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4782xwJ012309
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 10:03:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkyBP-0005LU-OA; Mon, 07 May 2007 10:02:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkyBP-0003hq-M4; Mon, 07 May 2007 10:02:59 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0705070146140.4167@racer.site> (Johannes Schindelin's message of "Mon\, 7 May 2007 01\:51\:38 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 May 2007 10:03:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46428>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Just another reason to hate CVS. Because it trained people to do that. If 
> it was not for the training by CVS, I would have strongly opposed to the 
> introduction of the "-m" switch to commit. It _encourages_ bad commit 
> messages.

Well, this really depends on the use-case, size of commit, ...

I often use a version control system for very low importance stuff. I
don't want to type a 3-lines long message to describe a 2-lines long
change in my ~/.emacs.el for example. I also work with people using
(sorry) svn to work collaboratively, but they don't even provide a log
message: the version control system here is just a replacement for
unison/NFS/whatever other way to have people edit files from different
machines.

For sure, in a context where code quality and review is important, 
-m "xxx" isn't the way (except if you prefer your shell's line editor
to your actual editor).

-- 
Matthieu
