From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4 v8] Let core.attributesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Mon, 25 Jun 2012 09:56:32 +0200
Message-ID: <vpqd34nhljj.fsf@bauges.imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
	<1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
	<1340355806-6894-4-git-send-email-Matthieu.Moy@imag.fr>
	<7v4nq3niwc.fsf@alter.siamese.dyndns.org>
	<vpqehp3j403.fsf@bauges.imag.fr>
	<7vlijbhn3x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj4AB-0000zy-S6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 09:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab2FYH4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 03:56:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40285 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2FYH4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 03:56:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5P7tuY5002057
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2012 09:55:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sj49x-00070q-Aj; Mon, 25 Jun 2012 09:56:33 +0200
In-Reply-To: <7vlijbhn3x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 25 Jun 2012 00:22:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Jun 2012 09:55:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5P7tuY5002057
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341215761.55198@tAUVBSarpiqvaCQVPUywdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200556>

Junio C Hamano <gitster@pobox.com> writes:

> I somehow suspect this is going backwards.  ".gitignore" may have
> been the original mistake; it is much more than ".cvsignore".

I don't think they are _that_ different, and if we're talking about how
other VCS call this, I can think of ".hgignore", ".bzrignore", ...

Even within the Git world, see how "man git-add" describes the behavior
of ignore/exclude:

       The git add command will not add ignored files by default. If any
       ignored files were explicitly specified on the command line, git
       add will fail with a list of ignored files. Ignored files reached
       by directory recursion or filename globbing performed by Git
       (quote your globs before the shell) will be silently ignored. The
       git add command can be used to add ignored files with the -f
       (force) option.

Another fun fact: google "git exclude" gives this as first result

  http://www.kernel.org/pub/software/scm/git/docs/gitignore.html

;-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
