From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Getting Ensimag students to work on Git for a few weeks
Date: Fri, 21 May 2010 19:44:42 +0200
Message-ID: <AANLkTikF0rvZtl5HQl9laQZryqnh4W318GB5YIc1Zp4q@mail.gmail.com>
References: <vpqocntxhzv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 19:45:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFWHN-0000YR-Oe
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933582Ab0EURop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 13:44:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64771 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223Ab0EURoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 13:44:44 -0400
Received: by wyb29 with SMTP id 29so66396wyb.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wZfj6lNuxNSRYjhAxjktAOq+8XQ9c219XK5p/6gdPpM=;
        b=R950ScYuSuW3n7UZlYhOhl/LIq0/aGhVhITciQsSi+98QyemQvhTq+l5Q+jZjPOeb1
         4Jc54wqTLQSRkyvNrG15LMSoLqHnIkEqr0YC6a1qREIxMlKOvpQgG7pjoMrMZKwajrts
         50OEem9Uz7QLm5sM9pZSDJMGDjfnaiHtSNsEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AYrSzRj6nsIF1Qihkwxj0cLLsWQQEasQ0+BycOX72PYjXJKlDZEkeRJSdd9KjjWa53
         jYM8mquq1b90OHFhkrT6tqQ24keJ8NL3KaK/W1rhKon7ZiIPv9mQ2NH5Z6B07on3cEzp
         jIXsMiUuihXYjWykgv+d7MhpF0DTrzrN85ZyM=
Received: by 10.216.87.80 with SMTP id x58mr1055281wee.96.1274463882536; Fri, 
	21 May 2010 10:44:42 -0700 (PDT)
Received: by 10.216.10.140 with HTTP; Fri, 21 May 2010 10:44:42 -0700 (PDT)
In-Reply-To: <vpqocntxhzv.fsf@bauges.imag.fr>
X-Google-Sender-Auth: 1bRsHIyc4mUvEVQg8LjNBAhk2XI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147487>

Hi,

I'm resurecting an old thread :

  http://thread.gmane.org/gmane.comp.version-control.git/131321
  (message copied below)

and welcoming Diane, Axel and Cl=C3=A9ment (CC-ed), 3 students who have
chosen this project. Right now, they're trying to get familiar with
the codebase. As a first exercice, they'll try to add textconv support
to git-blame. The next tasks are undecided yet (but advices are
welcome).

I hope the project will be productive, both for students and the Git co=
mmunity!

On Tue, Oct 27, 2009 at 12:12 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> I'd like to propose a kind of mini-google summer of code to the
> students of the the school where I teach, i.e. Ensimag, France
> ( http://ensimag.grenoble-inp.fr/ ). In short, this means having a fe=
w
> students working for Git for a month at no cost ;-).
>
> Currently, the students have an end-of-year project (in equivalent of
> master 1) with the choice between many subjects, some of them being
> somehow "real-life" (i.e. actually usefull things), and other being
> artificial (i.e. enjoy doing it, and throw it away afterwards).
>
> This year, I'd like to propose a subject "contribution to an existing
> free software", and since the one I know best currently is Git, this
> would take the form of "contribution to the Git project". I'd see the
> practical organization a bit like the google summer of code: chose a
> feature (the GSoC proposals on the wiki can be a good source of
> inspiration), and implement it with the goal of being eventually
> merged upstream. There would be no money involved, but the students
> get a grade at the end. I would anyway follow the work of the
> students, but a co-mentoring from a Git expert would be great.
>
> The students work full-time for about 3 weeks (May 20th to June 16th)=
,
> and are grouped by teams of 2 to 4 students. Given my bandwidth, I
> plan to propose only one group of 4 students this year, but we may
> scale up later, who knows.
>
> We have plenty of time before this starts, but I'm just sending this
> email to get your feeling on it.
>
> Any opinion? Do you like the idea?

--=20
Matthieu
