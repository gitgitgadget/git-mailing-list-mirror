From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: gitosis asking for password
Date: Tue, 31 May 2011 18:01:05 +0200
Message-ID: <vpqy61mrha6.fsf@bauges.imag.fr>
References: <20110531154954.GB4483@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Guirgies <lt.infiltrator@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 18:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRRNe-0000vO-L9
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 18:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140Ab1EaQBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 12:01:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36334 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab1EaQBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 12:01:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4VG13Nu023593
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 May 2011 18:01:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QRRNR-0003zB-NY; Tue, 31 May 2011 18:01:05 +0200
In-Reply-To: <20110531154954.GB4483@Imperial-SSD-Overlord> (Tim Guirgies's
	message of "Wed, 1 Jun 2011 01:49:55 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 31 May 2011 18:01:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4VG13Nu023593
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307462465.57558@F6v6csOboulpS16huke8Jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174809>

Tim Guirgies <lt.infiltrator@gmail.com> writes:

> So, I decided to remove gitosis and start again afresh.  Following this
> [1] guide, I did/got the following:

Gitosis is no longer maintained. You should probably be trying gitolite
instead.

> $ git clone gitosis@overlord.imperial.fleet:gitosis-admin
> Cloning into gitosis-admin...
> gitosis@overlord.imperial.fleet's password: 
> Permission denied, please try again.

If it asks for password, then it's probably a plain SSH problem. Try
reproducing it with e.g.

ssh gitosis@overlord.imperial.fleet

or

ssh -vvv gitosis@overlord.imperial.fleet

to see what's going on. Look at ~/.ssh/authorized_keys on the server.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
