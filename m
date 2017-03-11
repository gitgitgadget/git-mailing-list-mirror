Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEC41FC43
	for <e@80x24.org>; Sat, 11 Mar 2017 02:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbdCKC13 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 10 Mar 2017 21:27:29 -0500
Received: from limerock02.mail.cornell.edu ([128.84.13.242]:34585 "EHLO
        limerock02.mail.cornell.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755488AbdCKC11 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 21:27:27 -0500
X-CornellRouted: This message has been Routed already.
Received: from exchange.cornell.edu (sf-e2013-05.exchange.cornell.edu [10.22.40.52])
        by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v2B2RPLb032332
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 21:27:25 -0500
Received: from sf-e2013-02.exchange.cornell.edu (10.22.40.49) by
 sf-e2013-05.exchange.cornell.edu (10.22.40.52) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3; Fri, 10 Mar 2017 21:27:25 -0500
Received: from mail-qk0-f197.google.com (209.85.220.197) by
 exchange.cornell.edu (10.22.40.49) with Microsoft SMTP Server (TLS) id
 15.0.1210.3 via Frontend Transport; Fri, 10 Mar 2017 21:27:25 -0500
Received: by mail-qk0-f197.google.com with SMTP id c85so205842381qkg.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 18:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=esEb4UtClf6TivzlgXmorv1TK1Kw8I49TmqW6PIOsj4=;
        b=S3x5rCvNUZw0AzexU02n7RG1p+ULSnuW+zg57jmZ5Wo4RLWKwDN8dn24FdBN2Trl9I
         T3VlE+Jccd0YnT/IH+YIRUAwbhKdAUHKa8to0t4EJP4Sqg+kumdRRue2GaP+Be5Qwa8t
         ZRw/bTLj42KnmJ6dByUnyzLN4iMqMS5p+TxxdEtz/N5DC+IdFIUjdrUESFDkLMNs2i2o
         Gd0QI6P3FqxZlzNKlr5F2AmhrglaKz3CyYOgyh5bODnY8aUI0JSWaYNqhqNfQIvvbfjG
         aeEMU9SqgWNt2zPzdPBV9jNaM2po6sbnGJcdE1En5QVbgHNMWpOvYEKJc+DgduPsq4Hl
         nRpg==
X-Gm-Message-State: AMke39l10dfvJs9ommCeLNazwRwYZy/SBoaDUw2JPc/KHsT3/Rr64us8K8StBz8v8e7SBi8HFzSV3tYPqTgg/21BT5GwKwTJR84np6I3RDexfBAb6CSNzme2GdIK1982xlwegHDyhN0O3x3+XUc=
X-Received: by 10.200.35.195 with SMTP id r3mr23430628qtr.282.1489199244985;
        Fri, 10 Mar 2017 18:27:24 -0800 (PST)
X-Received: by 10.200.35.195 with SMTP id r3mr23430620qtr.282.1489199244858;
        Fri, 10 Mar 2017 18:27:24 -0800 (PST)
Received: from dhcp-mcfad-10356.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.gmail.com with ESMTPSA id q15sm7628000qtc.1.2017.03.10.18.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2017 18:27:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC] Move ~/.git-credential-cache to ~/.cache/git
From:   Devin Lehmacher <djl329@cornell.edu>
In-Reply-To: <CAM-tV-9DV=XOVSehEfd2LiWYdubhwV7fC8uRnKqmFT_aTQ1OKg@mail.gmail.com>
Date:   Fri, 10 Mar 2017 21:27:23 -0500
CC:     Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-ID: <3B988055-D8A3-43B7-BF5F-C43479EF7BEB@cornell.edu>
References: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu>
 <20170311002615.GG26789@aiede.mtv.corp.google.com>
 <CAM-tV-9DV=XOVSehEfd2LiWYdubhwV7fC8uRnKqmFT_aTQ1OKg@mail.gmail.com>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
X-Mailer: Apple Mail (2.3259)
Received-SPF: Neutral (sf-e2013-05.exchange.cornell.edu: 209.85.220.197 is
 neither permitted nor denied by domain of djl329@cornell.edu)
X-ORG-HybridRouting: 4a0e73779ab9e0348b3feb80fef7a7c5
X-ORG-RouteOnPrem: False
X-ORG-MsgSource: cmail
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I’m not mistaken magit won’t stop working with the changed location since it will just spawn an new instance of the daemon. The only downside would be it wouldn’t get credentials that were cached in the default socket.

I am going to move forward with git-credential-cache just using the new location at
`~/.cache/git/credential/socket` and submit a patch and then get more feedback on the patch.

Devin Lehmacher
