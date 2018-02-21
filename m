Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE251F576
	for <e@80x24.org>; Wed, 21 Feb 2018 08:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBUIdl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 03:33:41 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:42355 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeBUIdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 03:33:39 -0500
Received: by mail-wr0-f175.google.com with SMTP id k9so1998419wre.9
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=om3V6sd3SCSXbfDq+ZUs/Y0WyUMbJwao1cLNIUxKOnI=;
        b=JC2jGw//+xkaOX3kikeLwr1+IPsvcdxSqoiaKrkh3zU44f7VEAXdF2IQbuedHPwcOK
         pSS6vRx4/qsUoQhaRBse3wGeLMeNXUV0/8ZKFJwNBKHA1a4PCLe5fFwEZQ3y0tEseohW
         GkvUY29grwwO/4RdKfteBPJ/PZd9kD0wbdePVBtL2c8HehVQBIiW4jnTONyuxJVVRsN4
         4RmynlelXuIpN6kgmMGe9ukfLx+6rlwm64k75h5ytpz8QwxpqT7aUVIiXbA2/BzUPWOI
         zk9h+3+Q+F+wefPNMbut+71iTI21G3WwCXhJ5KKmH+ta/7ZD8pF+syNQhhWSk91yeunh
         DzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=om3V6sd3SCSXbfDq+ZUs/Y0WyUMbJwao1cLNIUxKOnI=;
        b=sE/e8THtHeC9rdHVJ5p1CCG6yJa5dTJ4mxIEWlrm02qvAz9mXpLKfZdXC5/fGusX7U
         39gIEM5EQSnlTL1pg+ooV+lPdkZQkibMrcUGL/sa0kDAl3hsVhFCnoiC5+8ygYXQn1ow
         BYlCn5Dlmqe0iHOBLk27QVex85Kv0eORI9eavCJvmjcbDNifE6iOm8UYUZI+MYlcDns1
         xEvL3IpyWSYq0kyk2u9CIw53KaXsN3vzHxN1Poixa1tdFaI17DHrl7S9PagUxI9273Gu
         RM4IGCHf2cv1+IX9NQ/aXlocKv7vQ+gO1WSL0FI22UYBBpkqebhZWMkYbdThZLkaYBsc
         cInQ==
X-Gm-Message-State: APf1xPB95aH20O82CFy560suj/N5LIL5x8HK3yxG4dWGWsRdO+iQQTby
        AdXpQyYWIOY5k2FMJS6sM94iOA==
X-Google-Smtp-Source: AH8x224o60pWxPqLq6Layye3ESN+t79uKyNjdqK63J/oyw5PW1Yk8bXI5do5Klw9c5YGinAVr9I3yg==
X-Received: by 10.80.206.69 with SMTP id k5mr3795386edj.153.1519202017776;
        Wed, 21 Feb 2018 00:33:37 -0800 (PST)
Received: from [173.194.76.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id r7sm22151524edc.23.2018.02.21.00.33.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 00:33:37 -0800 (PST)
To:     git@vger.kernel.org
From:   Basin Ilya <basinilya@gmail.com>
Subject: test bare repository for unit tests
Message-ID: <b8afa3d7-dc65-1abf-062a-a503f0c0f38d@gmail.com>
Date:   Wed, 21 Feb 2018 11:33:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
I want to the test-repo-git under https://github.com/apache/maven-wagon/tree/master/wagon-providers/wagon-scm/src/test/resources/
just like test-repo-cvs and test-repo-svn

Which configuation options would suit that?
I think core.compression 0 for human readable diffs.
also, I need to force loose, gc after each push.
