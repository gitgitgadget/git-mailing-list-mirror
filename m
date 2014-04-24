From: James Denholm <nod.helm@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 16:06:57 +1000
Message-ID: <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<20140422213039.GB21043@thunk.org>
	<alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
	<CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Lang <david@lang.hm>, "Theodore Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:07:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdCoU-0003Vr-AT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 08:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbaDXGHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 02:07:00 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:52346 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaDXGG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 02:06:58 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so2330923veb.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bhxFCQADYR+b07RbUJ9OBHkW94/c/uXcDnHKZXoBbIk=;
        b=zDrLr8uU3M6W3rQ0j/mwgTBirYUtZhVYC3NobPKNTU9ihSMXhY/Q2Bsd9fo41wiw2R
         nd5qVNVu1PpFh7cwNF/LDf+2HgRWUHtK3S3etCNWU5myOoFWi12P8mkBgybjuRJUkSyS
         6E75XZGGmY8x9/qqjG0LC8bbHqkZGSpVu+jBcIw+KPrYsEaSt3TumFbfBJODbJ2wj+Zo
         kUj9qfQxmv/gnoLEt06hDu98igqHWoeWAtvjChNJhvMUWJgS/ww3a0Cs+UOuDadqUrN+
         d6jfYjTsc2zTWepdqfGnZrSw4XhIUvp0+1LGM7EqC68jS/xtX6StIiYxyjivqnj3wslD
         eZ/w==
X-Received: by 10.58.178.130 with SMTP id cy2mr474vec.55.1398319617469; Wed,
 23 Apr 2014 23:06:57 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Wed, 23 Apr 2014 23:06:57 -0700 (PDT)
In-Reply-To: <53588f448d817_59ed83d3084e@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246940>

Felipe Contreras wrote:
>This is a false dichotomy; there aren't just two kinds
> of Git users.
>
> There is such a category of Git users who are not
> fresh-out-of-the-boat, yet not power users either.

Oh, I didn't mean to suggest a dichotomy of any kind. However these
are the two groups (I
suggest) are the most immediately relevant - one calls for change, and
the other would be negatively impacted.

> Unless the aliases are already there by default.

Others, with knowledge far beyond mine, have pointed out the problems
with this. I'd suggest the
argument most relevant to my own statements is how it impacts the
learning proccess, and makes it
more likely that users will learn aliases _as_ commands, which of
course is incorrect and
potentially harmful.

> And if default aliases were such a bad idea, why do
 most (all?) version control
 systems out there
> have them?

I'm so tempted just to sass and say that it's because they aren't git...

But on a more serious note, a feature (any feature) being in one vcs
doesn't mean, by default,
that it's right for git. The status quo may be a mistake on the part
of it's followers.

(And, historically, has been many times - for an
transculturally-acceptable example, consider the
rejection of Galileo's astronomical research by the Vatican of the time.)

Just because Mercurial et. all does something doesn't mean git needs
to, or even should. It needs
objective consideration, not to just be ushered through on the basis
of tradition.

--
James Denholm
