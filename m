From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: What happened to [PATCH] Support "core.excludesfile = ~/.gitignore" ?
Date: Wed, 04 Nov 2009 09:56:00 +0100
Message-ID: <vpqbpjiu0rj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, quarl@cs.berkeley.edu
X-From: git-owner@vger.kernel.org Wed Nov 04 09:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5bhs-0002Sk-Es
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 09:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZKDI65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 03:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZKDI64
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 03:58:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:49742 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbZKDI64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 03:58:56 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nA48u0wB023440
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 09:56:01 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5beq-0007Dq-Qs; Wed, 04 Nov 2009 09:56:00 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Nov 2009 09:56:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132065>

Hi,

I found a patch to manage ~ in core.excludesfile here:

  http://thread.gmane.org/gmane.comp.version-control.git/93250

It seems the patch was abandonned by its author near here:

  http://thread.gmane.org/gmane.comp.version-control.git/93250/focus=94318

Was there any particular reason for dropping the patch other than lack
of time? If not, I'll try to resurect it.

(I have core.excludesfile = /home/moy/.gitignore hardcoded, and I have
to edit it each time I teach Git to a colleague, that would be so much
better to have the same value "~/.gitignore" for everybody ...)

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
