From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 10:18:15 -0500
Message-ID: <b4087cc50904240818w45bd1cfaq8bbc83e10a6e3781@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
	 <20090424141139.GC10761@coredump.intra.peff.net>
	 <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
	 <20090424150442.GA11245@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNBw-0008C9-3G
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZDXPSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZDXPSR
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:18:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:31962 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZDXPSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 11:18:16 -0400
Received: by qw-out-2122.google.com with SMTP id 5so957166qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PFnF7NSmh0JL0PQzHF0/vqcfHO3DeV9bJJjz1FN/ihk=;
        b=mCEvnsFbtGOOtH3qFtlJWj7pwPI9wFFn2+Ex2d4tCiQ5JSpeZoe6g6vhc34S3Hoj+F
         gaBwDI9nMAqIEDFXEUGlAlsvC3d30SoSMNDAd2h95Gdp7tpDuTP1dZtO00mxmDK/aWnR
         9ejGXKqAw0UsJUNjUostcNJ8jRSod9db2ygQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PvNTycPMU7Yr6yKqaMQFg5JTTqVwD0AsS3PDxsslmNq6/A9moSn9BgjGG72xc9vQ0J
         B4oZQtfqsIz2AZd0bjt73TCiyOS/kHbe9dLByWTQ0xs/b6cTBccK2ru+/CVZGboGCMqU
         ZSTnJ7snrcYTasSHaXN+SN0Kob0LeqSEXzrd8=
Received: by 10.224.67.133 with SMTP id r5mr2863639qai.285.1240586295457; Fri, 
	24 Apr 2009 08:18:15 -0700 (PDT)
In-Reply-To: <20090424150442.GA11245@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117449>

On Fri, Apr 24, 2009 at 10:04, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 24, 2009 at 09:30:20AM -0500, Michael Witten wrote:
>
>> On Fri, Apr 24, 2009 at 09:11, Jeff King <peff@peff.net> wrote:
>> > I think I wasn't clear in my original message. I didn't mean teach=
ing
>> > low-level stuff like plumbing or file layouts. By "bottom-up" I re=
ally
>> > meant teaching concepts (like objects, their types, and references=
),
>> > from which user operations and workflows can be explained (or ofte=
n
>> > deduced by the user). Whereas a top-down approach would _start_ wi=
th
>> > workflows and say "To accomplish X, do Y".
>>
>> I knew you would make exactly this rebuttle ;-D
>>
>> However, notice that you can't reasonably be expected to understand
>> "accomplish X" without having concepts like objects and references.
>
> Heh. I don't think you also predicted the paragraph that I ended up
> deleting, which made it more clear that I was not trying to rebut, bu=
t
> rather agree.

Indeed. I saw that last sentence of yours, but I consciously ignored
it, because I like to argue ;-)

> Like you, I think that not teaching concepts first leads to confusion
> later. =A0Version control (or at least git) is just complex enough th=
at
> you are much better off understanding what is happening than simply
> following a recipe. So when your recipe doesn't go as planned, or you
> don't know which recipe to use, or you need some variant of a recipe,
> you have some basis for understanding what to do.

That, my friend, is the most important lesson of learning.

> But users in the past have really seemed to want to start with recipe=
s,
> so that they can be productive as soon as possible (and I think some
> people have said that the top-down ordering just makes more sense to
> them, so it may just be a matter of learning style). And I think the
> user manual is somewhat of a response to that request, since the
> command manpages are very bottom-up (but are also quite confusing, ju=
st
> because of their size, and because concept information is scattered
> throughout).
>
> So I am advocating for more bottom-up documentation (which I think yo=
u
> are), but I don't necessarily think it should _replace_ the top-down
> documentation (which I'm not sure is your position or not).

I think that we've already got that tutorial-esque style covered (I
haven't read it in a while):

    http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html

However, the User Manual should make a Mathematician happy.

>> The reason most people get by is that git's operation can be
>> compatible with a number of other theories people might have already
>> picked up from using computers. The trouble starts when their existi=
ng
>> theories don't mesh well with the underlying git theory, leading the
>> user to develop the equivalent of epicycles in order to explain to
>> himself whats going on.
>
> Epicycles? I thought commit orbits were defined by the ether through
> they flowed.

Actually, those commit orbits are defined by the giant glass sphere to
which they are attached.
