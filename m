Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEE120401
	for <e@80x24.org>; Thu, 15 Jun 2017 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdFOQTq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:19:46 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34149 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbdFOQTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:19:43 -0400
Received: by mail-qt0-f179.google.com with SMTP id c10so26808404qtd.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=863+PKJmpbTIr5fCTt7FgAa2juvnGcvHv6IyowuqB2Y=;
        b=A0peHeJ575Y6TE4YpjO9ra9/uB/iIwVjNLxp0At+tVyhO4ALOw078y9OBdqx9Qdyfq
         MBLGiMzwbcL3us0GdkTjPhseI1HMfSAIUupGOTvKGZ/9qUTLrCf/A7RAfvzqk8otwmXZ
         CCrl7DpmUnPwfdtY+P+M6uygIWyzl5AoLiYL8akNBnNWYZgr+t0egG4uIjtJAd7myrEw
         /bwUE7ptMAMFYkTxmbkEqSvQvsbl04VOQJqF/crDh/dnPxPX+CdqCUwVgoMwMoi7CYNN
         A0+KhkGSl5l74mV0f7PtdlXhtm5SCu8xyFJ79dnbsM9y5hco83ucrpEddTgG1m9IhSjI
         FTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=863+PKJmpbTIr5fCTt7FgAa2juvnGcvHv6IyowuqB2Y=;
        b=pLrfJFTADLE4Vyw9YmnGRtyZPCwS92FJSibAVpM26jUrXFBPIiyvM8+yui/6lYY/li
         4dDRTNu6p62SoKFL/m/Eie7i/LPrKblOHb9YKQtrhNG3cCNSeDDWwoYag8Hk4NUoKcFG
         zIczfPY8jqF+kKR/w202RuGw0RT590gut4VKe2IxSQrmtojoJEV4WlkQpl48xBUBAix1
         ggtp3M7NiRfBoVaEHchoCDwCIQUfKptxw4VZrhoRVvQbKaWWMoF6smg47u+ZWL6dC+Cm
         CYffXv83UdnzjK76I8Ji04UIdwnTYfk0abw8qjNqGiLOaq6IhTEjvODhBQ/PeAeSjZMl
         dwrQ==
X-Gm-Message-State: AKS2vOyvGJRX6mfhXL8bejvW/N0reLhMIkYJGZGoI1EZBYSC5tipA9YE
        k9Px0qXA/nUTbn5efGw=
X-Received: by 10.55.168.17 with SMTP id r17mr7790657qke.146.1497543582742;
        Thu, 15 Jun 2017 09:19:42 -0700 (PDT)
Received: from Matthews-MacBook-Pro.local ([2603:3005:b04:ee00:a4fd:f40c:8436:ec27])
        by smtp.gmail.com with ESMTPSA id j54sm391153qtc.59.2017.06.15.09.19.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 09:19:42 -0700 (PDT)
To:     git@vger.kernel.org
From:   Matthew Groth <mgroth49@gmail.com>
Subject: git diff sometimes brings up buggy pager
Message-ID: <3cdbb6a5-55d3-673c-ce31-c3da4d7e17cf@gmail.com>
Date:   Thu, 15 Jun 2017 12:19:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do `git diff` sometimes I get this:


...skipping...
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
...skipping...
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
...skipping...
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~


.... it goes on like this for about 10 times the length. Looks like this 
happens exclusively when I use git diff with a github remote that is at 
the same commit. I will update if I find any other case where this happens.




