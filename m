Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1298207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbcILTvU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:51:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35638 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcILTvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:51:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id a6so15138907wmc.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=uV/AItlahCNABk8LWlN7LdgDNYJzmjexpKiMWhakwak=;
        b=bqI+P6rWTTzqMjkZYNzWR3TpreOBgHfl1/NZwyv3NB/iEEyrIiJ1IZ7NZOv4vKn0Jh
         gi2BQmb76KT603rtqZgr8iStI1vYiBoGxM2Cz839zicMpypBc4rtuWxpxG3TBKWMX7S+
         OtoxU5QLQQMQzaWGUb/O7cqQMA+D8USN5AKSdhNSrU+49fNcHJQkcCkDckntORy5ujC2
         D51e5WXPwx1O/yNf0+uh9x1dwoHjwQysPeGwPc0o44ASs/j4/7aG11CU3c7m6cKcLz9w
         43XQ/gkcgKOf/fUJJS94ARyCekUY/5RpLXO8EEQAcoLaELR8JM9fMe0pCTUh7QGXNoAD
         jCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=uV/AItlahCNABk8LWlN7LdgDNYJzmjexpKiMWhakwak=;
        b=GY+nTCOKAu5P8XDjtWJb7oQ8P2X7pRPFYaOsrDKBsnxMu/5FySErB/N2cog16ljCag
         B3TKV+n9Ox7MAnPmTIZybcgD3tPzgbfay7+TJnQQpFa32DXf4TAp0iPXGM723s1QyCx3
         GJO9Bh4zCHU8nwEBJoBQfS70M1xS6edh7iCsAtFadBomccxMHczSDlp5uOX5wtR1xjJe
         wsDYld5+cLAB90YBhnbJ7Rwzw0XbdoNZq52Mkw+KkmvFeiIKiVrv13wujggq2vFnP9Fi
         SRKc+6x8xMn7UfZzYQR7wkPjjFRjVi5xQa+xhxF5H6e+eAU/78QzeUOhOWinx4GtaI1c
         1Erw==
X-Gm-Message-State: AE9vXwO7wR9n+HZlhocC/Ktx3gOyqSsJN03e3jV3n6jhEjS7sgVfRLkCL8OWZW+LflRl1Q==
X-Received: by 10.28.197.138 with SMTP id v132mr1525449wmf.11.1473709875557;
        Mon, 12 Sep 2016 12:51:15 -0700 (PDT)
Received: from [192.168.1.26] (elj71.neoplus.adsl.tpnet.pl. [83.21.203.71])
        by smtp.googlemail.com with ESMTPSA id uw3sm9005400wjb.21.2016.09.12.12.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 12:51:14 -0700 (PDT)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
Cc:     Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [ANNOUNCE] Git User's Survey 2016
Message-ID: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com>
Date:   Mon, 12 Sep 2016 21:51:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We would like to ask you a few questions about your use of the Git
version control system. This survey is mainly to understand who is
using Git, how and why.

The results will be published to the Git wiki on the GitSurvey2016
page (https://git.wiki.kernel.org/index.php/GitSurvey2016) and
discussed on the git mailing list.


The survey would be open from 12 September to 20 October 2016.


Please devote a few minutes of your time to fill this simple
questionnaire, it will help a lot the git community to understand your
needs, what you like of Git, and of course what you don't like.

The survey can be found here:
  https://tinyurl.com/GitSurvey2016
  https://survs.com/survey/lmo7ed3439

There is also alternate version which does not require cookies,
but it doesn't allow one to go back to response and edit it.
  https://tinyurl.com/GitSurvey2016-anon
  https://survs.com/survey/naeec8kwd8


P.S. At request I can open a separate channel in survey, with a separate
survey URL, so that responses from particular site or organization could
be separated out.

Please send me a email with name of channel, and I will return with
a separate survey URL to use.  Note that the name of the channel would
be visible to others.

P.P.S. Different announcements use different URLs (different channels)
to better track where one got information about this survey.

Thanks in advance for taking time to answer the survey,
-- 
Jakub Narębski
on behalf of
Git Development Community
