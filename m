From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 18:21:00 +0200
Message-ID: <vpqbo2guff7.fsf@anie.imag.fr>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 18:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ1BK-0004za-1C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 18:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab3JWQVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 12:21:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40616 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab3JWQVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 12:21:07 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9NGKwAH004478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Oct 2013 18:20:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9NGL0JS010710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 23 Oct 2013 18:21:00 +0200
In-Reply-To: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	(Piotr Krukowiecki's message of "Wed, 23 Oct 2013 10:25:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Oct 2013 18:20:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9NGKwAH004478
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1383150060.86436@37tWV82Yru3Ar8BfNq/k3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236534>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> I think there were discussion about how there are several git commands
> which do not search in whole tree by default and that it's going to be
> changed. I think "add" is one of such commands. Is 'grep' left
> unchanged?

In summary: changing is painful. The case of "git add" was really bad,
since the same command had different behavior depending on the options
given, so it was clearly worth the pain. In the case of "git grep", the
current behavior is not _that_ bad, so nobody bothered to do the change.

(by "do the change", I mean propose a migration plan, convince people
that it is good, ...)

I'd personally be slightly in favor of changing to tree-wide, but
without strong opinion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
