Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89783202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 10:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbdCGKwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 05:52:54 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:50224 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754861AbdCGKwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 05:52:40 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 1D5CEC547;
        Tue,  7 Mar 2017 08:16:11 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 1757C1003FF;
        Tue,  7 Mar 2017 08:16:11 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id ED5D4125EAE;
        Tue,  7 Mar 2017 08:16:10 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
Date:   Tue, 07 Mar 2017 08:16:10 +0100
In-Reply-To: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
        (Stefan Beller's message of "Mon, 6 Mar 2017 11:59:24 -0800")
Message-ID: <vpqpohtpnet.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> What is the difference between signed commits and tags?
> (Not from a technical perspective, but for the end user)

In addition to what the others already said:

If you use GitHub, then in the web interface you get a "Verified" stamp
for each signed commits:
https://help.github.com/articles/signing-commits-using-gpg/

It's not a Git feature but a GitHub one, but given the popularity of
GitHub, this probably led some users to believe that signed commits are
more convenient than signed tags.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
