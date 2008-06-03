From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 12:06:05 +0200
Message-ID: <vpqabi2zvci.fsf@bauges.imag.fr>
References: <200806030314.03252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 12:09:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3TRx-0000ER-2U
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbYFCKIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbYFCKIJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:08:09 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:37600 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbYFCKIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:08:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m53A6Duk019984;
	Tue, 3 Jun 2008 12:06:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K3TP3-0007fG-CM; Tue, 03 Jun 2008 12:06:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K3TP3-0002UB-A2; Tue, 03 Jun 2008 12:06:05 +0200
In-Reply-To: <200806030314.03252.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 3 Jun 2008 03\:14\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 03 Jun 2008 12:06:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83631>

Jakub Narebski <jnareb@gmail.com> writes:

> I think that octopus merge (merge with more than two parents/legs) is 
> feature which is unique to git (isn't it?).  

bzr can do similar things:

bzr merge some-branch
bzr merge --force some-other-branch
bzr commit

Since bzr doesn't auto-commit after a merge, the above commands
actually creates only one revision with 3 parents (the --force is here
to let merge do it's job with uncommited changes in the tree).

-- 
Matthieu
