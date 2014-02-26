From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 09:27:07 +0100
Message-ID: <vpqzjlez3c4.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Omar Othman <omar.othman@booking.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 09:27:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIZpz-0002Hz-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 09:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbaBZI1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 03:27:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54714 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaBZI1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 03:27:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1Q8R7xm013581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Feb 2014 09:27:07 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1Q8R7B7014223;
	Wed, 26 Feb 2014 09:27:07 +0100
In-Reply-To: <530D97BA.1080107@booking.com> (Omar Othman's message of "Wed, 26
	Feb 2014 08:28:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Feb 2014 09:27:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1Q8R7xm013581
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394008030.754@1uFzySTkgX3xemwCgKmiXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242702>

Omar Othman <omar.othman@booking.com> writes:

> Though I don't know why you think this is important:
>> Now, the real question is: when would Git stop showing this advice. I
>> don't see a real way to answer this, and I'd rather avoid doing just a
>> guess.
> If it is really annoying for the user, we can just have a
> configuration parameter to switch this message on/off.

Just saying "You have X stash" is OK to me as long as there is an option
to deactivate it.

Hinting "You should now run "git stash drop"." OTOH is far more dangerous
if guessed wrong. Keeping a stash active when you don't need it does no
real harm, but droping one you actually needed is data loss.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
