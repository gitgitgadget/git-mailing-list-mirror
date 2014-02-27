From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 07:25:10 -0600
Message-ID: <85ios03cy1.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 14:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0xl-0005vp-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaB0NZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 08:25:14 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:29279 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751155AbaB0NZN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 08:25:13 -0500
Received: from [75.87.81.6] ([75.87.81.6:52631] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 8B/9E-02678-8BC3F035; Thu, 27 Feb 2014 13:25:12 +0000
In-Reply-To: <vpqzjlez3c4.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 09:27:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242823>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Omar Othman <omar.othman@booking.com> writes:
>
>> Though I don't know why you think this is important:
>>> Now, the real question is: when would Git stop showing this advice. I
>>> don't see a real way to answer this, and I'd rather avoid doing just a
>>> guess.
>> If it is really annoying for the user, we can just have a
>> configuration parameter to switch this message on/off.
>
> Just saying "You have X stash" is OK to me as long as there is an option
> to deactivate it.

+1

> Hinting "You should now run "git stash drop"." OTOH is far more dangerous
> if guessed wrong. Keeping a stash active when you don't need it does no
> real harm, but droping one you actually needed is data loss.

I agree giving possibly incorrect advice is bad.

Can you construct a use case where git will give incorrect advice? 

I don't know git well enough to do that, nor to assert that it will never
happen. 

I think we need a more concrete proposal to move this forward.

-- 
-- Stephe
