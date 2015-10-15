From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Falis on commit --amend when already pushed
Date: Thu, 15 Oct 2015 09:55:30 +0200
Message-ID: <vpqpp0g4lcd.fsf@grenoble-inp.fr>
References: <CACbztPOSZBaqLLUERS_yfvAEPmxS2PZs0fYTy7E_9HfLi9UGmA@mail.gmail.com>
	<vpqr3kw636z.fsf@grenoble-inp.fr>
	<CACbztPMagPGhwKT4-eaQ2Ve95sACv=NpYSHixAgKxtGXe-mSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tomohiro Koana <kntmhr.1221@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdNz-0006D1-DH
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 09:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbbJOHzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 03:55:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46030 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbbJOHze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 03:55:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9F7tUZU000650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 09:55:30 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F7tUoO009803;
	Thu, 15 Oct 2015 09:55:30 +0200
In-Reply-To: <CACbztPMagPGhwKT4-eaQ2Ve95sACv=NpYSHixAgKxtGXe-mSCg@mail.gmail.com>
	(Tomohiro Koana's message of "Thu, 15 Oct 2015 16:49:40 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 Oct 2015 09:55:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9F7tUZU000650
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445500531.06487@fgm8ozP8bUHtRJgrAJ08ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279649>

Tomohiro Koana <kntmhr.1221@gmail.com> writes:

> Thank you for the reply.

Please, do not top-post on this list. Look at how other people write
emails and try to mimick them.

> I've taken a look at the list for small project ideas and our idea was
> on the list,
> which goes to show that what we are working on is reasonable enough :D

You may also want to look at how Mercurial does this. They have a
complete system to classify commits:
https://www.mercurial-scm.org/wiki/Phases

You're not going to do something as ambitious for a school project, but
it may give you hints on what can be done.

> As for the test, we're not sure how to write a test because it
> involves remote branches, so we'd love to have advice on it.

"remote" does not have to be actually remote as in "on another
computer". It can be another repository on the same machine.

Loot at what other tests are doing in t/ (there's a README file there
too). Start with

  cd t/
  ls t*push*.sh

to get examples.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
