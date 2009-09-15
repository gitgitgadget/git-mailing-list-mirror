From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Per-remote tracking branch
Date: Tue, 15 Sep 2009 17:29:58 +0200
Message-ID: <vpq4or48bux.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnZyt-0000ur-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 17:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbZIOPaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZIOPaA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 11:30:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43075 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbZIOPaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 11:30:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8FFPqV5002502
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Sep 2009 17:25:52 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MnZyg-00018A-5d; Tue, 15 Sep 2009 17:29:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MnZyg-0005zl-4C; Tue, 15 Sep 2009 17:29:58 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Sep 2009 17:25:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8FFPqV5002502
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253633153.33063@ncAZv/rkk2EKg3vy1d4gHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128570>

Hi,

Is there a way, with Git, to specify a tracking branch on a per-remote
basis?

At the moment, I can configure a tracking branch to let me just type

$ git pull

when I want to say

$ git pull origin master

Now, assume I have another remote "foo", I'd like to be able to just
say

$ git pull foo

and put something in my .git/config so that Git knows I mean

$ git pull foo master

Is there a simple way to do that?


(for the motivation: I mostly use Git with a 1-branch-per-repo setup,
so in 99% of my use-cases, when I have to specify a branch, it's
master).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
