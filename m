From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH 0/4] Re: Making error messages stand out
Date: Wed, 11 Aug 2010 11:39:58 +0200
Message-ID: <vpqhbj11o9d.fsf@bauges.imag.fr>
References: <20100725005443.GA18370@burratino>
	<AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
	<201007251122.41166.trast@student.ethz.ch>
	<20100729235151.GB6623@burratino>
	<AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
	<20100811083100.GA16495@burratino>
	<AANLkTi=cNUTG-DGZNpwrag9Wz2-JoQQamiayKVNA5wbn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7sU-0006Qo-IZ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751Ab0HKJph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 05:45:37 -0400
Received: from imag.imag.fr ([129.88.30.1]:43091 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932675Ab0HKJpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 05:45:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7B9dxop027464
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 11:39:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oj7mw-0002nY-RI; Wed, 11 Aug 2010 11:39:58 +0200
In-Reply-To: <AANLkTi=cNUTG-DGZNpwrag9Wz2-JoQQamiayKVNA5wbn@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 11 Aug 2010 19\:21\:52 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 11 Aug 2010 11:41:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153220>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Even better, make it available for some time with, say "git hints".
> After doing lots of things to resolve conflicts, I simply forget what
> it hinted me.

Actually, I don't think we should add a new command for that, but add
something to "git status", like

$ git status
# On branch master
# rebase in progress (use "git rebase --continue" to proceed)
# ...

Same would apply to conflicting merges. It's very common for beginners
(especially when they come from SVN) to start a merge, mis-read the
message telling you to commit once you fixed the conflicts, fix
conflicts, and continue hacking. A message in "git status" when
.git/MERGE_HEAD exists would help a bit, like (depending on whether
the index still has conflicts):

# merge in progress (fix conflicts below and commit)

# merge in progress (use "git commit" to proceed)


If one adds an option to make it all-caps, red, and blinking, then
I'll activate it for my students ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
