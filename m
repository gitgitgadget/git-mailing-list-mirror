Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BEDC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 15:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiEQP2o convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 17 May 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiEQP2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 11:28:42 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383A2F035
        for <git@vger.kernel.org>; Tue, 17 May 2022 08:28:41 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24HFSZX6083139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 May 2022 11:28:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com> <220517.86y1z05gja.gmgdl@evledraar.gmail.com>
In-Reply-To: <220517.86y1z05gja.gmgdl@evledraar.gmail.com>
Subject: RE: [PATCH v4 0/7] scalar: implement the subcommand "diagnose"
Date:   Tue, 17 May 2022 11:28:29 -0400
Organization: Nexbridge Inc.
Message-ID: <00f201d86a02$c6399150$52acb3f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKQWb69+l7J8EAL2VRwkE+mUiRXFgGWHZmgApUWXp2rkfgDkA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 17, 2022 11:03 AM, Ævar Arnfjörð Bjarmason wrote:
>On Tue, May 10 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> Over the course of the years, we developed a sub-command that gathers
>> diagnostic data into a .zip file that can then be attached to bug reports.
>> This sub-command turned out to be very useful in helping Scalar
>> developers identify and fix issues.
>
>I don't mind this as some intermediate step, but re the context of the plan for
>scalar "eventually going away" (discussed in previous threads) I wonder why
>(especially re the earlier thread upthread at [1]) this isn't being added to "git
>bugreport".
>
>Is the plan to integrate this into "git bugreport" eventually?
>
>1.
>https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202062213030.347@tvgsbejvaqbjf.
>bet/

Could this also not be useful in fsck, as --diagnose? That's the go-to command when there are issues for many users.
--Randall

