Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D461F462
	for <e@80x24.org>; Fri, 31 May 2019 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfEaVDb (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 17:03:31 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:32794 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEaVDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 17:03:31 -0400
Received: by mail-oi1-f173.google.com with SMTP id q186so8796278oia.0
        for <git@vger.kernel.org>; Fri, 31 May 2019 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvMiRj301tepfxRac7LCz3EVcBdkU9jioi43UtcOx0E=;
        b=vUU5TodDjTtW8f2t9GWK+qQcY11E+ZIqGSDAZxfby04B1H8XIFZ3pSlsThTUzGW01O
         +rCrhlM7JLrtaKvnA5v5iu710VMugcc+BNOo1WYlsRKeYZLjlz7K36ve89QLRWukBUec
         4ldaAR87FuDEHUfQlBLiAFn+GEtPNJVNKEuHGKe04/bS45GCajvUnyqrEvtKNEb/lire
         03XDEZxHRxgExdtqTQVTu16VrtDsKPgCd7Krz+fxbhZUiEgA3bCn/Lrg3jjji/s0huH8
         G2zorajuDJXPe378XgiYrKOmkb6T3SqvphAjhKPaChvcb0FmOpqKYNYJcjiST1+sVCeb
         Ubnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvMiRj301tepfxRac7LCz3EVcBdkU9jioi43UtcOx0E=;
        b=Snxot247Mu5It+mWRHUbldSsyyaYZomE2mVaM17Mddr8HtdfaRSa8IgdvmL/pzHetQ
         t2gy++yXarEYzPmj+POAKy+YCvj5ji/TAsIXhYnN0ZlAVYgVqJBLpfoEiQWnzWN/J/C1
         +uGZtTfqEVtl6xB8MOMRuf+MzKv6HdJxC3eNPV+roO9xeOTp9fcdz9FITHfbq+RK0/28
         yEHnaLF4ikygDi2h9hiEWRM3/6c1bNDqxLJYSQnkhu5a9IwcwONhk0cCqn0Ob9bxtBlE
         gK8JsBsgmekMQqEE1pR+q0oCQjbU4x20d6mJo2WkmIKWJJ+djyiJljbC0iZwya2v0jqB
         ASsA==
X-Gm-Message-State: APjAAAUa5D5G6RslFwcivmVy/DgkumoA2AljvTaV7e4Id4+2rd4ybHV9
        CMQMBSLm+zhpN1p5yfjLF53vlJQZn9fLuAmkNMAeYUTtvVQU5A==
X-Google-Smtp-Source: APXvYqxFUhQVqAiUzhPfXbe2Gp3j8LX6jtjdoGhrl0QHLIpYpVSZlB2Wzn7V/PZ9jAMJ291Ev8DXigd07XNBhR15QG4=
X-Received: by 2002:aca:d905:: with SMTP id q5mr472578oig.9.1559336610191;
 Fri, 31 May 2019 14:03:30 -0700 (PDT)
MIME-Version: 1.0
From:   ARAM MALIACHI <maliachi.aram@gmail.com>
Date:   Fri, 31 May 2019 21:03:19 +0000
Message-ID: <CAOkV5k19NupZ3L=2QiRuYer8-gMBFM9TKuW5RR2zzHhnVmfZ6w@mail.gmail.com>
Subject: change inside PR not reflected in the resulting squash commit
To:     git@vger.kernel.org, v-armal@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99m an Azure DevOps support engineer for Microsoft. Prior to compos=
ing
this communication to the Git team I had a conversation with the
Product Group from Azure DevOps stating this could be expected
behavior, truth is they didn=E2=80=99t take the time to analyze this with m=
e
stating our PR system does nothing extra to the regular Git tool.
However I=E2=80=99m still suspicions about it since I consider myself advan=
ced
in Git workflows.
Customer completed a PR from release/Pl4S1R4 into master. PR's id 5238.
Several commits made up this PR: 15 approximately were added to the
source branch release/Pl4S1R4 while the PR was active.
2 out of 15 commits made the exact same change to the exact same file
on the exact same lines. One of these two commits was committed to
source branch directly and the other one is a squash merge commit that
resulted from another PR completion to source branch coming from a 3rd
branch while the original PR 5238 was active.
Specifically commits [descending order]:
13ade36d - squash commit of a third branch coming into source branch
42940662 - commit made directly to the source branch
Specifically, both commits include along many changes the following
change to file /src/components/Layout/Menu.vue on line 80 and line 91
Original version of file line 80 and 91:
80   {{menuOptions.NETWORK}} {{'v'}}
91   {{network.name}} {{'v'}}
Resulting version of the file in line 80 and 91 for both commits:
80   {{menuOptions.NETWORK}}
91   {{network.name}}
The weird thing which raises a flag for me is that making the same
change to the exact same file 2 times wouldn't even be possible at all
since first change would make its current status the desired one and
therefore the next commit with the same change wouldn't even highlight
the lines as change. I believe this could be due to the nature of the
second commit coming from a PR completion [squash] where maybe the
file was kept unchanged.
What I would expect here is that the PR would read the file and would
ignore the second change made by squash commit since this exact change
had already taken place previously.
Above all this despite the PR having 2 commits highlighting the exact
same change on a file, the resulting squash commit ignored them both
and showed the lines 80 and 91 in the affected file as untouched.
I carefully verified with cx that no other commit would 'revert' this
two changes or even edit the file /src/components/Layout/Menu.vue
again so it seems like the system indeed ignored them both on its own.
Note that other changes to different lines of the affected file were
recorded correctly in the resulting squash commit once PR was
completed.

Due to the complexity of cx's environment, I haven't been able to
reproduce the issue myself, but the proof is inside the PR stored in
cx's Project.

--
