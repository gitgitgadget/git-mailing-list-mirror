From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Mon, 07 Jun 2010 21:17:25 +0200
Message-ID: <vpqzkz6fy9m.fsf@bauges.imag.fr>
References: <20100605110930.GA10526@localhost>
	<vpqljas5e33.fsf@bauges.imag.fr> <20100606164642.GA10104@localhost>
	<buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
	<20100607185439.GB17343@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:17:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLhpW-0006tN-LL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab0FGTRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 15:17:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab0FGTRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 15:17:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o57J9mAX008744
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Jun 2010 21:09:48 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OLhp7-0004Vx-VI; Mon, 07 Jun 2010 21:17:26 +0200
In-Reply-To: <20100607185439.GB17343@localhost> (Clemens Buchacher's message of "Mon\, 7 Jun 2010 20\:54\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 07 Jun 2010 21:09:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o57J9mAX008744
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148618>

Clemens Buchacher <drizzd@aon.at> writes:

> But this is supposedly a feature which helps users who type "git
> checkout <branch>" by mistake, when they really wanted to do "git
> checkout -t <remote>/<branch>".

Not sure what's the argument here, but aren't the two commands
equivalent? Do you prefer the second syntax "git checkout -t
<remote>/<branch>"? It's already a DWIM for "git checkout -b <branch>
-t <remote>/<branch>", and I find this one far more confusing:

git checkout    <remote>/<branch> => detaches HEAD
git checkout -t <remote>/<branch> => creates a local branch automatically

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
