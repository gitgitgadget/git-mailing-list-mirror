From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Problems with repack during push
Date: Mon, 10 Sep 2012 18:26:14 +0200
Message-ID: <vpqfw6pj13t.fsf@bauges.imag.fr>
References: <504E1256.4020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Rob Marshall <Rob.Marshall17@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6od-0005qK-NU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934Ab2IJQ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:26:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56870 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab2IJQ0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:26:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8AGLr97009195
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Sep 2012 18:21:53 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TB6oR-0001Ub-H8; Mon, 10 Sep 2012 18:26:15 +0200
In-Reply-To: <504E1256.4020605@gmail.com> (Rob Marshall's message of "Mon, 10
	Sep 2012 12:16:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Sep 2012 18:21:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8AGLr97009195
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347898915.60071@oOzCIXOVynHOTmdpD4wC6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205140>

Rob Marshall <Rob.Marshall17@gmail.com> writes:

> If I do a 'git repack' it works fine, so are these
> messages coming from the remote server?

I guess so, and your remote server has a restricted environment (chroot
or so) with very few commands allowed, which prevents shell-scripts from
executing properly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
