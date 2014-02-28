From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 16:42:40 +0100
Message-ID: <vpq38j3z1jj.fsf@anie.imag.fr>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 16:43:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPaV-0001ZJ-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaB1Pm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 10:42:56 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49443 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbaB1Pmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 10:42:55 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SFgcJm031460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Feb 2014 16:42:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SFgeVk021598;
	Fri, 28 Feb 2014 16:42:40 +0100
In-Reply-To: <851tynz2yg.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 09:12:07 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Feb 2014 16:42:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1SFgcJm031460
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394206960.5962@kETpCjhyXvsMFSx7VpL7rw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242977>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> So it appears that adding a file _does_ tell git that the conflict is
> resolved.

Yes it does. Git _knows_ that you consider the conflict to be resolved.
It cannot know how happy you are with the result.

Similarly, in a conflicted merge, the last "git add" does not trigger a
commit silently. And a silent commit would be much less serious than a
silent data drop.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
