From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 15:40:20 -0400
Message-ID: <CAPig+cTf2YLWGi2swmMxdx_XpEU=GkAx11ng6VVACMX9NpA_SQ@mail.gmail.com>
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
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:40:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW8So-0003wX-BY
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbbH3TkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:40:22 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32889 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbbH3TkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:40:21 -0400
Received: by ykdz80 with SMTP id z80so59929502ykd.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o6ZjOHaldGSuvik3qzRvBO0eoTLzvshMulTQobojzLc=;
        b=y0g7B+JFqsITb1vs9lEte6PVvYOEaDxpiB6149BzaVqnrwe676f7KslIW9NBegwGXP
         X6+4TWgi4BJxH0HGFEpXuh8nDv7+L8gBW+fhvcHmcPZTpJG58OsQ/IMYY+g4PssdRddB
         6EuetCAt1c5K+mH+kWC2+z4i9iFsFSThfh/PGWQSdSJZpwnCq0KjgKxTHoQiuuD2yQog
         hnBII/CWnAgHmfScY3KugMPVNkfvLBff2HYUr/Xn5srB4lC9G2z/DKR8Dx6nDyKiY511
         QBeElCcBujteXFbxziifSpUJB8FqgjKvho7aygju5pmF+HmNbeKX/maYJ/p/LsxbFJn0
         /ocQ==
X-Received: by 10.129.83.136 with SMTP id h130mr18921698ywb.95.1440963620848;
 Sun, 30 Aug 2015 12:40:20 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 12:40:20 -0700 (PDT)
In-Reply-To: <xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 3PWy-F2V1aW3pbgvzMJmA6z16wI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276834>

On Sun, Aug 30, 2015 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
>>> Found this,
>>>
>>> awk 'BEGIN{srand();print srand()}'
>>>
>>> srand() in awk returns the previous seed value, and calling it without
>>> an argument sets it to time of day, so the above sequence should
>>> return seconds since the epoch, or at least something in seconds that
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
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html
> (4.15 Seconds since the Epoch) says "The relationship between the
> actual time of day and the current value for seconds since the Epoch
> is unspecified."

I suppose a viable approach might be to test once outside the loop if
"date +%s" is supported and print the "(%d elapsed / %d estimated
remaining)" annotation within the loop if it is, else not. The test
might look something like this:

echo $(date +%s) | grep -q '^[0-9][0-9]*$' 2>/dev/null && show_eta=t

Platforms, such as Linux, Mac OS X, and FreeBSD, which support "date
+%s" would get the annotated output, whereas it would fall back
gracefully to the non-annotated output on platforms such as Solaris
(and perhaps AIX) which lack it.
