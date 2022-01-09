Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC2C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 03:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiAID0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 22:26:18 -0500
Received: from mail-4324.protonmail.ch ([185.70.43.24]:62439 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiAID0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 22:26:17 -0500
Date:   Sun, 09 Jan 2022 03:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641698775;
        bh=2xy/N0vRbmInUH5byIAVz06pFaaU7mn4GMGFux2pEx0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=MEIuLNArVJTaIyBl+7QdYBfXs9BeziB9jmJcwbBQ3Zp7srFUkLWwygZMihzMTGeCE
         1+CWAy09RhudNprwBunylMDCzk69LPG0F7KpugQVpQc57QckobgRZcDPPoCtUkBDS0
         7bnWbWbuNl+7bXANuLw5mRagMb5j+UemAsKN1ruEne8vOKcnfNZTRUeDIeo6wRIXGq
         MMXd2F4niCOOCVgDqaJqMHsZ91nVwOnV9nb1DuDihMHIOSK0BR5KddURy13hijcOCF
         oIpj+/a8/UW7ihwLe4NyO2DGGPbmxAnMHxE0kvVpj4pNnGrEni+sLYE0B11DquH0je
         9HR33s4qI7sfA==
To:     Emily Shaffer <emilyshaffer@google.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Review process improvements
Message-ID: <rcGd-SpUU-W-tTnksrZa3gaeC9Kswpy7oPiOyp-GGV5WJgkoICgiD5ppeFz3h89h0l8C1fSRv5XcI6pqR4uEaG8mh29uWmPUDk-NORRkt2o=@protonmail.com>
In-Reply-To: <YdTuMlAkVIivp1bg@google.com>
References: <YbvBvch8JcHED+A9@google.com> <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com> <CAPig+cT+NshUMS+BNLKDMuwOEXKEzS3Ve=hK3kCYEBvJNzXuxQ@mail.gmail.com> <J3wlC13aBBawF42_jmIX-9_4S5yvG4W-8miLgPASeby-v_QHn5Vw72gGy8E8WB-TQhGvrvpeC4Y2PnTIy3b1o6In_WHDzZ3s9nf2getOzRU=@protonmail.com> <YdTuMlAkVIivp1bg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That makes sense to me. As =C3=86var mentioned - just because he and I ar=
e
> working on config a lot right now, doesn't mean we will still care in
> 2023. And remembering to remove yourself from the MAINTAINERS file is a
> pain.

 Maybe make a "contributors" file instead and merely list there who have
contributed with Git, what have they contributed with (or group
contributors by their types of contribution) and means of contact, like
institutions they are a part of, e-mail addresses, telephone numbers,
while highlighting that all e-mails related to Git are expected to be
shared with the mailing list unless stated otherwise. Also make the
input of personal information beyond name voluntary.

> Some providers (at least Gmail, and based on Jo=C3=A3o's reply-to address=
,
> protonmail as well) allow mails addressed to
> e.g. "my-name+from-git-list@example.com" to be delivered to
> "my-name@example.com" regardless of what follows the +;

 Although ProtonMail allows the use of + aliases, no filtering
is done automatically.

> I have only recently seen you begin to post here, so welcome! and I
> think I saw someone else mention in another thread, but I'll say again
> now: in general, please wrap your lines at ~80ch when replying to the
> mailing list;

 Is "80 ch" 80 American units? (half-joke)
 I also have no idea on how to configure that.

> I'm not really sure what you mean by "non-committal" here. I will say
> that messages coming from the Git mailing list does not imply that
> messages are safe in any way; we get plenty of spam and phishing mails
> making it past vger.kernel.org's filters. The proposal of a MAINTAINERS
> file was definitely not a proposal to modify the review process itself;
> as always, the expectation is that code should be reviewed by a number
> of contributors to ensure it's doing what it says it is trying to do. I
> don't see that that will ever change.

 Brain fog, I don't exactly remember either. From what I got I was
thinking about the servers sending messages in the name of the parties
listed, not only to them. Also I might be thinking of people sending
malicious code through commits and git operations and it causing
problems and also about e-mail addresses being compromised.

> For what it's worth, in my Gmail web client I filter out any mails
> beginning with `[PATCH` - because in web client I am like you and
> usually only want to participate in broader discussions. So I think
> there is already a solution for filtering the way that you want to.

 Can't we automate it at the source, though...
 ;A;

> As I mentioned in my mail, we are only conducting review of commit
> messages and cover letters, not of code - specifically because it is
> so important to perform in-depth code review out in the open, for the
> reasons you say. Code review should always happen on this list, and I'm
> not suggesting to change that. (That's true of patches submitted via
> GitGitGadget too, by the way - we don't perform review in the comments
> on those GGG pull requests, for these same reasons.)
>
> As for the Googley review know-how.... like I mentioned in my reply to
> the main thread a moment ago, there's not that much "secret sauce". :)

 I still believe that methods of reviewing commit messages might be
helpful if shared collectively.

> However, if you're curious, you might keep an eye on the #git-devel
> channel - we have recently started doing public "review club" live
> meetings and inviting the Git community to join us in reviewing patches
> on the Git list. The next one is this week, so if you're interested and
> the timezone works out, you'd be welcome to join us.

 I both don't know what is Devel and how to use it and don't believe
anxiety will allow me, specially since I am very socially anxious, I
am using a TV screen as a "temporary" monitor and it triggers my
sensory sensitivities, because of the amount of information and light
(having a text heavy profession might have been a bad idea), and...

*panic*

... anxiety??? (better not delve too deep into that can of worms)

> Yes, I agree this is the best way to do documentation. Human ability to
> parse or no - having the same information in two places means that
> inevitably, one place will become stale. ;)

 Maybe use <iframe>s to embed files onto each other? Also make explicit
or (inclusively) allow the frames to be hidden or collapsed with a button?

> Again, welcome to the project.

<3
Thank you!

 - Jo=C3=A3o Victor Bonfim, please use any pronouns.
