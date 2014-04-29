From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Wed, 30 Apr 2014 08:25:03 +1000
Message-ID: <e904f1b8-56eb-4584-9f2e-5a842c870aa0@email.android.com>
References: <535C47BF.2070805@game-point.net> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch> <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com> <535f62c1e740a_45e485b30887@nysa.notmuch> <87r44g33z4.fsf@fencepost.gnu.org> <535f702352d21_3aee3b2f0b9@nysa.notmuch> <87mwf431t3.fsf@fencepost.gnu.org> <535f76db38a34_6f23159b31099@nysa.notmuch> <87eh0g30it.fsf@fencepost.gnu.org> <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch> <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com> <535f915e3ed89_2719108f30817@nysa.notmuch> <514ff3d6-aea5-4b1d-8ff4-14e77987
 6fb1@email.android.com> <535fa9b15a495_6d5dff2f0e0@nysa.notmuch> <e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com> <53601d818409d_2f8c107d31055@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:25:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGSt-0007hM-OB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbaD2WZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:25:19 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45884 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaD2WZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:25:16 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so905744pad.29
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=UYe2iGVvmSfhPje+AYZbLHOkOO5qC9RJcuyUOoddcaI=;
        b=D/59DBiyM2GbAw/r08RmXuMxjeUXXgrcviG449FCMP9g4utDXeqyPEsOohIUFTQrBl
         gvOrqFmvRDeEgUx4Z5C75c7aV9Zc4EnZG9bLOvrTPYHJ8phjZcky4eCmiA1NO0e2L0x4
         KHsEvwumFcxphfombVHnTmIYeu+3SARW0sM8mmeMIFME+U54TwYMkVS/eU31Z8+6g/g9
         BIrNLBfNR2uDLzoc2MLwnOJkl7SRQbC/+YLVtwoKV6nVIAWct5SBF3Stb+2NIo0+shlM
         u+FweVL3bvHnlH0E180MWCwoKOh+7t+2/ZSVT/n7Hj/kXPQUE0pY92pv8NeDt8b22wtQ
         PwQg==
X-Received: by 10.66.192.73 with SMTP id he9mr1151722pac.88.1398810315665;
        Tue, 29 Apr 2014 15:25:15 -0700 (PDT)
Received: from [10.71.91.68] ([101.119.27.206])
        by mx.google.com with ESMTPSA id au16sm119820116pac.27.2014.04.29.15.25.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 15:25:14 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <53601d818409d_2f8c107d31055@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247656>

On 30 April 2014 07:45:37 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>James Denholm wrote:
>> On 29 April 2014 23:31:29 GMT+10:00, Felipe Contreras
><felipe.contreras@gmail.com> wrote:
>> >James Denholm wrote:
>> >> So that we can all have egg on our faces when it takes off and is
>> >> proven superior... Right?
>> >
>> >I don't know what you mean by "we", but it certainly doesn't include
>> >you.
>> >
>> >  % git log --author=nod.helm@gmail.com master
>> >  empty
>> 
>> Sure it does.
>
>No it doesn't. Unless you have some credentials in the Git community,
>which come after several contributions, your opinion carries no weight
>at all. This might not be ideal, but that's the way it is.
>
>You have no credentials, your opinion doesn't count. You are not part
>of
>the "we" you referred before.

I find your lack of reading comprehension... disturbing.

To reassert the my full statement, as you so hastily truncated:

>James Denholm wrote:
> Sure it does. I didn't (and don't) have any impact on the
> debate and resulting community views, but I recall recently
> that I prescribed to the arguments that default aliases
> are a bad idea. I'm not arrogant enough to suggest that
> my views matter at this point, but if git-fc is proven superior
> by community adoption, I would be as wrong  as anyone else
> who held that view.

>> So I'll ask again - you've described frustration at the
>> pace of git development, and that you feel that your patches
>> aren't being accepted. If you feel that this is ultimately to the
>> fatal detriment of git, why are you still trying to convince
>> vegetarians to join you in hunting when you could simply find
>> a more willing group?
>
>If by convince you mean apply my patches, my patches are still getting
>applied [1].
>
> (...)
>
>[1] https://www.ohloh.net/p/git/contributors?sort=latest_commit

But that isn't the case. If it was, you wouldn't have a blog post
up about how git-fc has default aliases (and such), while git
does not. You wouldn't have another post exclaiming
frustration at the pace of development, and how certain
contributions of yours have been ignored.

Sure, a subset of your patches are being accepted, but if
the ones you cared about weren't, this discussion
wouldn't have even occurred.

>Either way your analogy is completely wrong as I already explained
>multiple times. I'm not trying to convince vegetarians to go hunting,
>I'm saying they should eat something, bread, meat, vegetables,
>anything.
>Instead they choose to starve to death.

Not at all. You propose solutions, rather than *just* calling
for any solution to be accepted. I'm the meantime, the
community decides that some of your proposals
aren't good ideas, and decide to consider others in due
course.

>And I'm done discussing with you. Your comments are content-free.

Only code-free. And that's because this is a people problem,
Felipe, not a code problem.

Regards,
James Denholm.
