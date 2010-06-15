From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: No working tree repository
Date: Tue, 15 Jun 2010 20:10:01 +0200
Message-ID: <vpqy6egi2va.fsf@bauges.imag.fr>
References: <4C17BEB7.90403@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 20:10:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOaae-0004jG-10
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 20:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0FOSKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 14:10:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40839 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775Ab0FOSKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 14:10:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FI1v94021286
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 20:01:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOaaH-0000xO-U9; Tue, 15 Jun 2010 20:10:01 +0200
In-Reply-To: <4C17BEB7.90403@cfl.rr.com> (Phillip Susi's message of "Tue\, 15 Jun 2010 13\:56\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 20:01:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FI1v94021286
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277229722.57088@GNiCR2XOwztPWWNjrwZosw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149214>

Phillip Susi <psusi@cfl.rr.com> writes:

> I'd like to keep a local copy of the kernel repository mainly for
> searching the history.  The working tree uses up nearly 400mb of disk
> space that I do not normally need.  How can I remove the working tree,
> and keep only the packed repository so I can review the logs, and only
> check out a working copy if I actually want to edit or compile the
> sources?

This is called a "bare" repository. Now, you have the keyword to
RTFM ;-).

You can do something like

mv linux-repo linux-tree
cd linux-tree
mv .git ../linux-repo
cd ../linux-repo
git config core.bare true

(and optionnaly remove linux-tree/)

or you could have used "git clone --bare" when you cloned the
repository.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
