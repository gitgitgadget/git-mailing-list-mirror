From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 18:58:28 +0200
Message-ID: <CANy2qHf-HcJVyqo83y0+CtVnNp9TzHC479Lzu+NbpCF9k=8g1A@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
	<CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
	<CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
	<xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 18:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW5w9-0005bq-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 18:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbbH3Q6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 12:58:30 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35933 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbH3Q63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 12:58:29 -0400
Received: by wicfv10 with SMTP id fv10so43909863wic.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6P9kHXOb5hfwHnh/pP1nrpazc4G6yaLPdR3kCrKpqK4=;
        b=B1pXcVMKGClmKEFnIlEWfe3yMefOHVok9Ej+HHU8aTRips8er9asGF9m1Sl3j7aTzY
         LfdZnOtwrla+rlx3ADgyzd7wMGSK6Qjyqfk5kV4Y7ypLzG7kQyW6a9tPy+r/C4/z6GRy
         ARBUTimvBquoyL4Ram+pueKtR7UI9Epe29PmtFJ0M8zOmjpZdWGkI5MaauTWVFwoNgzb
         0Tz8LU2aJ5IDobFI8ZeTe4hmUqz9nshuwTq9kZ4NFcmyCTKwd1aLJ7wcvVMGtKZze8vv
         7lq6uAq4sZ3L1n1zXoo6OBCM/3xav2WnTNNg9Aon4N2lUgkc8KxtniaQaQmD/354ICXy
         T55A==
X-Received: by 10.194.86.161 with SMTP id q1mr23670120wjz.18.1440953908452;
 Sun, 30 Aug 2015 09:58:28 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sun, 30 Aug 2015 09:58:28 -0700 (PDT)
In-Reply-To: <xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: vnlg6WQpgYFgIXnsF1JzY98qaek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276824>

I would argue against the every n commit check, or at least making it
configurable, as in my case the speed is something between 0.01 and
1.5 seconds per commit. Checking it every n commit would make it I
feel quite slow to adapt. But it's debatable.

On 8/30/15, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>> Most portable likely would be Perl, however, that's probably too
>>>> heavyweight inside a loop like this, even if called only once each=
 N
>>>> iterations.
>
> I think that is true.  Now, when it is too heavy to spawn perl,
> would it be light enough to spawn awk, I have to wonder.  Even if
> the implementation uses awk, I think the time measurement should be
> done only once each N iterations (e.g. every 1000 commits measure
> the rate and divide the remaining commits with that rate while
> displaying the progress; if you are chewing 100 commits per minute
> and have 2000 commits to go, you know it will take 20 more minutes).
>
>>> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-=
in-any-posix-compliant-shell
>>> Found this,
>>>
>>> awk 'BEGIN{srand();print srand()}'
>>>
>>> srand() in awk returns the previous seed value, and calling it with=
out
>>> an argument sets it to time of day, so the above sequence should
>>> return seconds since the epoch, or at least something in seconds th=
at
>>> is relative to a fixed point which is all that's needed in this
>>> thread.
>
> In practice this should work, but it makes me feel somewhat uneasy.
>
> POSIX says "Set the seed value for rand to expr or use the time of
> day if expr is omitted. The previous seed value shall be returned."
> but I do not see anything that says that "the time of day" is
> counted in seconds around there (which is the crucial bit for this
> application).
>
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.ht=
ml
> (4.15 Seconds since the Epoch) says "The relationship between the
> actual time of day and the current value for seconds since the Epoch
> is unspecified."
>


--=20
 Bern=C3=A1t G=C3=A1bor
Student -  Budapest University of Technology and Economics - Computer
Engineering, M.Sc. - Budapest, Hungary
System Integrator - Gravity R&D | Rock Solid Recommendations - Budapest
office | 5-7 Expo ter | H-1101 | Budapest | Hungary
