Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AB91F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 04:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfHOExS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 00:53:18 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21519 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfHOExS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 00:53:18 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 00:53:17 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1565843893; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=RioW3ZlrMCf2pH8WFPWpYJcnZr3/VFUl/RZuoXxgD7gKEauMwS51zd9CvP1FtIqxi1qqbJQ2/rlva9xTFZaLn7c9I0qOckve4aGYddlYivD+v30iay6l10F3gI5ApJ3iCYIntq8j52VhlLjbctDeHqQUzDCG6+NHyX4CgMfQnIE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565843893; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=JoitrnwwXb4tMKe4zsQ9F/59TE1NMZOH+PqJuQVwHRQ=; 
        b=KWCUKEIgKm3pcGsBNscge60HWvFHtMgFIE5K6VN2pSA4q1RAd9Ni2Fx0iv4N0P90Oz1nmR+NaWrM5feXUEEaH3pUZPbCMMXCUR0pm+MUXyoWR9YyrO3t3kmYKN+i7p17jKvs/FUdaDnLZbn/1N9Er+t4OCNrpMbjDVX6Q2OYrtw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=topbug.net;
        spf=pass  smtp.mailfrom=hong@topbug.net;
        dmarc=pass header.from=<hong@topbug.net> header.from=<hong@topbug.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565843893;
        s=zoho; d=topbug.net; i=hong@topbug.net;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=395; bh=JoitrnwwXb4tMKe4zsQ9F/59TE1NMZOH+PqJuQVwHRQ=;
        b=b5TN6KFtjuMQMC9w4ASG+owFDtC5DxCKuTwK7bEWASjmLs79X417H9l4WVuWSFvP
        Tgm5/OVMwH1vlSyQksjL0PdgDh7atZG52CTBUSPe5Z78hWW68EPvPPr78nHJTicUkjP
        LnhvFOngOeWT6JVGSnoS3iPY21JF2L6eet1Q9nTY=
Received: from [192.168.88.149] (69-215-149-151.lightspeed.sntcca.sbcglobal.net [69.215.149.151]) by mx.zohomail.com
        with SMTPS id 1565843890273317.1232780183293; Wed, 14 Aug 2019 21:38:10 -0700 (PDT)
To:     git <git@vger.kernel.org>
From:   Hong Xu <hong@topbug.net>
Subject: Is diff.indentHeuristic still experimental?
Openpgp: preference=signencrypt
Message-ID: <58aafeaa-72b0-25ce-27b6-f8480fe48b5e@topbug.net>
Date:   Wed, 14 Aug 2019 21:38:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I saw that diff.indentHeuristic was enabled by default at
33de7163879ca83be7d6e1583c125f84e1e7c329
<https://git.kernel.org/pub/scm/git/git.git/commit/?id=33de7163879ca83be7d6e1583c125f84e1e7c329>
, but the doc still says it is experimental
<https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffindentHeuristic>.
Am I missing anything?


Best,

Hong

Hong


