From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2013, #08; Wed, 25)
Date: Thu, 26 Sep 2013 11:30:29 +0200
Message-ID: <vpqr4ccj5fu.fsf@anie.imag.fr>
References: <20130925234121.GD9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 11:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7uJ-00088N-IX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 11:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab3IZJal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 05:30:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51501 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756278Ab3IZJah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 05:30:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q9UTDO010570
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 11:30:29 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VP7u2-0002CP-66; Thu, 26 Sep 2013 11:30:30 +0200
In-Reply-To: <20130925234121.GD9464@google.com> (Jonathan Nieder's message of
	"Wed, 25 Sep 2013 16:41:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 11:30:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q9UTDO010570
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380792634.51793@2wQh978ZDw8thA+lq7X3tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235411>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'll probably be releasing 1.8.4.1 tomorrow.  If you have time to
> experiment with "maint" or "master" to find any remaining problems
> until then, that will be very welcome.

It seems mm/rebase-continue-freebsd-WB (99855dd) hasn't been merged to
maint. Right now, the *BSD folks have a broken "git rebase", I really
think this fix should go to maint.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
