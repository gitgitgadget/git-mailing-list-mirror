Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCE520248
	for <e@80x24.org>; Thu, 21 Mar 2019 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCUQMG (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 12:12:06 -0400
Received: from smtp.synchrotron-soleil.fr ([195.221.0.33]:42054 "EHLO
        brouette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfCUQMG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Mar 2019 12:12:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by brouette.synchrotron-soleil.fr (Postfix) with ESMTP id 841B870007C;
        Thu, 21 Mar 2019 16:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 brouette.synchrotron-soleil.fr 841B870007C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synchrotron-soleil.fr; s=email; t=1553184720;
        bh=OVyDangQKPxSb4uwDDw5KjEtH6kafML97ogC4HaHrRA=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=aEVT4hh5AgHrvj1oZ1NhgVbzbBn+0a0T3lq5eY30C11VOjkeKW0ebs1X83G0Fw4gj
         52h4jpZ90km/2nF4SKdWVkC/2aKnE+NL5+7IgaixJ99XdIwzjO/s81mB9+6M/etg7P
         TifMHfyyk++HlIwqAiY8FRnT8oooZxNAawllCph4=
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from brouette.synchrotron-soleil.fr ([127.0.0.1])
        by localhost (brouette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Nik_RBatu12; Thu, 21 Mar 2019 17:11:59 +0100 (CET)
Received: from SUN-DAG4.synchrotron-soleil.fr (sun-dag4 [195.221.0.186])
        by brouette.synchrotron-soleil.fr (Postfix) with ESMTP id 7B4A57000D6;
        Thu, 21 Mar 2019 17:11:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 brouette.synchrotron-soleil.fr 7B4A57000D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synchrotron-soleil.fr; s=email; t=1553184719;
        bh=OVyDangQKPxSb4uwDDw5KjEtH6kafML97ogC4HaHrRA=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=CR/mb2g+8yF23J+U7X0bbYdknZ/IDkb7U6VROe8EkevIhQn0/lp8bEYO48iynLlLW
         JQu1LNoZGh6Atl5mIBfVqLO8lqLU588l3aayQD8BL2VrmQIB1O/NdHx8V3DKDNjybJ
         EEac86rQ/+TRRnOr7zEDOeuuxEcfpyYAO2NFMpgY=
Received: from SUN-DAG3.synchrotron-soleil.fr ([fe80::d9b:188b:4893:f07f]) by
 SUN-DAG4.synchrotron-soleil.fr ([fe80::1b5:8a84:6569:cfff%16]) with mapi id
 14.03.0123.003; Thu, 21 Mar 2019 17:11:59 +0100
From:   MARIE Alexandre <alexandre.marie@synchrotron-soleil.fr>
To:     Philip Oakley <philipoakley@talktalk.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE:[New to the mailing list] Searching for help
Thread-Topic: [New to the mailing list] Searching for help
Thread-Index: AdTf7/GYSonLEW8gQrO+p9va43HfTwABspuAAAJMRp0=
Date:   Thu, 21 Mar 2019 16:11:58 +0000
Message-ID: <7EF15309FAA2EA4FAB1643CB55D93ED8DBD439@SUN-DAG3.synchrotron-soleil.fr>
References: <7EF15309FAA2EA4FAB1643CB55D93ED8DBD411@SUN-DAG3.synchrotron-soleil.fr>,<11e78b8b-77f5-af1c-c362-1ca7aa8585dc@talktalk.net>
In-Reply-To: <11e78b8b-77f5-af1c-c362-1ca7aa8585dc@talktalk.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.221.0.171]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip

> This list is for the development of Git. There is a googlegroups list
> for git users. However..

Sorry, my mistake, I found this mailing list here[0] where it is written th=
at this is one for asking questions, having comments or reporting bugs.

> A detached head simply means that you are looking at a specific commit
> ((hash number)), rather than the 'latest commit on the branch'.

I think that I kind of understand what is a detached head now,=20
but my problem is when I run:=20
gitk --all
I still can see the detached head, whether I am on the 'detached head state=
' or not.

>  You did not say which OS you were on, or if you prefer the command line,
> or a visual  gui to see the current arrangement of your commits - the
> 'gitk' viewer is useful for the latter.

Sorry about that, I am on Debian.

> If you have already made some commits on the 'detached head' then use
> the 'git branch' command, or 'git checkout -b' to create a branch name
> for your new commits (check the manual). Having named the new commits,
> you can get back to link the bits together. You can use 'cherry-pick' to
> pick of individual commits from that new branch onto the new
> destination, or use rebase if there is a series.

The fact is that I fetched a whole rep into a detached head state named tem=
p, but this is not a git branch.
So I am stuck trying to delete this whole rep.
My history is splitted by two by the rep in detached head state.

Thanks for your response.

Alex


[0] https://git-scm.com/community


