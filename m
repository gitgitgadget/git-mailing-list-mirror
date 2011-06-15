From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 15:40:41 +0530
Message-ID: <BANLkTin5mJ4WsAd6eRUUoJykxRu+vJ-_oQ@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
 <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com> <4DF74EEC.1050506@op5.se>
 <BANLkTikCB7t4DhCxjLT-JABsUuksPBhkLw@mail.gmail.com> <4DF86BB3.4070906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 15 12:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWn41-0004ii-QN
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 12:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab1FOKLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 06:11:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab1FOKLC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 06:11:02 -0400
Received: by wwa36 with SMTP id 36so284056wwa.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KhAqdK/P2xHxUQmJKdJ7KyezuCpIAhYROidO12pDkzk=;
        b=KU69MOi7LVWBg+1DntJ04uW86TGzQsTICOcCfMpWXQJefzTeMCtFOolP5WPzYeWoWg
         OYA2O+KHxHI2kAlGzdJkNr0kpmVQc0bmJ5S5bFFYT+LO1kdrDCUb0onOlYJirgRBrbn3
         i98Q8HBqhunD5UCoihqNTnYqpfvaLjqbrQPic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=D3yWe7wzeeYfAqBjiByHK1LfH4v2ZrSIgK187jamGYR76noWUi0KvyQqLS8MICCMRr
         p2FZnUAJJRQI3uVJbdllEyAzqqMURHURhql+2WOnZzzuOjyZMH9PNL0H3aTC019/e9Wj
         /Sn+0e+oX/pi+emCHWBhc06nqGu3ZIO7sFTN8=
Received: by 10.216.145.206 with SMTP id p56mr1907391wej.80.1308132661112;
 Wed, 15 Jun 2011 03:11:01 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Wed, 15 Jun 2011 03:10:41 -0700 (PDT)
In-Reply-To: <4DF86BB3.4070906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175819>

Hi again,

Andreas Ericsson writes:
> No and no. No auto-signoff, and no auto-message. That will just leave
> us with a long string of auto-signoffs and automatic messages, and
> that's horrible.
>
> The "no auto-signoff" rule is from Junio btw, and I doubt he's changed
> his mind regarding that. The "no auto-message" is just my gut feeling
> that everyone will really hate to see changes without an explanation.
> Something simple like "5 out of 6 of the large scm's (in terms of
> userbase) uses 'blarg' instead of 'fnurg' for commits, so let's call
> it that in our examplinitian translation too" is enough and will be
> quite helpful when it comes to explaining why a change is made.
>
> Otoh, "Updated translations for new release" will probably be the
> most common message, and that's fine too if that's what happened.

1. Auto signoffs: Do you want translators to explicitly type out s-o-b
message after contributing a few translations?! I think it's fair to
assume that many of us use auto-signoffs as well -- I personally have
format.signoff set to true, but I've read SubmittingPatches.  I don't
propose to have a blind auto signoff, but translators can atleast be
forced to read the agreement and hit "Yes, I want to auto signoff all
my contributions".
2. Auto commit messages: Er, what I meant: the translation coordinator
has to clean up the history and fill in the commit messages before she
tries to get the new translations merged into git.git. The lazy
translators have the option of leaving it empty.

One quick query: Let's say there are 10 tiny commits modifying the
same line in the same language, and the translation coordinator wants
to squash these into one.  Is it alright to have the authorship info
point to the coordinator, with the commit message crediting all 10
individual translators?

-- Ram
