From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 13:29:50 +0200
Message-ID: <001c01ce5c5f$d581b8a0$808529e0$@schmitz-digital.de>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>	<20130528110014.GA1264@hmsreliant.think-freely.org>	<7vobbv2fze.fsf@alter.siamese.dyndns.org>	<51a568db9c9b8_807b33e18996fa@nysa.mail>	<ko4jf7$e4d$1@ger.gmane.org>	<CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>	<001601ce5c5d$89974830$9cc5d890$@schmitz-digital.de> <CAMP44s0U65oxCVy3EwQxF+4ZgRc31z29mwwdO=4x--oFVTFW+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Felipe Contreras'" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheZp-000644-SS
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965499Ab3E2L3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:29:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52159 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965478Ab3E2L3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:29:53 -0400
Received: from DualCore (dsdf-4db5271a.pool.mediaWays.net [77.181.39.26])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LgXxN-1U2WSY46qb-00nwhg; Wed, 29 May 2013 13:29:52 +0200
In-Reply-To: <CAMP44s0U65oxCVy3EwQxF+4ZgRc31z29mwwdO=4x--oFVTFW+g@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIZRmwJ3YD97SQ9HOHpf/nu9snqLwILqjWaAN8L5zUCjtBjewKk33BDAcf4QhQBowjOiAJDwr3qAjd4YlyYBgx/gA==
Content-Language: de
X-Provags-ID: V02:K0:wqjfGZXh6W9+rHB65gjyiXy9MUy0l+lo+w3lhnceOsK
 BU5VsbY+MfLd7zXXtMZjCnK8hezJBruDqJ0IsT2JK89iHFTuJG
 cUBoRNrEhI1tMZ3zfSH3Zk05jPZwcpaX1KhU+78SRMWVLa8czn
 opZxijrssytVQFe0pp07jv2gg52znMrXLuYnJKww6Q3Nwt3nWA
 oz2PQqlB7+12YkkvSFlZvLJGS+O12PWMXE/2otgLbDoHtYm95U
 JkMQJ7QNtCstBCHbEN3WN5kUWJ2IpESENZr7zbV/T1a7AwzRUx
 gyxwY9KLMIYxqY660Xp2gUNtVcjeuGU74oYVgAyxFWFVHiFp7s
 wErHHCu/PjYEvKWRx4W7QtqpQEpOGmmGKcbPSoPDDAqhoQK29b
 qyejYxLcXCBWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225791>

> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, May 29, 2013 1:24 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 1/2] sequencer: trivial fix
> 
> On Wed, May 29, 2013 at 6:13 AM, Joachim Schmitz
> <jojo@schmitz-digital.de> wrote:
> >> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> >> Sent: Wednesday, May 29, 2013 12:52 PM
> >> To: Joachim Schmitz
> >> Cc: git@vger.kernel.org
> >> Subject: Re: [PATCH 1/2] sequencer: trivial fix
> >>
> >> On Wed, May 29, 2013 at 4:58 AM, Joachim Schmitz
> >> <jojo@schmitz-digital.de> wrote:
> >> > Felipe Contreras wrote:
> >> >>
> >> >> Junio C Hamano wrote:
> >>
> >> >>> It probably is better to fold this patch into the other one when it
> >> >>> is rerolled to correct the option name gotcha "on the tin".
> >> >>
> >> >>
> >> >> Why? This patch is standalone and fixes an issue that is independent
> >> >> of the other patch. Why squash two patches that do *two* different
> >> >> things?
> >> >>
> >> >> Anyway, I'll happily drop this patch if you want this memory leak to
> >> >> remain. But then I'll do the same in the other patch.
> >> >>
> >> >> This mantra of avodiing 'goto' is not helping anybody.
> >> >
> >> >
> >> > adding 5 letters (to change the next "if" into an "else if") versus your
> >> > addition of several lines and some 15 additional letters (ignoring the
> >> > whitsspace)  is IMHO enough to see what is better?
> >>
> >> This has nothing to do with what Junio said.
> >
> > Well, it has, but you had snipped it. But replied to the goto issue regardless
> 
> I didn't snip anything, this is a different context.

You did in your reply to me

> >> This is better done without "goto" in general.
> 
> He din't say:
> __
> It probably is better to fold this patch into the other one when it
> is rerolled to correct the option name gotcha "on the tin", AND you
> fix the goto issue.
> __
> 
> You added that last part in your mind. Moreover, he didn't say goto
> was an issue, he simply stated an opinion about some generality.

I added nothing in my mind, I just copy/paste that statement and was commenting on that and only that.
At least intended to.

Whenever anybody added more else branches, that's the time to possible switch to the goto style.

And for the record: I agree with you that these 2 things should rather not be in a single patch as they are completely unrelated.

Bye, Jojo
