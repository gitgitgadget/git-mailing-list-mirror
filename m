Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1EC1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501868AbfIXRX3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:23:29 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49775 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407047AbfIXRX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:23:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id r12so1724336pgm.16
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3jxSLsNocJBN3z5xrlXyN5SD5bdtVyPypxluxMwUM7M=;
        b=OKGrfVN6Z5HsR3ud4vLms7ZkThu1TAfZKQ8VnogNosbxVLm0Lh3MigNv5LWgXwY1iy
         uv1dFWfOsv3hrDVQOVzTF/njSKPVzozVw+6O8YdVTOnvhB/2oHYZcDC1u4dh2V6CFHcw
         I9k51hWKvsVuZ1U0lPCf4gaMmIaQ8MfgmIWKYoT0uPPzia91pQzIZwjbJtJY6Lnz1Vpy
         p3Q1r6mRgRPw2aDXrizjLJcpzrc9WndCEjzfGKIis7xufTF2f7wxn2KE3IQ0LmpDvDY/
         KkLr51fc3R7U3DPBEP1hnA9pIR+AA9HXhJIgrKGnY+g6FiZuE6updwNjCp6ZOGZcAgUd
         P1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3jxSLsNocJBN3z5xrlXyN5SD5bdtVyPypxluxMwUM7M=;
        b=k66qs+GLAuRM7sliH5dALexl+GVg2gyv6ZLiYjQcmzoLkVbiiWnmzeUHPOgBNmcr+t
         /UKpySGU2Vh9NHK7yABK1PobwJYeN2TYdUs9IqCTwcct2z1Rm5uElWm96S0k269zTZcq
         bC7+H9lmZEZA7E9Mwes2BjXmpuziikgqXx0JDRgFpBrDNfJVXVwJgk0b1p2+WfOcXiJR
         G3bNp/jyf5g+t5KODh6o4PWwaTk8DQ9M8RM7cySgVK/ewskLt7ae0IAfu9smJz/mS8jU
         4fJ/Z1zA4SRcz3E7/ONKT3rJ1LoBVDOksOafUbDLoiLWfw8b1LVhCpTmFUBNcfgVErPv
         Rm1A==
X-Gm-Message-State: APjAAAVmBMaFZh4qjXSjECl0J6o4Cg8saeNTY7w0yfZwl3W94l76OnYY
        46yHt6rpA2hczbfhHaw40tUrK+MnC5XNNrL8m5XE
X-Google-Smtp-Source: APXvYqzPAOcm3g6hMPMtubNwjs07nDaZYPqjB/n5mjlXwGZDZGnNYB1IHK0vUVleuY7yq0L1YmYbsVTblUJ0on2D7QBZ
X-Received: by 2002:a65:5546:: with SMTP id t6mr4126144pgr.441.1569345807826;
 Tue, 24 Sep 2019 10:23:27 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:23:24 -0700
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
Message-Id: <20190924172324.104795-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190924064454.GA30419@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: [PATCH] add a Code of Conduct document
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, git@sfconservancy.org, stolee@gmail.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com,
        garimasigit@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.

Thanks for starting this. I think Peff has stated better what I would have
said, so to this patch:

Acked-by: Jonathan Tan <jonathantanmy@google.com>
