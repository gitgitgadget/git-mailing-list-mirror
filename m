From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 04:14:35 -0400
Message-ID: <CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabor Bernat <bernat@primeranks.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVxlB-0003h1-O4
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 10:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbbH3IOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 04:14:37 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35265 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbH3IOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 04:14:36 -0400
Received: by ykbu129 with SMTP id u129so20494925ykb.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qCrdi5XBxh3FPygdYc7KWPgjI/8rpmDWiOeq7qKE1M0=;
        b=WxLQsu5F9nUD37K6TAIblLs02LriHMG4qiGwi4uWH3tksUAisdbQuum75VTLXbTxbu
         t3HxU0ZvD7dfwV/JTNdwL9E0UaFb4CTo7KU5fkzCX7DgePzUX64+fgTQL3e9w+UVgQi6
         HIBbjpC2bT25HokZ9vnY75a2PWRjlq6y33cpB9cOWHIcDwsLeJCU6Fib+3a658fIrlzE
         yuu5CXK5BNUtjiw4BcTcP8b5X6OZ7aKM+dbMDEI0me2N2fzHogVnmSvInd4t7x8vMj2a
         MAOSJEfhM19MHRtQ91Up+g85HEewO9Gu37q1zBCpazZyS7whW7K9VM3oBL7s4MArHco3
         fxtQ==
X-Received: by 10.129.76.151 with SMTP id z145mr16674191ywa.17.1440922475430;
 Sun, 30 Aug 2015 01:14:35 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 30 Aug 2015 01:14:35 -0700 (PDT)
In-Reply-To: <CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
X-Google-Sender-Auth: XgGr5KsaOy7yY6zjJHgyR4GUQHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276810>

On Sun, Aug 30, 2015 at 4:04 AM, Mikael Magnusson <mikachu@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 5:15 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 29, 2015 at 11:00 PM, Gabor Bernat <bernat@primeranks.net> wrote:
>>> Reading after it, I think the most close we can get with this is, awk
>>> 'BEGIN { print strftime("%c", 1271603087); }; and just ignore setting
>>> this value (and avoid displaying it) if that fails too. Do you agree?
>>
>> strftime() in awk is a GNU-ism. It doesn't exist in awk on Mac OS X or
>> FreeBSD, or even the default awk on Linux (which is mawk on Linux
>> installations I've checked).
>>
>> Most portable likely would be Perl, however, that's probably too
>> heavyweight inside a loop like this, even if called only once each N
>> iterations.
>
> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
> Found this,
>
> awk 'BEGIN{srand();print srand()}'
>
> srand() in awk returns the previous seed value, and calling it without
> an argument sets it to time of day, so the above sequence should
> return seconds since the epoch, or at least something in seconds that
> is relative to a fixed point which is all that's needed in this
> thread.

Indeed, this seems to be portable in my tests, and presumably works on
Solaris, whereas "date +%s" doesn't (according to that stackoverflow
answer).

> this can work instead of the data command for getting the time
> elapsed, however for getting the actual date of a timestamp is not
> possible generally; so I think I will just remove that part.

Agreed. I was going to suggest the same.
