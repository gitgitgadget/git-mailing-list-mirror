From: John Medema <john.medema@uniteddrugs.com>
Subject: Re: Feature Request: enhance Git-GUI's Checkout Branch screen
Date: Fri, 4 Sep 2015 17:28:34 -0700
Message-ID: <CALsXy+3X7aB0xN17wgPCwR+C6-PmbNBPwLZ9huhyfp2BSrtEog@mail.gmail.com>
References: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
 <20150904044224.GA20164@gmail.com> <CALsXy+2N++xDXiiX2q1p43Sk7hW1Uh7oeQQO25Fp23H21JJpxg@mail.gmail.com>
 <xmqq37ytg79g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	IT Dev2 <john.kobinski@uniteddrugs.com>,
	SysAdmin <sysadmin@uniteddrugs.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 02:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY1ND-0000Vt-7x
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 02:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760919AbbIEA3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 20:29:00 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36500 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760890AbbIEA2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 20:28:54 -0400
Received: by igcrk20 with SMTP id rk20so23501535igc.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 17:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xWbKYmO9/Clf9sBF2bnY4UUnal2S9zg/6e5fxvb8Ri8=;
        b=YLhj2SAQ3bKubAIiACeEprFRtUhuF98UBitrudHXBNvRlpxReQWf2DgdlAVXfTkXXP
         AzJCWSsNU+K+Ju0qOW9dPS00VLLDFJi5L1lm4Yr3S99iz4jkHMhkagF4qxXKckdI5vP6
         WC3knj/3T79bIa8qu1axqilAtvjr63TFdxfRDSAZKRf5h1zqWVQHmU11HhCzyrfCcWV5
         sc0igTZUhUztu+dx2cZ8IYF+MuXrLXUZH74T8T6Jj87sTBWchp9gA7C4Mdz4rpfjtQYa
         Ceodz/MtEKdZQ0GdoJ+f/OEFqZZh3piTMwgLFkGT8hdPWU+SJQYF9rwgqjEy5mgqxwvc
         vHPw==
X-Gm-Message-State: ALoCoQnc+qscpKam4dv5qTlv4c0ZJgcxq0ZiTtH8rBYEp4gYRmbrfdAHoHXH6iQL+qdk2Y98SJtyPc7gFBB1q1plCEHtCnElbXZ6079fnDQVzlZaxf+xjanGRXZ5t45lndxl2BOE3b1U
X-Received: by 10.50.67.179 with SMTP id o19mr11616875igt.63.1441412933568;
 Fri, 04 Sep 2015 17:28:53 -0700 (PDT)
Received: by 10.107.135.155 with HTTP; Fri, 4 Sep 2015 17:28:34 -0700 (PDT)
In-Reply-To: <xmqq37ytg79g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277351>

Junio,

I can appreciate the amount of clutter you'd get with the ancient
behavior.  That said, I'd be willing to live with it.  I personally
prefer to see all the branches coming and going - if the branches are
good enough for upstream, they're good enough for me (I'm really good
an ignoring stuff).

Realizing I'm probably not in the majority, I'd think that re-enabling
this ancient behavior as a non-default option (like git config
push.default) might be nice for those of my inclination.  As of now I
need to write a script to do a fetch + create_branch( diff( local vs
origin ) ).

But like I said before, I was hoping I'd have an easier time
convincing you guys on Options A or B to make the gui more consistent
with the cmdline.

Thanks,

John Medema
Systems Administrator
United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
john.medema@uniteddrugs.com
7243 N 16th Street, Phoenix, AZ 85020
Office:  602-678-1179 x126
=46ax:  602-639-4631


On Fri, Sep 4, 2015 at 3:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> John Medema <john.medema@uniteddrugs.com> writes:
>
>> Option D has the downside that it changes the behavior of more code
>> (cmdline and gui), which is why I didn't suggest it before.  It also
>> has the downside of making the branch list longer.  But that's the
>> nature of cloning; if I copy a full directory of files to a new
>> directory I expect to get a full set of files.
>
> You shouldn't be too literal with the word "clone".  The reason
> people "clone" a project often is to work on their own thing, which
> may be based only on a handful of branches the upstream publishes.
>
> So I do necessarily buy "But that's the nature" argument myself.
>
> Not doing your option D has another benefit, other than "smaller
> number of branches" you mentioned, and it is more important one in
> practice.  Once you start your own development with your own set of
> branches, you want to see the names of _your_ branches in your
> repository, not mixed with 47 other uninteresting branches your
> upstream has for its purpose.  Whey you are working on fixing
> something for the maintenance track of the upstream, you do want to
> see your 'fix-that-thing' local branch forked from 'maint' branch of
> the upstream, and you may or may not also want to see a copy of
> 'maint' branch in your local branch namespace, but you certainly do
> not want to see 'master', 'next', 'pu' and all the topic branches
> the upstream uses to build and advance these branches ahead of
> 'maint' that you are currently focusing on.
>
> In fact, with ancient versions of Git, you got copies of all
> branches your upstream has as your local branches.  This turned to
> be unusable and was corrected at around v1.5.0 release---this was
> done primarily so that we can have a sane remote-tracking, but
> uncluttering the local branch space was also a reason why we
> transitioned to the current "separate remote" layout.

--=20
HIPAA NOTICE:  It is against United Drugs=E2=80=99 policy to receive or=
 send=20
un-encrypted or non-secured email correspondence containing Protected=20
Health Information (PHI) as defined by HIPAA law.
=20
Please use fax or phone for correspondence containing PHI.

--=20
This email message is for the sole use of the intended recipient(s) and=
 may=20
contain confidential and privileged information. Any unauthorized revie=
w,=20
use, disclosure or distribution is prohibited. If you are not the inten=
ded=20
recipient, contact the sender by reply email, and destroy all copies of=
 the=20
original message.=20
