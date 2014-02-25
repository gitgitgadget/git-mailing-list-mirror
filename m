From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 16:25:18 +0100
Message-ID: <vpqeh2r43kx.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Omar Othman <omar.othman@booking.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 16:25:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIJsw-0003QW-4P
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 16:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbaBYPZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 10:25:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33135 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbaBYPZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 10:25:25 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1PFPHaH022516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Feb 2014 16:25:17 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1PFPJ2U004457;
	Tue, 25 Feb 2014 16:25:19 +0100
In-Reply-To: <530CA4C9.60601@booking.com> (Omar Othman's message of "Tue, 25
	Feb 2014 15:12:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Feb 2014 16:25:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1PFPHaH022516
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1393946718.22483@Gy37O+46s4pG/f/ALK7LJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242671>

Omar Othman <omar.othman@booking.com> writes:

> [omar_othman main (trunk|MERGING*)]$ git add path/to/file.txt
> [omar_othman main (trunk*)]$
>
> Note how the status message has changed to show that git is now happy.
> It is at that moment that the stash reference should be dropped

Dropping the stash on a "git add" operation would be really, really
weird...

> (or the user (somehow) is notified to do that herself if desired),
> because this means that the popping operation has succeeded.

But how would you expect to "be notified"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
