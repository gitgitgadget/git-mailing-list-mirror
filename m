Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978581F404
	for <e@80x24.org>; Mon,  5 Mar 2018 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeCEXPq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 18:15:46 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:56105 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCEXPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 18:15:45 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Mar 2018 18:15:44 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id C704A10001A
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:10:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([217.11.57.120])
        by localhost (sal.netzguerilla.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0x49TWDeKnP2 for <git@vger.kernel.org>;
        Tue,  6 Mar 2018 00:10:01 +0100 (CET)
Received: from [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8] (p200300DDFF0C7C01FDB4C1527C0053F8.dip0.t-ipconnect.de [IPv6:2003:dd:ff0c:7c01:fdb4:c152:7c00:53f8])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 53E1F100012
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 00:10:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520291401;
        bh=E2zFPgaZlQr5s41k9wV9OzMdIYA6b095OEgju6B3A9I=;
        h=To:From:Subject:Date:From;
        b=IDpHHHO0uDft9Pt0Md8pbf/QdAGze+33ebuDkwPtVFXUslkg0wA1QJeoCIQStJ0yS
         aAQKF/AA/qCfYwOqHe29tcr49LcWAmM+AlwI5DIE4KHO118elktkoirfJl4hQesFFi
         w14w5WB8FiZpBXQig2UZbQ0OjlSaYVoVLaN1YFeYVCgHeM5jlsTCkOyvtRayI7Wu5d
         5hACOpdZuNEDBBzBunXfbuguKSDpOP9+zaLTYfPyfJDcC+zAm3sesUhgI35rARjBO7
         +IVgzVYc0hcttCs86epOhOiUa0oozATI2/QlqNtAMTT4x9dYOR4/nFsNdY5bdMcSjd
         Xnz7NTJbAuWwQ==
To:     git@vger.kernel.org
From:   kalle <kalle@projektwerkstatt.de>
Subject: git help clone: questions
Message-ID: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
Date:   Tue, 6 Mar 2018 00:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-In the explanation of the option --reference: shouldn't there be
written '<repository>' instead of  'reference repository'?

greetings,
kalle
