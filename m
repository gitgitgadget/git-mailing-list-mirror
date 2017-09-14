Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783B420281
	for <e@80x24.org>; Thu, 14 Sep 2017 08:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdINIJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 04:09:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56372 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdINIJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 04:09:33 -0400
Received: from UltraSam.fritz.box ([178.11.154.32]) by
 mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MAihL-1dh5bE1JSV-00BqLS; Thu, 14 Sep 2017 10:09:31 +0200
Subject: Re: merge-base not working as expected when base is ahead
To:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Matthias Lischka <matthias.lischka@fsw.at>
References: <c76e76a4ef11480da9995b0bec5a70e1@SFSWW2K12EX02.intern.fsw.at>
 <e697e5f0da0845ee92ffdb88a4fa48d9@SFSWW2K12EX02.intern.fsw.at>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
Date:   Thu, 14 Sep 2017 10:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <e697e5f0da0845ee92ffdb88a4fa48d9@SFSWW2K12EX02.intern.fsw.at>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IYeiD8RemvdtoSCMkl2xJmoM5eOmwBmry8S3y8MXDkmsx/ei8nU
 mXgDi+kCTYSJtNx9lmio36Cd/Ro12B4wN8+S2DDSdSpnYkgh+PRsM3d0UqglBtuiSp0D3JA
 fCXxHtdsyTMtR3hlRpvv0Eh8JMqB54Vbs9Ps/TUSl4n4qdYqWdvKkARruqtEsLaUBQV5dcJ
 +29Qy+IS88OoGOMB4+vyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tU/QI3fyn8g=:+5catfKDH67pIfjN9tZ46F
 AS0pOSXmLAfthIMAMn39WZcRnDuEcSs+wjYc6FSy0IkVp5bGTMiBPpxC6xhx3GXhr56DCMkbZ
 vby9h6a74TL4757t+Pzt8WjlryuzZsmmpH9DDFZaCJo4gPKYYUfqww1jd4VW/6dT/PBXlss0l
 Sm8KNEShojm8rF/5KVQ4SyNlM2fg2hQSu58prLb8R7v2zBLEpj6qEgrnGf1ys71Tne9sFzhLF
 iwpQ2zmTIVYKLaPn55jll9Jif9D5GF0ERnHQK/VIJVP+ToOgmprgp73K0wLnG/5z0QIfQHEcJ
 knQmO2qnc0VCno7gymWfAzo8dKREfmWHPw5P4x03smYW8MtAjtLG1tfixALqdN+HE+uwYUxir
 TQyvPRVtaaOUnOaYXfNh2ORZQ+0YY43XaUJz9hf+9qf/yhuk7Gw5t3W4LCGiuZuw4kXb5kq/a
 OLZjQq43bAYwaQD7UWUiBsbr/2IzT4aoH43xpeABvYwmOrNMQSt++Rf0sD2OBvcdBz5LWEKSR
 eMIBUmYr2F4gL7OWM1U6EUK1ldxjoTaDW3POVQO6UqmwTaJ8foxa8UUr5VLXlsfWdnK/Fi4qz
 hOssYhKHsrOktyK5g8KuhImcCueEctxZkbRxRI8YPWQpOaypLwAfDdtwQsjvL7bwJvStykALj
 Ewk+WAKyldeT6M/pxkQ4fqvQZlCuz+pPXpY/jF9hOlc+mOScRfuLg/pJpqJQ6U9G98GieU0b9
 eB9ztY7db+d8AzeDtu5IHtVayo99xJ3xf++fvCInal4TdcGHvANebaCm7Mc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ekelhart Jakob venit, vidit, dixit 13.09.2017 17:07:
> Dear Git,
> 
> git merge-base --fork-point "master" not working if master is already newer then my current branch.
> Very oddly it seems to work whenever you had the expected commit checked out previously - what made it very tricky to detect this problem.
> 
> Example:
>  - Clone "https://github.com/jekelhart/GitInfoTry"
>  - Switch to branch "v1.0.0"
>  - git merge-base --fork-point "master"
>    - or: git merge-base --fork-point "origin/master" 
>  - expected result: fork point "fbb1db34c6317a6e8b319c1ec261e97ca1672c22"
>  - but result is empty
> 
> In the repo where we created this example tree in the first place the command returned the expected fork point. If you clone it new and fresh it does not return any result anymore.
> 
> Works, however, on branch "v2.0.0". Assumption: because "master" is older.(?)
> I think it works locally because the command uses the reflog in addition(!), however, it should work without the local reflog as well. (since the history was not modified in any way)

The documentation lies, unfortunately. It claims that in fork-mode, "git
merge-base" "also" looks at the reflog. In fact, the code explicitely
*discards* any merge bases that it finds but which are not in the
reflog. (The merge base that you find for v2.0.0 is in the reflog
because it's the checked out HEAD.)

Removing the corresponding check gives the merge base for v1.0.0 that
you expect, and git still passes all tests. But I'll look at the history
of these lines before I submit a patch.

Michael

