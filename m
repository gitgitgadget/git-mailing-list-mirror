From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 16:53:10 +1000
Message-ID: <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
References: <535C47BF.2070805@game-point.net> <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com> <535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:53:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf1ux-0006Iz-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 08:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbaD2GxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 02:53:24 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33412 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbaD2GxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 02:53:23 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so4865908pab.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=149waHbNDS36bATg2Z22posyMYeNwdfPHLmy7gmMWY8=;
        b=RX5lTgziXgQzFEaJ1aCa9fdRcDkOryCJhqztU3KsW/qmhEaBXJ5tRcxVBbOoYkOspO
         d2goPxRcFzo1f2WDLJtN9m+XL7IKqKrBmqn37TRhhH4nL4UqWl5bguEaqMx98PVJ4bHK
         AMLiwXkwdv1TUN1FydyjPQWk0hFyjygtUBN8sWSXEx9gEpGX/xoZYvqPjG8XbhP7gsNo
         siVL3iSWpQ9A4iDoWzklzwVQNwViOd8K6E0YnNbzoaMevyqCpq01lm5B3pAp8He2iwPw
         tHwb1O024vndOpeRSQWI6ZqenhRxveydxezilHzK/EqpPxKM8nAyHyGhtqGs7McAdYvE
         xeiA==
X-Received: by 10.68.194.134 with SMTP id hw6mr30507142pbc.49.1398754402870;
        Mon, 28 Apr 2014 23:53:22 -0700 (PDT)
Received: from [10.71.122.234] ([101.119.27.188])
        by mx.google.com with ESMTPSA id ry10sm104313968pab.38.2014.04.28.23.53.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 23:53:22 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247523>

On 29 April 2014 13:32:29 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>James Denholm wrote:
>> No, true, but my point was more related to that it's ones own "task",
>> perhaps being the better term than job, to debate the merits of one's
>>own work when the merits are currently unknown to the rest of a
>>community.
>
>It's still the same thing. Nobody gets assigned any tasks; people
>choose their
>own tasks, and they might choose tasks that other people were doing.

Right. Instead of bashing about in the haberdashery of
misinterpretation, allow me to explicitly restate my original
point.

You cannot expect that anybody but yourself is willing to propose,
debate the merits of and otherwise defend patches that you
have authored (herein "your patches", implying 
authorship, not ownership).

Some people *may*, but if they do not or do not successfully,
that does not imply the stagnation of the project.

Ultimately, the only person who can ensure that a patch is
championed, and the only person who need feel a
responsibility to, is the author, and that responsibility
is only ever to themselves.

TL,DR: Champion your own patches, don't ask others to.

>> > It's not Jeff's patches, they are our patches, they are part of the
>project.
>> > And it's not unusual for multiple people working on a patch series;
>oneperson
>> > doing most of the work, another adding tests, another cleaning
>updocumentation.
>> > It's also no unheard of from a person picking up a patch series
>somebody else
>> > stopped working on.
>> 
>> This, of course, would be the _other_ case where a proposal's
>> merits are already known and accepted by the community.
>
>No. John might have sent a patch series X, and maybe he didn't explain
>correctly how it would benefit the project. Later on Mark finds out how
>those
>patches would be useful for himself and takes upon himself to get them
>merged,
>so he cleans them up and send an updated version with a clear
>explanation of
>how they would be useful.
>
>It's still the same proposal X, but a different person and a different
>strategy
>to get them merged.
>
>In other words, the fact that the community has not yet accepted the
>merits of
>an approach doesn't mean that another person cannot champion it.

As addressed above.

>> The default may be wrong, you and I might agree that the default is
>> wrong, Junio and Torvalds and RMS and The Queen of England
>> might all agree that the default is wrong... But if we all live
>across
>> from a bread shop, it's going to be a difficult task for you to
>convince
>> us to go hunting.
>
>It doesn't matter if you want to go hunting and I want to buy bread,
>either one
>of those is better than starving to death.
>
>In the Git project though, we choose to starve to death. Neither were
>my
>patches picked, nor did anybody else step up with a different proposal,
>we just
>did nothing, which is what we always do.

Not at all. Hunting may necessitate a negative side
effect, such as betraying vegetarianism,  having to go out
into the jungle for five days,  risk life and limb,  and (worse
yet) sleep in a tent. This is an especially poor decision if we
honestly would prefer a loaf of bread, and we just need to find
a way across the street.

And again, I'm referring to the general case here, but of your
views of what the solution should be clash with what the
community view is, you're not going to be able to convince
the community to go hunting. To tie in with the above, you
sure aren't going to be able to if you don't engage in logical,
calm, reasonable discourse.

Regards,
James.
