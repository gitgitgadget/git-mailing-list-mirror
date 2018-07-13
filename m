Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_ABUSE_REDIR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F82B1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 17:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeGMRPz (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:15:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40556 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeGMRPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:15:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id e13-v6so9595227pff.7
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TpKaiVez928gez6fUR4A9sZ4+WYpnX/iUAsBG+b01h4=;
        b=clv0nKUlqwCkIz4txGoS1Nm0/GN4/ewM9X/BZplzN6Rfo6iCBQaoHSGksl5jTihg4v
         dHpPmMyx7yib/uuMbDWTZzE+gq/Lbpq2e9R4H1THd/LFYoQbQRhuiyjuea7qLmV8KMDs
         3uQHbNPDqGjLPkqnnrXjRUSEM5ecm+m83ZGX/XF8Gb0gX0nxfDnykcvv8rHxcWbwxwRu
         0+NtMMio6dGUc218aNLStK4vcejxGMwPznUdqroSwnYq9hDW2fOCT/w0J4nlfeUOMDnM
         FdT5drtKJpyen0O4IkXEsGidbcBAU+dlImGW4S1ppDPeCt8RR5bckbj+FuAJHZ6ZRgWA
         BLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TpKaiVez928gez6fUR4A9sZ4+WYpnX/iUAsBG+b01h4=;
        b=XqbwPVIARdDzGlNG3Dzr7B8gQUhyufGHnNRdx3AL/LoVgTLajvolCtJMm0GF32fNjK
         xLEIH8zZrJek84xsOi9bd79cPCGDVpdVjVbQkI18b3CSmTuO4H1uXa2Y0rJd2JpTVdgH
         WfwBa4VoS70puaIdqXPVbxEVjR15/RkRyZgcMWBYpt2uVFU7MJGle/eQyADQlz6sHJAP
         UbUmNc9Xygc5Ekww/bS6ikdr4cYg3SMpNAXB6lRHp0y7tbj9S+LoCp9Ea8KUlwUJWaKk
         g+2dcKmPqkZE8qyYrvZDEI6hrHTRFMIUDp+4NPPdCM8H9L7i9c4B8uO2vWvtZ3ggUa1n
         J8LA==
X-Gm-Message-State: AOUpUlE/Z22j8FMXljXPtrkIElCyEzCUvUu5lYJJdPe/vLcWj5k2Lc0H
        rCzQ2Ic+ouq8GsxscJBj8Lk9ActI
X-Google-Smtp-Source: AAOMgpcEg9Hf35W036ng5MFl6+Afh55sNvkYfZ7/ly2JegdRfEGDgyF1p/hrvo4jACV3pl9xppkWkg==
X-Received: by 2002:a63:4f63:: with SMTP id p35-v6mr6862894pgl.167.1531501226980;
        Fri, 13 Jul 2018 10:00:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u185-v6sm31214813pfu.134.2018.07.13.10.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 10:00:26 -0700 (PDT)
Date:   Fri, 13 Jul 2018 10:00:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: Git standup on IRC
Message-ID: <20180713170018.GA139708@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some of us have been informally doing a "git standup" on #git-devel on
irc.freenode.net on IRC every two weeks at 17:00-17:30 UTC.  It's a
way for people to say what they're working on and ask questions.  It
generally goes into a lot less depth than on-list discussions like
https://public-inbox.org/git/CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com/.
Logs are at https://j.mp/gitdevlog --- e.g. the previous one starts at
http://colabti.org/irclogger/irclogger_log/git-devel?date=2018-06-29#l96.

All are welcome to join in, especially including newcomers.

Another way to contribute is to lurk and summarize for the list
(either with an email or by adding to git rev news). :)

Sorry for the late notice (today's is in 1 minutes); I figured late is
better than never.

Thanks,
Jonathan
