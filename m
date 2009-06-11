From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 03:30:36 +0300
Message-ID: <94a0d4530906101730p22053cbbl347eddd31b347c3c@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	 <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
	 <20090610033211.GA7411@mit.edu>
	 <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain>
	 <94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
	 <alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
	 <d411cc4a0906101657v601aba20q5708e114fc7d4bca@mail.gmail.com>
	 <m38wjz4odq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:31:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEYCS-0001ub-8O
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbZFKAai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 20:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbZFKAah
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:30:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:6266 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZFKAag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 20:30:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so359562fgg.17
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RPUf/5vDo8Gz++kGOn7Y4BFlMSM9MFFGiwkicA53wWo=;
        b=wsaekShEJwvFOyVhksOMVe6R5X6aVce8A/+2Fd4L+8qPTTz3Q01R2w0RImjMGj1GZf
         XfFAi6fxCEp/wV3flbNkfQw06G9MY3wAbFaJ3y6An4U2882aLBEfJkioNdMARI5HvK18
         SAltq1vgTcBBk715k+oQ2ij7K7jyC/9ycQLCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dtvVJ3nqjQJI9SL77K4yGSHUrYVKfNAh2uu64zS6evgWLgZIbaxjElPYUwnaXDRIjU
         dmp0WPMbNdDXDu3UNS1gItmX0LFG/6FBP3zdx40W5xn71QLHmVeEn6AsGOa+tU7hSGYx
         djlIJrSJtxQes+R2xop9G4qc3P7lQZRFcALcY=
Received: by 10.86.23.20 with SMTP id 20mr1676493fgw.17.1244680237664; Wed, 10 
	Jun 2009 17:30:37 -0700 (PDT)
In-Reply-To: <m38wjz4odq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121321>

On Thu, Jun 11, 2009 at 3:15 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> Scott Chacon <schacon@gmail.com> writes:
>> On Wed, Jun 10, 2009 at 4:04 PM, Linus
>> Torvalds<torvalds@linux-foundation.org> wrote:
>> >
>> > IOW, both would be "if you give it a commit, it acts at a commit l=
evel",
>> > and "if you give it pathnames, it acts on a pathname level".
>> >
>> > That is totally obvious, and not in the least confusing. They are =
two
>> > different things, but at the same time, there is no question about=
 which
>> > is which.
>> >
>> >> In my mind these are 2 completely different commands.
>> >
>> > They are two different things, but they both make sense within the
>> > _context_.
>> >
>> > Only earthworms and FOX news have no concept of "in context". So i=
t does
>> > make sense to say "git checkout filename" (and expect it to check =
out that
>> > _filename_ - surprise surprise), and also say "git checkout branch=
" (and
>> > expect it to check out that branch - again, big surprise).
>>
>> The problem here is that you're using 'check out' in your descriptio=
ns
>> of the expectations to mean two different things. =C2=A0One means 's=
witch
>> branches' and the other means 'extract content'.
>
> In both cases it means getting something out of repository (checking
> out) and into working area.

'git reset' also gets something out of the repository and into the
working area, that's not reason enough to put them under the same
'checkout' command, is it?

> [...]
>> I understand that clarity and ease of use is not really of primary
>> importance to this project. =C2=A0However, is it not slightly ironic=
 that
>> the Git project is so obsessed with squeezing 5% or 10% of raw speed
>> out of each command, yet feels that the onus should be on each user =
to
>> study for hours to memorize a bunch of arbitrary idiosyncrasies of t=
he
>> tool? =C2=A0Can we not obsess a little about flattening the learning=
 curve
>> 10% as well (possibly at the slight expense of command normalization
>> or verb bloat)?
>
> The problem is bakcward compatibility and the fact that git was not a=
s
> much as designed, as it has grown. =C2=A0Which is very good solution =
for
> getting good feature set, but not so much for an UI...

Backwards compatibility must be broken at some point or another,
otherwise people will start to create their own aliases, alternative
UI's and even forks. Sure, it must be done carefully and planned in
advance, that's why it's a good idea to keep a list of things to
change in the next interface break.

--=20
=46elipe Contreras
