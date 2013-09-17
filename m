From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 10:21:59 +0200
Message-ID: <vpqvc1z6eoo.fsf@anie.imag.fr>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 10:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLqYF-0006JS-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab3IQIWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 04:22:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43907 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab3IQIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 04:22:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8H8LwbA001730
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Sep 2013 10:21:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLqXn-0002GQ-Lw; Tue, 17 Sep 2013 10:21:59 +0200
In-Reply-To: <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	(Christian Couder's message of "Tue, 17 Sep 2013 09:26:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Sep 2013 10:21:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8H8LwbA001730
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380010921.07452@t6aTJQ+6/rOtJCPvdfB0YQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234859>

Christian Couder <christian.couder@gmail.com> writes:

> In practice though, as git bisect is a kind of binary search, if what
> you want to exclude is exclusively touched by half the commits, it
> will only add one more bisection step if you don't exclude it.

Actually, I think the same remark would apply to any other Git command
that deal with a set of revisions. If you want to review code with "git
log -p", but you don't care about a subdirectory, you may want a "git
log -p --ignore-dir foo/" or so, too.

And then, the "it's logarithmic" argument doesn't work anymore ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
