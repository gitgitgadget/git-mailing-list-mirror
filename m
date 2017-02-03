Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0337A1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbdBCENS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:13:18 -0500
Received: from gourmet.spamgourmet.com ([216.75.62.102]:57654 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752238AbdBCENS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2017 23:13:18 -0500
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
        (envelope-from <bs.x.ttp@recursor.net>)
        id 1cZVFN-00063q-CA
        for git@vger.kernel.org; Fri, 03 Feb 2017 04:13:17 +0000
Received: from mout.gmx.net ([212.227.17.22])
        by gourmet7.spamgourmet.com with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <bs.x.ttp@recursor.net>)
        id 1cZVFM-00063Q-Tt
        for ; Fri, 03 Feb 2017 04:13:17 +0000
Received: from OC-7878-34850 ([173.234.39.187]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LsTjw-1cT9Y733CC-0122vv for
 <>; Fri, 03 Feb 2017 05:13:12
 +0100
Date:   Fri, 3 Feb 2017 05:13:09 +0100
From:   bs.x.ttp@recursor.net
To:     git@vger.kernel.org
Subject: possible bug:  inconsistent CLI behaviour for empty user.name
Message-Id: <20170203051309.a737846dd26a6ed8df1e4112@gmx.de>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:idGN+WYcOLLtUsH2J9mtpwV7nJJD8Ypm+bFTuNQ6zoYsgfevh2F
 KO3upU82KOxDSyGxhp/ckPXpVsUmJbaKsRHeT3p06cKc5L34Gu8q0zphvDWy8w/EyIwTQE0
 yPj5N6W60yGZNOQ48yiCHWI0UUGfh60SFM4tpxelD5BUftCsnob6fI4WmAOMRIempEnK0zG
 rd8vx7ThOqbMBbEUTQXJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fzqPe2DAZbI=:qFEnP51Roj1H0zOxK/0ZKY
 KJ10K3P0w3XgnD5atcDXG/1jRXlYneTIA7Bi+H/B/7Q9eTfJ6bi0L2u1bcu6WIDQus9ChNGrQ
 5doL1imvDiun7lg/tF1o6/q+TEGn+gvNbDTHnNdTimImR2C/vGmFVSPGUQrBGUgVpsu73UaZY
 CkEOyo2BAk8vUOWHxo8hHrkdEXrbJaMudK5TsoQWBoOzbG/MWxRtrHrsqJ74B3r1phRyzJoe+
 oYIZCIvfbg6LnUk3jcU6RgF1/EIkcOJ18ckfOyYIGV6RI5Ommq5Vw6LJtzVtITP4dA02q0z/M
 rUEfYSVl7Xe6kTaN2jetxaTS3EzbIxM6/vUv02HZML3bMHDno02gCRAJ9A7ucIWZltF5NsAPu
 OGwn/YcJ0HYYtpseI4MPv8eYoLTT9NbvaguQKDxcTAyHVVPk4p0sNijslimsePqbo6WTLenO5
 E5oq8tMtmHfV86XyUrAd3c1HdOV+xBUSda8T9T11jgNyhvF97DfUQAKq0PZZJqdyQ6zSXvp74
 64+9QxEQ9vr5jairfxw/klBYufavwFuaE94EAPuJ5wPyYSIYqCUIup1ynQ1/3XQDXlJD0G+ct
 M11MQ0JZeORdV31wFYzcNR6rGYUYCE23omPw15jbBwJmHV7MZWf39YRwslk2DiogzsxDcLryI
 S3VNQAORGgWNY+PgRzkVPU4IlZlolFavX9Z88ZzjpRF4QgXnaWHB0lsASAIsSsJJwmQmoZBKX
 7aij2SmnuPPZ8CmyukhFitEtMIVORS39HXiiNVa8E4Sek1KtMWgQMAJ2M9pdFYstcp/nwlpRk
 UDDTi81nw/6k/fD8/V/idOG7cCJSgb5hDODvX0QiREtsk6Egew3fbB1DeAY8MaV5mIDCDbALN
 phefIcifdOToOItXEIFK2UoG6JR40Eq4AExUrakxq8HPh1BClPgvcmlltQqJJSL1F/8zhe2Xg
 Dq7INjWSEeuLmnDLmEzXOAI5SgRyzsddOPEXNTLdFARwmN8Q9pxOt3ORGkMhvSMYYhCDnLjeW
 B7VTot2aSYLuD2MRMkjXEuUhCxHSPMnHqMtxXyzq9hB1GziqWZYWGsrfHEDN0sLRCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The problem is that GIT accepts a user.name of " " for some operations (for example when doing a simple "git commit"), but does require a "non-empty" user.name for others (like git commit --amend and git rebase). In case of the latter commands GIT fails with the message "fatal: empty ident name (for <email@address>) not allowed".

As people tend to do simple commits first, before amending or rebasing something, they may have to change their name after some dozen of commits which doesn't look nice.

This is certainly not a big issue, but it turns out to be quite annoying and I've already rewritten the history of a GIT repository once because of it, so that all my commits had the same author.

Proposed solution: GIT's requirements for user.name should not depend on the operation. Either user.name should be enforced to be non-empty everywhere or an empty user.name should be accepted everywhere. Perhaps filling out one of user.name and user.email could be sufficient.





