From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Code changes in merge commits
Date: Mon, 29 Sep 2014 12:59:16 +0200
Message-ID: <vpq8ul2pu9n.fsf@anie.imag.fr>
References: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
	<CAHQ6N+rJDtq_vtfotM+GXLdN_P==oTqGbFZ97ZQea9+mcoRBog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 12:59:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYYfu-00020q-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 12:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbaI2K7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 06:59:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35645 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbaI2K7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 06:59:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s8TAxF93016576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Sep 2014 12:59:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8TAxGbf021672;
	Mon, 29 Sep 2014 12:59:16 +0200
In-Reply-To: <CAHQ6N+rJDtq_vtfotM+GXLdN_P==oTqGbFZ97ZQea9+mcoRBog@mail.gmail.com>
	(John Tapsell's message of "Mon, 29 Sep 2014 11:01:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Sep 2014 12:59:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8TAxF93016576
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1412593156.89293@xCEb3LuWdkaQHyltJbDZNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257620>

John Tapsell <johnflux@gmail.com> writes:

> What if merge commits were forced into being always trivial?

It would be relatively easy to "force" a client to always have trivial
merges, but much harder to prevent an attacker to forge a non-trivial
merge commit (e.g. modifying his local git command) and push it.

> Ideally I'd like to see all the code changes to a code base just with
> "git log -p".

What I'd love to see with "git log -p" is the diff between a trivial
merge (possibly including conflict markers) and the actual merge commit.
That would imply that "git log" would redo the merge before computing
the diff (rather heavyweight :-( ), but an empty diff would mean "no
change other than merge", and if any, we would see the conflict
resolution or additional changes in the diff.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
