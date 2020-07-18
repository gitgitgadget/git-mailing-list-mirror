Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E467CC433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F092073A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="YX3DhHx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGRRVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:21:18 -0400
Received: from mail.pdinc.us ([67.90.184.27]:39148 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgGRRVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 13:21:18 -0400
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 06IHLHWn021978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 13:21:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 06IHLHWn021978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1595092877; bh=4iLNcHPw2Ua2JnvjYa2ngfmwGygcpkW69Zq2MUSdJp0=;
        h=From:To:Subject:Date:From;
        b=YX3DhHx5czWvTDisPm/BGo8tGnJJ2fpIIYMU2ZEzbhkiwHMr/VSglEI7L7agDW7so
         RQKo5dwibrRnw4laYSVnyLEZvPKPDc6VXMF6v1Ktnn3ioe/i5v1wmvqJjEGVo/njVo
         DgABCS4In1q8xP5mOfbLCbdnYrxcvpjFhhBZZcFqEm/CUFPG4MaQi7tSQ1F32IsoW7
         HGhpFgKufkWMkRyHdn6jk501f1POZYozgLxsokEsF0vENvtwccKX48LeJdkv+lvYT4
         Yt0KYzzjrfZvwzgniJRVbKGjBgINA8C9AiE+P7HtoASXgvhRvfx1DWsUg57VJV/cJA
         CSviHf0P222Uw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: [off topic] Git hook and integration for JIRA
Date:   Sat, 18 Jul 2020 13:21:27 -0400
Message-ID: <015101d65d27$dee4e9a0$9caebce0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdZdJ6J7n8rRlrH3QEazCXLOdes6LQ==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On our open source / public projects JIRA [1] instance (read as 0$ cost) =
we would like to have our git commits show up.

If we were using Atlassian Bitbucket, this would be a seamless =
integration. But Bitbucket is not what we are looking for. It is free =
for our open source projects, but is just one more server to maintain.

An non-ideal implementation [2] looks like a comment. While the native =
implementation [4] shows up in a nicely organized section of the issue =
page.

All roads seem to lead to the non FOSS BigBrassBand [5] git integration =
plugin. I do not see a non-profit license and it will not fit the (lack =
of) budget.

Thoughts?

On a side note, we will also like to support [3] github.com pull =
requests in some form or fashion.

1: https://www.pdinc.us/public/jira/
2: =
https://issues.apache.org/jira/browse/WW-5069?focusedCommentId=3D17092794=
&page=3Dcom.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#=
comment-17092794
3: https://hibernate.atlassian.net/browse/HHH-13690
4: https://www.atlassian.com/software/jira/bitbucket-integration
5: =
https://marketplace.atlassian.com/apps/4984/git-integration-for-jira?host=
ing=3Dserver&tab=3Doverview


