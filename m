From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 15:55:30 -0400
Message-ID: <CAPig+cTYc8isW0zhtZOLAtP+Kk_j8-yGKt4uHu0THT2QG8wTXA@mail.gmail.com>
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
	<CANy2qHf-HcJVyqo83y0+CtVnNp9TzHC479Lzu+NbpCF9k=8g1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW8hU-000259-6b
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbH3Tzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:55:32 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34958 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbbH3Tzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:55:31 -0400
Received: by ykbu129 with SMTP id u129so28117224ykb.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aiaucAVlms77f26V4nI6davQTBBz1mAHQqUh6U40tDw=;
        b=dw6oHOlKPfEdFu1tXEk7MbgcZOedbF0jIvyLD8ogg63XqZjREXaXVDabgGXHcm2hQI
         B47mwx3uvLywIoSp47bME8GRNxbzGrnHzNQdqdJKpXSG3wkkntVA5zbvtceto51vtt7C
         pKSBIgYWHtavBMJZsor5PS7Lfq8LM0n7L7A0qZX+LZ4OD4MrccV8kzNsbqZLPrclvwA3
         F1O5fkTICrYg1S4s5hW8U4Vew5FXpIrCsopZLP+TyqHZmO9RQJNSYd+/tEJXMXIODnSV
         rNgye4upujqTzcgY9Hh/JyL1TZxNdYEuP+uLbdm9Tw5ZY4yc2vIp+D1hezinTR2tvZwx
         4Vgw==
X-Received: by 10.170.136.17 with SMTP id d17mr17611971ykc.127.1440964531016;
 Sun, 30 Aug 2015 12:55:31 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 12:55:30 -0700 (PDT)
In-Reply-To: <CANy2qHf-HcJVyqo83y0+CtVnNp9TzHC479Lzu+NbpCF9k=8g1A@mail.gmail.com>
X-Google-Sender-Auth: 5A51meg0iDrS8q2tfre2G3-rXjs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276836>

(please don't top-post on this list)

On Sun, Aug 30, 2015 at 12:58 PM, Gabor Bernat <bernat@primeranks.net> wrote:
> I would argue against the every n commit check, or at least making it
> configurable, as in my case the speed is something between 0.01 and
> 1.5 seconds per commit. Checking it every n commit would make it I
> feel quite slow to adapt. But it's debatable.

I'm wondering why these two decisions ("showing estimated time" and
"frequency of the computation") should be put in the hands of the user
in the first place.

1. Why have a --progress-eta option at all as opposed to just enabling
it unconditionally if the platform can support it ("date +%s") and if
it can be done without impacting the overall runtime noticeably?

2. Why make the user responsible for deciding how often to do the time
check (via some configuration) as opposed to adjusting it dynamically
based upon how quickly the operation is proceeding. That is, if the
filter-branch operation is zipping along at 0.01 seconds per commit,
then the time check can be done less frequently (say every 50 or 100
commits) so that it doesn't slow the overall operation. Conversely, if
the operation is molasses, moving at 2 seconds per commit, then doing
the time check more frequently (perhaps after each commit) probably
won't noticeably impact the user's perception of the operation's
progress.


> On 8/30/15, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>>> Most portable likely would be Perl, however, that's probably too
>>>>> heavyweight inside a loop like this, even if called only once each N
>>>>> iterations.
>>
>> I think that is true.  Now, when it is too heavy to spawn perl,
>> would it be light enough to spawn awk, I have to wonder.  Even if
>> the implementation uses awk, I think the time measurement should be
>> done only once each N iterations (e.g. every 1000 commits measure
>> the rate and divide the remaining commits with that rate while
>> displaying the progress; if you are chewing 100 commits per minute
>> and have 2000 commits to go, you know it will take 20 more minutes).
>>
>>>> http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
>>>> Found this,
>>>>
>>>> awk 'BEGIN{srand();print srand()}'
>>>>
>>>> srand() in awk returns the previous seed value, and calling it without
>>>> an argument sets it to time of day, so the above sequence should
>>>> return seconds since the epoch, or at least something in seconds that
>>>> is relative to a fixed point which is all that's needed in this
>>>> thread.
>>
>> In practice this should work, but it makes me feel somewhat uneasy.
>>
>> POSIX says "Set the seed value for rand to expr or use the time of
>> day if expr is omitted. The previous seed value shall be returned."
>> but I do not see anything that says that "the time of day" is
>> counted in seconds around there (which is the crucial bit for this
>> application).
>>
>> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html
>> (4.15 Seconds since the Epoch) says "The relationship between the
>> actual time of day and the current value for seconds since the Epoch
>> is unspecified."
