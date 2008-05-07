From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Removing from index
Date: Wed, 07 May 2008 10:17:24 +0200
Message-ID: <vpq4p9a8r57.fsf@bauges.imag.fr>
References: <4B58A837F454E14AA0453EDBADE96A62B5F3C9@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 07 10:34:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtf6z-00040Q-Qm
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761808AbYEGIdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761258AbYEGIdw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:33:52 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:36196 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761527AbYEGIdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:33:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m478WMuO012896;
	Wed, 7 May 2008 10:32:29 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jteq4-0000Eo-HF; Wed, 07 May 2008 10:17:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jteq4-0000AB-F1; Wed, 07 May 2008 10:17:24 +0200
In-Reply-To: <4B58A837F454E14AA0453EDBADE96A62B5F3C9@mildred.leeds-art.ac.uk> (Ryan Taylor's message of "Wed\, 7 May 2008 09\:06\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 07 May 2008 10:32:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81416>

"Ryan Taylor" <ryan.taylor@leeds-art.ac.uk> writes:

> I've tried adding logs into my exclude file and also running the git rm
> command on *.log to remove them from the index but they're still being
> tracked?

What does "git status" say after "git rm *.log"?

Are you sure you didn't forget to commit after that?

-- 
Matthieu
