From: David Kastrup <dak@gnu.org>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 21:33:09 +0100
Message-ID: <87ha7l62d6.fsf@fencepost.gnu.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
	<vpqy50xd5cr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlAx-0004eU-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbaBZUdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:33:51 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:58755 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbaBZUdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:33:50 -0500
Received: from localhost ([127.0.0.1]:57794 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WIlAp-0002Qb-Ds; Wed, 26 Feb 2014 15:33:47 -0500
Received: by lola (Postfix, from userid 1000)
	id 42741E9C00; Wed, 26 Feb 2014 21:33:09 +0100 (CET)
In-Reply-To: <vpqy50xd5cr.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 20:46:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242761>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I'd however have to say that even "please resolve the conflicts
>> manually" is over-assuming.
>
> I understand your point, but in a short hint message, I still find it
> reasonable. Fixing conflicts is the natural way to go after a "stash
> pop", and the user who do not want to go this way probably knows why.
>
>> "The stash was not dropped" is the most important thing in your
>> additional text.  How about rephrasing like this?
>>
>>     $ git stash pop
>>     Auto-merging foo.txt
>>     CONFLICT (content): Merge conflict in foo.txt
>>
>>     The stashed change could not be replayed cleanly, leaving
>>     conflicts in the working tree. The stash was not dropped in case
>>     you need it again.
>>
>>     After you are done with the stash, you may want to "git stash
>>     drop" to discard it.
>
> I'm fine with this, but it's even longer than mine which I already found
> too long. Perhaps the "leaving conflicts in the working tree" could be
> dropped, as the message follows "CONFLICT (content): Merge conflict in
> foo.txt".

All that verbosity...

$ git stash pop
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt
Cowardly refusing to drop stash.
$

-- 
David Kastrup
