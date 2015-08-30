From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 10:11:09 +0200
Message-ID: <CANy2qHdsd=nsg5OMyg3POaT-_H6PXwrycCSpzAQbJ9=oBmpR_w@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net> <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net> <20150825185414.GA10895@sigill.intra.peff.net>
 <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
 <20150826021517.GA20292@sigill.intra.peff.net> <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
 <CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
 <CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
 <CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
 <CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com> <CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVxid-0000jr-Ay
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 10:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbH3ILf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 04:11:35 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34919 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbH3ILb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 04:11:31 -0400
Received: by wicne3 with SMTP id ne3so49088179wic.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=zi5GBwr0KaJJrdr+9EKc4sRnQIML3y540uv0pXEnMDs=;
        b=uHOu+eEIBYhmTjrhX62NSdiBtLC0lUS/q6qEUX3cTyMGo3SCynb4XAWYxBgqBxbgb5
         fhntQyc0GgX0T8Pk1TSATCtSy+MzRIvDa0ikq23Hl53APZz2RWLW0aBHSh4JKgMCqr0V
         8jTeFv4j9NOGyr7NsPXdyNzSG2ohWBzEHko7kiYr5B06LE4l7FuodM3im+enbzWRKe0e
         Mg+L6nBx/4tzw72kZL0xph7JKbZqsOmnXnpt7yy4L2ytYPU1AQvV+nQ8nvrkHFHMw7+e
         HLLRLIMqj3175Utvs6tm7oMA0VhDPO27w38dkzyM6TGLuBxxOj+Me9aUNVX4C2NtB2wd
         iJKg==
X-Received: by 10.194.86.161 with SMTP id q1mr21524283wjz.18.1440922289429;
 Sun, 30 Aug 2015 01:11:29 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sun, 30 Aug 2015 01:11:09 -0700 (PDT)
In-Reply-To: <CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
X-Google-Sender-Auth: PaSBK-3SKXUMyfoJ_q1Ciiqi4go
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276809>

this can work instead of the data command for getting the time
elapsed, however for getting the actual date of a timestamp is not
possible generally; so I think I will just remove that part.
Bern=C3=A1t G=C3=81BOR


On Sun, Aug 30, 2015 at 10:04 AM, Mikael Magnusson <mikachu@gmail.com> =
wrote:
> On Sun, Aug 30, 2015 at 5:15 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> (Please don't top-post on this list.)
>>
>> On Sat, Aug 29, 2015 at 11:00 PM, Gabor Bernat <bernat@primeranks.ne=
t> wrote:
>>> Reading after it, I think the most close we can get with this is, a=
wk
>>> 'BEGIN { print strftime("%c", 1271603087); }; and just ignore setti=
ng
>>> this value (and avoid displaying it) if that fails too. Do you agre=
e?
>>
>> strftime() in awk is a GNU-ism. It doesn't exist in awk on Mac OS X =
or
>> FreeBSD, or even the default awk on Linux (which is mawk on Linux
>> installations I've checked).
>>
>> Most portable likely would be Perl, however, that's probably too
>> heavyweight inside a loop like this, even if called only once each N
>> iterations.
>
> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in=
-any-posix-compliant-shell
> Found this,
>
> awk 'BEGIN{srand();print srand()}'
>
> srand() in awk returns the previous seed value, and calling it withou=
t
> an argument sets it to time of day, so the above sequence should
> return seconds since the epoch, or at least something in seconds that
> is relative to a fixed point which is all that's needed in this
> thread.
>
> --
> Mikael Magnusson
