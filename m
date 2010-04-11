From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull suggestion
Date: Sun, 11 Apr 2010 18:33:22 +0200
Message-ID: <vpq4ojit0dp.fsf@bauges.imag.fr>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
	<201004081754.24954.trast@student.ethz.ch>
	<p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
	<20100408231154.GB13704@vidovic>
	<v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
	<20100409034911.GA4020@coredump.intra.peff.net>
	<i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
	<20100410043535.GA22481@coredump.intra.peff.net>
	<m2v3abd05a91004102301i95bf7091ib2bd9da5e8a208c1@mail.gmail.com>
	<7vaataphi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aghiles <aghilesk@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 18:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O109t-0007un-Pp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 18:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0DKQhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 12:37:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:59250 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab0DKQhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 12:37:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o3BGXMxD011747
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 11 Apr 2010 18:33:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O1066-00071b-NH; Sun, 11 Apr 2010 18:33:22 +0200
In-Reply-To: <7vaataphi7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 11 Apr 2010 00\:37\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 11 Apr 2010 18:33:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144656>

Junio C Hamano <gitster@pobox.com> writes:

> git does _not_ implement a handy Porcelain to do this, but we could script
> it like this (I am only illustrating that it can be done, but I am leaving
> the reason why git chooses not to to a later part of this message).

Actually, another way to do this is

git commit -a
git rebase origin/where-you-want-to-merge-from
git reset HEAD^

That would not necessarily be a good way to implement a command, but I
often use variants of this interactively.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
