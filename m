From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Fri, 21 Jan 2011 18:05:56 +0100
Message-ID: <vpqmxmu2nm3.fsf@bauges.imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
	<20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
	<201101202134.41911.trast@student.ethz.ch>
	<7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
	<7vsjwmp5cs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 18:09:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgKUB-0004Zr-LD
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 18:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1AURJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 12:09:14 -0500
Received: from imag.imag.fr ([129.88.30.1]:37987 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786Ab1AURJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 12:09:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p0LH5uWv027217
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Jan 2011 18:05:56 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PgKQu-0008Tl-Lc; Fri, 21 Jan 2011 18:05:56 +0100
In-Reply-To: <7vsjwmp5cs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 21 Jan 2011 08\:51\:47 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 21 Jan 2011 18:05:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165383>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Wouldn't that suggest us that if we were to do anything to this message 
>>> it would be a good idea to teach the user to "reset --hard" the branch 
>>> if no commits truly needs to be replayed on top of the onto-commit?
>>
>> The important difference between rebase -i && noop on the one, and reset 
>> --hard on the other hand is that the latter is completely unsafe. I mean, 
>> utterly completely super-unsafe. And I say that because _this here 
>> developer_ who is not exactly a Git noob lost stuff that way.
>
> I think "rebase" already checks that the index and the working tree is
> clean before starting, so referring to "reset --hard" when "rebase -i"
> notices there is absolutely nothing to do is _not_ unsafe, no?

The point is not about letting rebase do a "reset --hard", but to tell
the user s/he should have ran "reset --hard" instead of rebase. The
danger is to teach the user's fingers to type "reset --hard" too
often, which is unsafe ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
