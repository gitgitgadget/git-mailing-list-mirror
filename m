Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43377CDB46E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjJKXF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJKXF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:05:26 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6629A4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:05:23 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 88EC324170;
        Wed, 11 Oct 2023 19:05:19 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qqiGV-Y0P-00; Thu, 12 Oct 2023 01:05:19 +0200
Date:   Thu, 12 Oct 2023 01:05:19 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
Message-ID: <ZScqLzGiDPZvLh2k@ugly>
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
 <ZSUR+YdzqNTSB0XC@ugly>
 <ZScQG5QHznMEGzhC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZScQG5QHznMEGzhC@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 02:14:03PM -0700, Josh Steadmon wrote:
>On 2023.10.10 10:57, Oswald Buddenhagen wrote:
>> On Mon, Oct 09, 2023 at 03:21:20PM -0700, Josh Steadmon wrote:
>> > +=== Comparison
>> > +
>> > +[format="csv",options="header",width="33%"]
>> > +|=====
>> > +Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<major-platform-support,Major platform support>>","<<tap-support,TAP support>>","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Runtime- skippable tests>>","<<parallel-execution,Parallel execution>>","<<mock-support,Mock support>>","<<signal-error-handling,Signal & error handling>>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
>> > 
>> the redundancy seems unnecessary; asciidoc should automatically use each
>> target's section title as the xreflabel.
>
>Hmm, this doesn't seem to work for me. It only renders as
>"[anchor-label]".
>
i thought
https://docs.asciidoctor.org/asciidoc/latest/attributes/id/#customize-automatic-xreftext 
is pretty clear about it, though. maybe the actual tooling uses an older 
version of the spec? or is buggy? or the placement of the titles is 
incorrect? or this applies to different links or targets only? or am i 
misreading something? or ...?

regards
