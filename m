Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A027AC77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 15:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjEEP0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjEEPZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 11:25:50 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D331CFC3
        for <git@vger.kernel.org>; Fri,  5 May 2023 08:24:21 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([192.139.37.247])
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 345FMbdU3992130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 15:22:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Shafiq Jetha'" <shafiq.jetha@benevity.com>, <git@vger.kernel.org>
References: <MWHPR01MB2318693B28B740F75D90E1DCF3729@MWHPR01MB2318.prod.exchangelabs.com>
In-Reply-To: <MWHPR01MB2318693B28B740F75D90E1DCF3729@MWHPR01MB2318.prod.exchangelabs.com>
Subject: RE: Suggestion to provide a way for screenshots to be added to commit messages
Date:   Fri, 5 May 2023 11:23:27 -0400
Organization: Nexbridge Inc.
Message-ID: <001a01d97f65$96b77450$c4265cf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEepFG5ITZavs1PGpFwF/JHPBLqmrDBgbOg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, May 5, 2023 10:51 AM, Shafiq Jetha wrote:
>It would be nice if we could add images directly to commit messages via
git. The
>reason for this is so that we can view the history and see real examples of
important
>UI elements. Usually during a PR we provide screenshots so that people can
see how
>the change affects UI elements, or to show the output of specific commands
that
>might show specific data in specific scenarios. I can also see this being
useful for
>people that work on projects where code produces some sort of visual output
where
>words cannot accurately describe the changes (a picture is worth 1000
words, right?).
>
>It would be great if this sort of an integration could be considered, and I
know that
>this would mean updating the clients, specifically the command-based
clients, to
>interpret these images and provide a way to render them or display a link
to them in
>some fashion. There's also the question of whether to embed the images
directly in
>the commit message or to link out to them and download them as artefacts of
the
>repo. And then there is the everlasting question of whether or not a git
repo should
>contain build artefacts at all (since it can be argued that an image is a
build
>artefact).
>Lots of things to consider but I hope that I have at least started a
dialogue for this to
>be explored further.

My team has a similar use case. We adopted a few ticket systems - depending
on our git upstream - including Jira and GitHub Issues. Both provide the
capability to upload images and have discussions during the PR referencing
the original ticket via the commit content. The commit comment simply needs
to reference the issue through the integration provided by the ticket
systems. Something like this might solve your need and is off the shelf.

--Randall

