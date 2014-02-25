From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:15:47 +0100
Message-ID: <vpqlhwz5o58.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Omar Othman <omar.othman@booking.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 14:16:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIHrh-0004rL-Up
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 14:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaBYNQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 08:16:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57240 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbaBYNQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 08:16:00 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1PDFkBP017596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Feb 2014 14:15:46 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1PDFlxb002307;
	Tue, 25 Feb 2014 14:15:47 +0100
In-Reply-To: <530C953F.9050805@booking.com> (Omar Othman's message of "Tue, 25
	Feb 2014 14:06:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Feb 2014 14:15:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1PDFkBP017596
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1393938949.07535@7EzflX94asLQzMtwzCp/tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242667>

Omar Othman <omar.othman@booking.com> writes:

> Brandon:

Please, don't top-post on this list. Look how other people answer to
each other and follow the use.

> Please note that what I am asking for is not always dropping the
> stash, but doing that *only* when the merge conflict is resolved. This
> is simply getting the whole command to be consistent. If you do `git
> stash pop` and it succeeds, the stash reference is dropped. If you do
> git stash pop` and it succeeds *after resolving the merge conflict*,
> the stash reference is *not* dropped. This is *not* consistent and
> *is* a user experience problem. I'm not asking about dumbing git down
> by any means.

Can you describe precisely what you would expect, e.g. what Git's output
should look like after such and such command?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
