From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [GSOC Update] Week 2
Date: Mon, 16 May 2016 01:00:32 +0530
Message-ID: <CAFZEwPNMuL8hYgUNNWWU7EDmDDWF5HX7QLtTTjvvePjboEqASQ@mail.gmail.com>
References: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
	<1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqoa875e7m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 21:30:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b21kQ-0005n0-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 21:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbcEOTae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 15:30:34 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33558 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcEOTad (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 15:30:33 -0400
Received: by mail-yw0-f179.google.com with SMTP id x194so10690021ywd.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6E2nBhtizHK5tejiq0C2ViPXayh7pA9vyArZBCh9+R8=;
        b=G6XmlBVjErevA6M+7RNkjziN5T9OQc+qi8dW0el3Mim77Ncjg7G7Lr0DHTjIZS4YBb
         LaZ99g3s+nigMkhzdqpZb0DJE5LNZ+VX382yyIsUawB1qSRFCsG6SPElREps7XLtZa5J
         6oCpLGtV+CbGkJFtURtlieEG9WDdhLoWMm4Uo3SLjI5IJNbju1eaySTGF9DMFLQpWlJo
         AZmhYt8zoqEfu1ASVJ3epsPpVN+l92tuAvCrCP5vxnxc4glFj8T6Yop9abqJ6scoN/wz
         QqSC53icX4KGUwTgemW/+1qNMvNsfb9q0jk4i8cnuufhGcF5REHu2zU7qrxU5nhvYrHD
         cFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6E2nBhtizHK5tejiq0C2ViPXayh7pA9vyArZBCh9+R8=;
        b=Ji4nk8yxg8jXzodY0aizx3pA+feA6euXmtYAeO2b2tv40opjviCbnHfQIjgEr3F/lG
         yiTcUXHMbL2wXBNGfDCEllYznInGcWKWKJpF09WstpRp36UG4z6ogHVbZeOu1JUaLrrQ
         eI5GHzwQNI3LEybOKasUwiKGqWBypd5CAzoesZ8xNM77Kd7E0NblGhyNMD4NDqsMjR3I
         aI4JRGCYG5187NPMwBGOjeP3c7/JybfIThc7HhxSCmPHU2i6og+1XcugbSutrYqPCQf5
         RuGeaaQELtIQksS6LJRRaeXFkX+RuzAQqgyTeT1nxwBMMSC6RkDkZVpj67diDHGDRkRq
         51EA==
X-Gm-Message-State: AOPr4FVtEVeeqGHmnAh3H3BFkm3Qf2UBgJWmWzinCUgZazVo8EOXBz+eT/0/4HwA1ye7vZUQagl28bjUhXaYOQ==
X-Received: by 10.37.118.69 with SMTP id r66mr12562718ybc.80.1463340632477;
 Sun, 15 May 2016 12:30:32 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 15 May 2016 12:30:32 -0700 (PDT)
In-Reply-To: <xmqqoa875e7m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294680>

Hey Junio,

On Mon, May 16, 2016 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>    is available for testing on the pu branch. I am encouraging people to
>>    test it and provide useful comments.
>
> Do not encourage people to "TEST".  In general, do not put too much
> weight on testing.  The result would only measure a small portion of
> what you wrote in the code, i.e. what you covered with the addition
> to the test suite, plus whatever tests we already had.
>
> Instead, ask people to review.  A new code passing the testsuite is
> a minimum requirement, and that is far from sufficient.

Okay. Will keep this in mind.

>>  * I have also converted bisect_log() and bisect_voc() whose patches[3] are
>>    sent to the list. Junio is yet to pick these up.
>
> Again, my picking them up is not a success criteria (and certainly
> being on 'pu' does not count for anything--it is nothing more than
> "Junio saw them on the list and bookmarked the messages".
>
> You should worry more about people not commenting nor reviewing them
> than me picking them up (which would typically come later).

Sure.

>>  * The main part (I think) was that I read about the method's which handled the
>>    refs. It was an interesting read though I did not read upon the actual
>>    implementations of those, I mainly covered "What does the method do?" and
>>    "How to use the method in my code?". git-grep is my best friend for this.
>
> Yup.
>
> You would not be calling for-each-ref from a C rewrite of
> bisect-clean-state.  Instead you would likely be calling
> for_each_ref_in() to iterate over the existing refs/bisect/* refs,
> recording their refname and objectname from the callback to
> something like string_list, and then after for_each_ref_in()
> finishes, iterate over the resulting string_list and running
> delete_ref() on them.

Actually I was seeing how for-each-ref called filter_ref() and
planning to use that. But for_each_ref_in() seems much better. Thanks.
I had planned on using delete_ref().

> And reading the implementation of for-each-ref and update-ref is a
> good way to find the need to use these API calls and how they are
> used.  API docs are your second step.

Thanks. I have read the man pages as well as some parts of the
implementation (not the core details). API docs contain little
information about ref handling though. I can try trying writing some
documentation after GSoC project once I am comfortable with ref
handling.

> Overall, good progress for an early week.

Thanks!

Regards,
Pranit Bauva

> Thanks.
