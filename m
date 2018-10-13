Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B1B1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 12:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeJMUNu (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 16:13:50 -0400
Received: from devianza.investici.org ([198.167.222.108]:27974 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 16:13:50 -0400
Received: from [198.167.222.108] (devianza [198.167.222.108]) (Authenticated sender: najamelan@autistici.org) by localhost (Postfix) with ESMTPSA id 0A97541D;
        Sat, 13 Oct 2018 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1539434209;
        bh=GH344e/ZJo2dapiKpiD0YEidWEtyZpSDmh9zxlu+T0A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=A2NlCh3FhYMuAFaQ1oKXj3FMz46aG4s1JLK9VF5hKAz0FrmYof7evszcNPCcbyyTu
         qTXrpKxWO0gjEGc+xmwG6xMf9xnF5oIow8g6J7oDNktMS2YTCiq6/ictW6nynh5lyq
         AvsiGn1ZD+PCbEe67euD0jMHaqOz+NkMnA6jWoZc=
From:   Naja Melan <najamelan@autistici.org>
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: bug when combined with etckeeper
References: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
 <20181010143427.GA2725@kitenet.net>
Message-ID: <d9324f66-6eca-32a9-433a-8732998b30a2@autistici.org>
Date:   Sat, 13 Oct 2018 12:36:00 +0000
MIME-Version: 1.0
In-Reply-To: <20181010143427.GA2725@kitenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok,

my bad. I had a global pre-commit hook which had a lingering etckeeper command for another repository.

Not quite sure why it only runs when commit has the '-a' option...

Thanks for pointing to the hooks possibility.

Naja Melan
