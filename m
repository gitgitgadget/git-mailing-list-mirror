From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 14:11:18 -0500
Message-ID: <CAMP44s15nxOmZb4L5qGJ1+6dy0DkUTnCq6u=SRJgqO18tK-H4Q@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
	<20130609171810.GA10858@goldbirke>
	<CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
	<20130609173342.GB2091@goldbirke>
	<20130609173739.GF22905@serenity.lan>
	<CAMP44s1F5O3vjHuL=cGys=p_dbnnE-f-Mv+j5Q1ZbyVAJCjLSA@mail.gmail.com>
	<20130609190103.GG22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ull1Y-0002yH-S7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab3FITLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:11:21 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:43142 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3FITLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 15:11:20 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so714167lbd.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y2pccrXqn0/5INNWqr/KiZ/kdvqfBnMyHyT5K9VkpLs=;
        b=w8Kz92pq8jANG/BGfjY7LfTyOjPnFILNqRGrNtiWpzKB3BLvjz0E+LzSvZMCld9qyr
         X2HWKc9E32HBq/Y379tTvh9GA1bBgjEpGLxxs7H2Vo1pU9zmOdYzDw+O2/cQ+slS3oIR
         cw5m+eEk87Z3oVIvSVvR6uQeclOiLFLfNc/KyRt3v9mOHQgGV4FhRUCWoDvwUGYMcQ8p
         7ZzESYjU6+eEFA1C0avAiSeO80FKPG+4kbJSWZWhgITro9F3acKuOKHg7VBidiV+QArt
         /AB14I9JHFgNkz7Y8gNLekrm3idS6lBNSzY3hJhzg3aoZoufxWSECJ6y+J1T1qJWid3u
         MpEA==
X-Received: by 10.152.5.7 with SMTP id o7mr915lao.43.1370805078824; Sun, 09
 Jun 2013 12:11:18 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:11:18 -0700 (PDT)
In-Reply-To: <20130609190103.GG22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227101>

On Sun, Jun 9, 2013 at 2:01 PM, John Keeping <john@keeping.me.uk> wrote=
:
> On Sun, Jun 09, 2013 at 12:53:38PM -0500, Felipe Contreras wrote:
>> On Sun, Jun 9, 2013 at 12:37 PM, John Keeping <john@keeping.me.uk> w=
rote:
>> > On Sun, Jun 09, 2013 at 07:33:42PM +0200, SZEDER G=C3=A1bor wrote:
>> >> On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
>> >> > On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.=
uka.de> wrote:
>> >> > > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wr=
ote:
>> >> > >> We should free objects before leaving.
>> >> > >>
>> >> > >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> > >
>> >> > > A shortlog-friendlier subject could be: "sequencer: free obje=
cts
>> >> > > before leaving".
>> >> >
>> >> > I already defended my rationale for this succinct commit messag=
e:
>> >> >
>> >> > http://thread.gmane.org/gmane.comp.version-control.git/225609/f=
ocus=3D225610
>> >>
>> >> Your arguments were unconvincing.  The mere fact that I raised th=
is
>> >> issue unbeknownst to the earlier posting clearly shows that there=
's
>> >> demand for descriptive subjects.
>> >
>> > Not to mention that with your subject no body is needed, making th=
e
>> > overall message more succinct.
>>
>> It's not succinct at all, because there's no short and quick
>> description of what the patch actually is; a trivial fix.
>
> Is it not equally succinct to say "fix memory leak"?

Almost. "fix memory leak" doesn't say anything about the scope; it can
be a huge change, or a trivial one.

Perhaps "trivial memory leak fix" would be better.

>> > When reading a log, as soon as I see "trivial" I become suspicious=
 that
>> > someone is trying to cover something up, much like "left as an exe=
rcise
>> > for the reader".  If the subject says "fix memory leak" then it's
>> > obvious what the patch is meant to do, and when there is no subtle=
ty to
>> > be explained (as there isn't in this patch) there is no need for a=
 body.
>>
>> You are not a rational person then. The commit message has absolutel=
y
>> no bearing on the quality of the code. If you are less suspicious of=
 a
>> commit message that says "fix memory leak", you are being completely
>> biased.
>>
>> Whether the commit message says "fix memory leak", or "trivial fix",
>> or "foobar", the code might still be doing something wrong, and you
>> can't decide that until you look at the code.
>
> I have a certain level of trust that commit summaries in git.git will=
 be
> accurate.  If I want to know what has changed, then "fix memory leak"
> implies "no functional change"; if I see "trivial fix" then how do I
> know what that is?

It is a trivial fix, that's what it is. You don't need to bother
yourself with it. Unless you plan to see the code.

> It could be a whitespace change,

That's not a fix, that's a cleanup.

> a fix to a memory leak, a typo correction, a change to a separator in=
 a message shown to
> the user,

You might be right, but I don't think you _need_ to know which one of
them it is; they are all trivial. In 90% of the cases you want to skip
them and keep reading. In the 10% where you do need more, well, you
probably need to look at the code either way.

> or even a small change to corner case behaviour.

That's not trivial.

>> If you don't care about the code, but still want to know what the
>> patch is doing, then you can look at the whole commit message, and "=
We
>> should free objects before leaving." explains that perfectly.
>
> The short message is what appears in "What's Cooking", why should I n=
eed
> to break out of my mail client to find out what it means?

You don't, it's a trivial fix, and you said you have a certain level
of trust on commit summaries ;)

--=20
=46elipe Contreras
