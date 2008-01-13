From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Sun, 13 Jan 2008 16:16:20 +0100
Message-ID: <vpqd4s5ycvv.fsf@bauges.imag.fr>
References: <20080113150541.21883.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Sun Jan 13 16:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE4aU-0006W3-K9
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 16:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYAMPQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYAMPQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 10:16:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:39644 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYAMPQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 10:16:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m0DFGKaa015206
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 13 Jan 2008 16:16:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JE4ZQ-0000Iw-HR; Sun, 13 Jan 2008 16:16:20 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JE4ZQ-0006uf-Eo; Sun, 13 Jan 2008 16:16:20 +0100
In-Reply-To: <20080113150541.21883.qmail@science.horizon.com> (linux@horizon.com's message of "13 Jan 2008 10\:05\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 13 Jan 2008 16:16:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70388>

linux@horizon.com writes:

> "Rename support" is a kludge to make a fundamentally broken model
> less painful.

It's not.

Git _has_ rename support. Look into the code, you'll find some code
whose purpose is to manage renames. And _no_, rename support is not
just a direct consequence of commits being atomic.

Atomic commit help, but if you do nothing else, moving a file and then
trying to merge will fail for example. So, in addition to atomic
commits, you have at least 3 options : explicit file ID (bzr),
recording renames (hg), or detecting renames after-the-fact (git).

-- 
Matthieu
