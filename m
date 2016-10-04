Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19EE61F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 08:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbcJDIwW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 04:52:22 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32942 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcJDIwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 04:52:21 -0400
Received: by mail-lf0-f50.google.com with SMTP id t81so108660701lfe.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zono3iYuw8ZN6oVJiGUcXcsAtym6XnLB0dNOayZZ1GU=;
        b=AHs0xrUWKpFLxcaOxRrKmj0U2HjWF3oprJVV80M/0bYCcck0rM8spQt4BwhlFmRuLP
         FtDkQnBNS5lo+iwc00SVBiyiznXHxZjdXItWsXSCyqDmQPSjRZk8Bs/+slo2p89+mqiS
         Tbj0vtWoN78420RC0PH+eYWHTVVPaYudc/scm0vkkSTQGz8GrEpghgPaGAMTrhLRgKem
         rtC28INdhKt7+HZEBi764iRPh5CeMxUPlLVDWq3R07lTrb/cdEnzML7uxn+4LDuLRnIO
         BOZmNqAODKjUL33YE6p7ugpAVHqVXXN3ue4dwy+5L3cWRrkaLb28SzHLZAxV/MTGG7GA
         Pu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zono3iYuw8ZN6oVJiGUcXcsAtym6XnLB0dNOayZZ1GU=;
        b=UGAGWJLGIbnpj4SBqEZXCbMfXLQjsmkntRs8J7WgSQvJJouoI4G3vAxa/RGCZF47s+
         c69nmExvuKqKLpyX8bI93ZdCtkrFiHY6FH36oVE9a9DWxzwoxgEkQlzoCjzyAmOWDrxs
         FBRyK+INoytIYPUKIbXcawlBD/IjfmaLOkAcHsco11EDm9JOSBLA5hWv2AUvXAd6eNmi
         n7m2/h91aAtfn63kvTq+whcy5o6X59RBs6Pyju4SAm2Z91Uu9HjHea1I08ljip13C/JS
         ZlxIgmrh6nfzVkC+//bGqv+EhSIqpYT65tAtWEP+hdMaMyOKEqIAhlZmYJ5rNk1TsIXU
         /DJQ==
X-Gm-Message-State: AA6/9RlbK5oMiRbk2tkrjZKZld7IqUchY0sDeG0Htx/T3z+6Ck2igfjNNMi5eBp1QyOklQ==
X-Received: by 10.25.33.195 with SMTP id h186mr984767lfh.102.1475571139784;
        Tue, 04 Oct 2016 01:52:19 -0700 (PDT)
Received: from [192.168.20.21] ([89.113.128.32])
        by smtp.gmail.com with ESMTPSA id h78sm495148ljh.45.2016.10.04.01.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 01:52:19 -0700 (PDT)
From:   Andrey Rybak <rybak.a.v@gmail.com>
To:     Sandro Santilli <strk@kbt.io>
Cc:     git@vger.kernel.org
Subject: Re: broken post-via-gmane link from https://git-scm.com/community
References: <20161004081157.GB17002@localhost>
Message-ID: <36c73304-aceb-7c51-2788-5ba4cdbc862f@gmail.com>
Date:   Tue, 4 Oct 2016 11:52:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161004081157.GB17002@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 04.10.2016 11:11, Sandro Santilli wrote:
> The "post via gmane" link on https://git-scm.com/community points
> to an unexistent server 'post.gmane.org':
> http://post.gmane.org/post.php?group=gmane.comp.version-control.git
It would probably be better to address this on git-scm.com
github page, where the source for the site is hosted:
https://github.com/git/git-scm.com/issues

