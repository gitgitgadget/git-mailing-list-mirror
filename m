From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 21:23:08 +0100
Message-ID: <vpqzkqfbj2r.fsf@bauges.imag.fr>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
	<20110129231310.GA11088@burratino> <vpq62t3ejje.fsf@bauges.imag.fr>
	<20110201184213.GF3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 21:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkMkx-0007KF-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 21:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab1BAUXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 15:23:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59599 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab1BAUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 15:23:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p11KN6Zs019788
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Feb 2011 21:23:06 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PkMkm-0008V0-FI; Tue, 01 Feb 2011 21:23:08 +0100
In-Reply-To: <20110201184213.GF3771@burratino> (Jonathan Nieder's message of "Tue\, 1 Feb 2011 12\:42\:13 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Feb 2011 21:23:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p11KN6Zs019788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297196589.67851@K9lnU/zF6ZV8LRjsDhkT5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165852>

Jonathan Nieder <jrnieder@gmail.com> writes:

> An rcs-style workflow (lockable files absent from worktree until
> locked) on top of git sounds fun.

They need not be absent, they can just be read-only (and lock would do
a chmod u+w on the file).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
