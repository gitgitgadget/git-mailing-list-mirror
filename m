From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Sat, 30 Oct 2010 03:55:50 +0200
Message-ID: <vpqzktwv3yx.fsf@bauges.imag.fr>
References: <20101029083516.GA26290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 03:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC0g8-0002YO-PU
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 03:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab0J3Bz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 21:55:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38635 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab0J3Bz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 21:55:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9U1nFAA007143
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 30 Oct 2010 03:49:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PC0fe-00076f-Pc; Sat, 30 Oct 2010 03:55:50 +0200
In-Reply-To: <20101029083516.GA26290@burratino> (Jonathan Nieder's message of "Fri\, 29 Oct 2010 03\:35\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 30 Oct 2010 03:49:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9U1nFAA007143
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289008156.7361@aisjB6fJ5+vlpamlXZg/Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160371>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sadly, at least the user manual change suggested below is probably
> not suitable, since reset --keep and --merge have not been around
> since git 1.5.3 days.  Ideas for working around that and other
> comments would be welcome.

Do we really want to keep the user manual compatible with 1.5.3
forever? It's nice to keep the user manual usable by slightly outdated
Gits, but 1.5.3 starts being really old, and older docs are still
available on the web (like
http://www.kernel.org/pub/software/scm/git/docs/v1.5.3.8/git.html ).

git reset --merge appeared in Git 1.6.2, it sounds reasonable to say
the current user manual works from this version.

git reset --keep appeared in 1.7.1, hence far more recently. But I
think it can still be mentionned at least as an alternative to --hard.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
