From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri, 01 Jun 2012 11:02:33 +0200
Message-ID: <vpqpq9jievq.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338397492-13360-2-git-send-email-simon.cathebras@ensimag.imag.fr>
	<vpqzk8oq0oe.fsf@bauges.imag.fr> <4FC88310.2020103@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 11:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNku-0007U6-NH
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296Ab2FAJCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:02:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60370 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757763Ab2FAJCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:02:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q518s4pV031513
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 10:54:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaNkg-0004lp-Ns; Fri, 01 Jun 2012 11:02:34 +0200
In-Reply-To: <4FC88310.2020103@ensimag.imag.fr> (Simon Cathebras's message of
	"Fri, 01 Jun 2012 10:53:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Jun 2012 10:54:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q518s4pV031513
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339145645.65311@TPGs1WP+bzMJUUBQij0Pjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198963>

"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:

> On the other hand, considering the git-mediawiki is curently on
> contrib branch, shall we move our test environement from git/t to
> git/contrib/t ?

If so, that would be to $git/contrib/mw-to-git/t/.

I'm not sur what's best, depending on the future of the tool:

If, once Git-MediaWiki is robust, well-tested, ... and enough people are
interested, it may make sense to move Git-MediaWiki out of the contrib/
directory, and integrate it as an official command (like git-svn for
example). That would make the installation process seamless ("make
install" would install git-remote-mediawiki like other commands, "make
doc" would generate the doc, and so on), which would be nice for the
user.

My feeling is that we're still quite far from this. Although we're in
the process of having a well-tested program, and that new features are
going to come soon, there is still little interest of the community for
it (at least, uncomparable to the one of git-svn for example).

So, I'd say that we should stick to something non-intrusive, within
contrib/, and if more people show interest in the tool and if it becomes
mature enough, we can start trying to push it out of contrib/.

What do other people think?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
