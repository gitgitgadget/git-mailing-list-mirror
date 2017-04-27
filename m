Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5DD207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 01:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbdD0BVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 21:21:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33738 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdD0BVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 21:21:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id c198so4356551pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lmQNtgecfEAPOlXsaMLrp+n7b9fAC0BNFPtBzpuY0dE=;
        b=mU4e07rDxS37bcGIj2YloSKIGpRuCA5p/Hh7Dvaswj8IqZ01PUXMX6W9aFGj3W+OWV
         151vNl1a0sBax+3P/eL7qN2Bem/K9IBSX2EVHw/xOErDgF4rHG9ulg4wt1OhDAF0WjJp
         RFH6A88qQ/GAD/7aOD6FBjEuda6XDeS/k7M8+QbhzmSc+8up8u9n50Iu5ERl+PTm/1Am
         3GFLo6E+BWd6tbxy1lHUdpL6ppDlmbkGK5NcecqaiV4DzSDlSKt5b40gGViHU30p2biD
         asGg8GSPLUWJx8VzJwqDxrfw1kf6KbffZcVgOI85rGdz6oYNqNOLN/viiaTU3vbAAGsW
         uXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lmQNtgecfEAPOlXsaMLrp+n7b9fAC0BNFPtBzpuY0dE=;
        b=rRvceNmcuu1ItVBRU0nwyruHInGYd2BF63NPL39tWM6D5jLIBnplSi427Wj55vDnMr
         ZAbX7qfV1opJS38GmSyxXMiV3W5bLNMaqK3gpxfeg/sG3p2sSbjrOI5Y5G0b2NOrefqe
         9O6WtujpXbqv8aQmgLEoMLRIQmIfyBKtfrT6qzQR6uqwFoh5S4cUhSFrlohwqrc7WRrk
         yDhBc/wvyt/NMQ8QqP3XdSaBSeQk8TFntEN3lsocjhjt8w3obI7eTrgjIUcfhDd5OvJB
         0F+h7mJ97cQsO7WwLm811LRqrE0sLk641qaWibus3UCKeyewz5+Cre2IF4HttRpWOOV9
         ZPnQ==
X-Gm-Message-State: AN3rC/4tO+WW2L8o69rSCuTFN50cRCSsFDAminInb0M+E0TTcKzktck/
        yQqeVT1TetHt2w==
X-Received: by 10.84.132.33 with SMTP id 30mr3726858ple.46.1493256061934;
        Wed, 26 Apr 2017 18:21:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id n126sm808098pgn.32.2017.04.26.18.21.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 18:21:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 3/4] travis-ci: check AsciiDoc/AsciiDoctor stderr output
References: <20170426191545.27552-1-larsxschneider@gmail.com>
        <20170426191545.27552-4-larsxschneider@gmail.com>
Date:   Wed, 26 Apr 2017 18:21:00 -0700
In-Reply-To: <20170426191545.27552-4-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 26 Apr 2017 21:15:44 +0200")
Message-ID: <xmqqshkuprwj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Ensure that nothing is written to stderr during a documentation build.

I guess we'll know if any output to stderr is an error, or if there
are some informational output that would trigger failure from this
change soon enough.  Will queue.

Thanks.
