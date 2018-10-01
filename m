Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697571F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeJAVim (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 17:38:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33454 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeJAVim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 17:38:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id 84-v6so8306586qkf.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=enSaF8jKsOjz9C030hC5h53PdMQvr2vMu1U30fAo3kc=;
        b=tQ2c3REhNMMWGqSaR7VEQW8bnVfTcFeBCy+GKyKQ3VrrXAW3KPhL52tMs13sgevDtk
         IE3C/tfu4ECYK7zAaPCDIQCIizuAsQODmTrFDwZWNSPZiAdkdCDP92L+DZv2E+EkYmAQ
         2KjEiP7Im8c+8h8Jionu04vqbS18cU9tdSV7xZznR8SvIB/bn7zG9RAsPDyNou/w44uY
         1ma5FILiK/pJZMA3beXzBOVbrj0fVVJRV9RF0luwdHBOKbeN5Fx5g5p+s2PcYl99AwRD
         G31hDAk16gSCX+cu9heCQAdZx8EAx0nu/hG7/UthenOyH+bEZvVOFdYT37XAVmGGrbP6
         +s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=enSaF8jKsOjz9C030hC5h53PdMQvr2vMu1U30fAo3kc=;
        b=YLoekpNBTICLv/ueuA0Rj4Vgwah7gpqtbJYVQt2vWTz96LTkrpC/qJ4LBG+OE0/fGN
         VfFdr4ElhDPyBg3T0otOo50ylQ8ztDKDyyjropFoJqj1GM9gxBAMXkIigf4xuPCMcc0Y
         Spp2rCxdkgF7KxiSam9bfwXnphOlG1JhQlpxtdgdKGkqK/qatL+kbkaTTvXl6NNZodtU
         k25QBJX6WR+xRXlp2JkBQws3yiXbUzGUsw1D0GRNB3fqeKhVzFmxMHyP8qUWTmStqoRY
         IDu2qizqqUA6WyUiW0MlAocvOaM8dfNA5pTxoRidPOErz6SFYznVGAMFRDdWGAQizQk9
         4eJg==
X-Gm-Message-State: ABuFfoiZYZCW7ECLE5O344GaV0BTG7LRaJg1WzlhmyJax3UdEkIfoXHh
        epWUU7Gskx4RG8EEw4FTUcQHckDM5yBw8roIzS+f0g==
X-Google-Smtp-Source: ACcGV61/5xYb+zsbIrGLzSn5rOUlw6XOpG1xBD+6k+xRfZk+G8CpyyzY2vEkUiMAAmOGcRN5wkOqbYwrhdsb9BKEljM=
X-Received: by 2002:a37:2d46:: with SMTP id t67-v6mr8393567qkh.351.1538406028346;
 Mon, 01 Oct 2018 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
 <87a7nyhwqn.fsf@evledraar.gmail.com> <VI1PR0902MB22239E8AFA54DE8FFC0CB67FE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR0902MB22239E8AFA54DE8FFC0CB67FE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 1 Oct 2018 17:00:14 +0200
Message-ID: <CACBZZX5bLPKYg3jSxxH_s71ZrsuDmp2ffUE-x_LbyHybrxF0Rg@mail.gmail.com>
Subject: Re: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
To:     Jose Gisbert <jose.gisbert@live.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 4:17 PM Jose Gisbert <jose.gisbert@live.com> wrote:
>
> > > Dear members of the Git community,
> > >
> > > The enterprise I work for is planning to switch from svn to git.
> > >
> > > Before the complete switch to git we have decided to implement a scen=
ario
> > > where the two SCMs live together, being the svn repository the refere=
nce.
> > > We also want this scenario to be transparent for both SCM users.
> > >
> > > I read the articles referenced at the end of the email and I come to =
the
> > > following solution.
> > >
> > > My proposal consists to import the svn repository to git using git sv=
n and
> > > set receive.denyCurrentBranch to updateInstead. Then install pre-rece=
ive
> > > and post-receive hooks and set that repository as the central reposit=
ory
> > > for git users.
> > >
> > > The pre-receive hook does git svn rebase and, if there is an update a=
t the
> > > svn repository, rejects the push and instructs the user to do git pul=
l.
> > > The post-receive hook does git svn dcommit to update the state of the=
 svn
> > > repository, then instructs the user to do git pull too.
> > >
> > > Both scripts check the changes pushed are made at master before doing
> > > anything and exit after performing these tasks. branches.master.rebas=
e is
> > > set to merges at the user repository to avoid the histories of the ce=
ntral
> > > and the user repositories diverge after doing git svn dcommit.
> > >
> > > However I'm stuck at this point because the pre-receive hook it's not
> > > allowed to do git svn rebase because update refs are not allowed at t=
he
> > > quarantine environment. I was sure that I tried this solution with a =
past
> > > version of git and it worked, but now I doubt this because the restri=
ction
> > > to update refs at quarantine environment was delivered at version 2.1=
3,
> > > that dates from April 2017, if I'm not wrong.
> > >
> > > I don't know if this solution could be implemented or is there a bett=
er
> > > way to accomplish this kind of synchronization (I tried Tmate SubGit,=
 but
> > > it didn't work for me and I don't know if we will be willing to purch=
ase a
> > > license). Could you help me with this question?
> > >
> > > I come here asking for help because I think this is the appropriate p=
lace
> > > to do so. I apologise if this is not the case. Any help is welcome. I=
f
> > > anything needs to be clarified, please, ask me to do so. I can share =
with
> > > you the source code of the hook scripts, if necessary.
> >
> > A very long time ago I had a similar setup where some clients were usin=
g
> > git-svn. This was for the first attempt to migrate the Wikimedia
> > repositories away from SVN.
> >
> > There I had a setup where users could fetch my git-svn clone, which was
> > hosted on github, and through some magic (I forgot the details) "catch =
up"
> > with their local client. I.e. there was some mapping data that wasn't s=
ent
> > over.
> >
> > But users would always push to svn, not git. I think if you can live wi=
th
> > that you'd have a much easier time, having this setup where you push to=
 git
> > and you then have to carry that push forward to svn is a lot more compl=
ex
> > than just having the clients do that.
> >
> > GitHub also has a SVN gateway, that has no open source equivalent that =
I
> > know of: https://help.github.com/articles/support-for-subversion-client=
s/
> >
> > Maybe that's something you'd like to consider, i.e. fully migrate to gi=
t
> > sooner than later, and for any leftover SVN clients have them push to a
> > private repo on GitHub. Even if you only keep that GitHub repo as a bri=
de
> > during the migration and host Git in-house it'll be a lot easier with g=
it as
> > a DVCS to continually merge in those changes than pulling the same tric=
k
> > with a centralized system like SVN.
>
> Hi =C3=86var,
>
> First of all, thank you very much for your early response.
>
> I don't think making users always commit to svn is necessary. In fact, fr=
om my
> point of view, updating the svn repository with the changes committed to =
the
> git central repository is easy because there is no obstacle preventing to=
 run
> git svn dcommit at the post-update hook.
>
> What I haven't managed to accomplish is to pull diffs from the svn reposi=
tory
> into the git central repository without manual intervention. I suppose th=
at in
> the setup you describe you manually pulled changes from the svn repositor=
y
> into your git-svn repository at GitHub. If don't, it would be very useful=
 for
> me if you could remember how did you managed to do it automatically.
>
> I guess GitHub svn bridge (thank you for telling me about it, I didn't kn=
ow
> about its existence) could be the solution if it was not for the fact tha=
t we
> want to keep our svn repository. Our whole CD infrastructure feeds from t=
hat
> repository and we'd like to figure out if everybody is comfortable using =
git
> and what is the actual value of using it as a team before making the effo=
rt of
> changing everything.

Makes sense. It's certainly not impossible to have some magic "push to
git". I only wanted to point out that it's extra complexity, so if you
could do away with that aspect of it you'd save yourself some
complexity. I was going to elaborate a bit on how that can go wrong,
but I see Jeff sent a mail just now that was better than what I had :)

I'll only add that I think you're somewhat fooling yourself if you
think you can run Subversion and Git side-by-side and evaluate both on
their merits, even if you solve the technical aspects of doing that.
Such a system will always need to cater to the lowest common
denominator of Subversion's very centralized workflow.

The big advantage you get out of DVCSs is being able to be more
flexible, and e.g. using hosting sites (in-house or external) like
GitHub or GitLab which are built around that flexibility. So
ultimately any decision about switching SCMs needs to be a
forward-looking management decision for the project, not based on how
well Git can emulate a SVN-based workflow, which is ultimately not
what you're interested in if you do make the switch.
