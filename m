Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DF71F404
	for <e@80x24.org>; Mon,  5 Mar 2018 23:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeCEXPs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 18:15:48 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:38119 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbeCEXPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 18:15:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 4D324100017
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:08:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([217.11.57.120])
        by localhost (sal.netzguerilla.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b172nsZu1ZWM for <git@vger.kernel.org>;
        Tue,  6 Mar 2018 00:08:08 +0100 (CET)
Received: from [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8] (p200300DDFF0C7C01FDB4C1527C0053F8.dip0.t-ipconnect.de [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id D85EC100012
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520291287;
        bh=N4JYehAIR9aBTbv2Tf7Wmsl/I8oDpKL7hy4Onj9X/jI=;
        h=To:From:Subject:Date:From;
        b=Hx30b7MI6+fDGnsypF9ETfK3ZkHxYlrStOG67qeSI5HFLUBvcuhQZQLkYUGLDuq/h
         Oa7/5ZN1/ErDXN8nry/x00EmoHqLatGOASWcRB1wkjVfFyQy7TlN1QuSxcuE5Fmy7n
         /mec86SGJT+qXLkIHWS7VDU0y1FE2vJGD7DOPS/l4rmT6bMmFCpwF0mNdLLKk7YpJw
         9I/8s2ZCrTPRa7QH/TwUA9No3BIogOrGMjcqKaj7VWGKmM/QHcZP27oqdLKMeSdf0a
         WsaF6n6ruqwo8JtIR4RzqIg6wBJWDkiYQqOZ5S4BeKGRCnp1wgL2IpYRRakueCEkBl
         An9gBFd3UovdA==
To:     git@vger.kernel.org
From:   kalle <kalle@projektwerkstatt.de>
Subject: user-manual: patch proposals and questions
Message-ID: <1dff7be2-6406-7727-67ad-3d045b7744ac@projektwerkstatt.de>
Date:   Tue, 6 Mar 2018 00:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patches are attached.
Further some questions:

-see the explanations of the branch command, ca. line 280: wouldn't it
be better to use other words than 'references'?
-sentence "it shows all commits reachable from the parent commit": it
seems wrong to me. The last commit is also shown.
- chapter "Browsing revisions": it seems counterintuitive to me to have
two different logics for the meaning of "branch1..branch2" and
"branch1...branch2", according to whether it's the argument of `git log'
or `git diff'
-section "Check whether two branches point at the same history": 'git
diff origin..master' -> shouldn't it be rather 'git diff
branch1..branch2'? … or rewrite the example with branch1=origin and
branch2=master.

greetings,
kalle
