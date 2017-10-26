Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3434D202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbdJZWS3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 18:18:29 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:46392 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdJZWS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 18:18:28 -0400
Received: by mail-wr0-f179.google.com with SMTP id l1so4567887wrc.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TfsFJoVC+c0CGB2ni2wBDK9N0OcUuYsLurjoThFkmps=;
        b=dUtVBVhhkg9GXamYkYTYrpvjvAzWoUijVfhD/TwFj8OtkXL6IlbE4QVEnE4Okmvq1E
         rWOq714KLoZdGeXMQG6FG5JQEfBPVnut2VsAkLR8FXsGQULnoqFX+6BHoOlbGvJOMEDj
         JRC5i4rBYYul5jZKzXZx1HeVxQZUeleIJtaT+4nQRMkfXi2S+ixo2HES4l7+0TEsVe7/
         eEtGR9CuJAHKuD1IYznQQMwobbYzEwoXhKOMFjsLpWgPE37uWGG3Lq35n2gryMGAjYPk
         Qk1w6QMc6H41vPjm3K+Y0i6SFS6l3G720sZoonGDXaZioDzhjTTh/4NDkF1NRImF5sBT
         a3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TfsFJoVC+c0CGB2ni2wBDK9N0OcUuYsLurjoThFkmps=;
        b=KFvHiw5xtXPqNgZXIgDZ89UHW6J/GNUPoU9N65XfTkAM1rxwDJW0jPSdOFaz8OdDWD
         mjvxdFwDKO2/uIFEUzZVbpafyK2D9dVWaceQ+R3vI4b62lm7rp3sP+LMaWuvDnPzGsZV
         IIl2UN9U0rrUrPBiN+upoYp7U8PsNnxojPo66ertCzscwAbOpm+twKzkMQd+hgLTruJs
         NEfufgMFjz9/YgnBf3CO0WgWF3hdzUb7Vh5nSOgifFJQd+FeqVz0pDvZ78qRUc9fKI7p
         iWeZ8O4dYxU6h76WZ27zotNTTkK9pT0rM5N2ZKYYU6d4EkM32aZEiZOshHswv5KySnuy
         UDkQ==
X-Gm-Message-State: AMCzsaWm/ZxN9v1PPz8Mf7wmCLKt6lAY2NfK7/wyWVkOJKqd5xlUk+nQ
        Nd9YbgRmMhYk9r7IMN1bUjb3nrOqSw8=
X-Google-Smtp-Source: ABhQp+SSjmmqJxjEMmSvlRSbrBubD2jSWJGToJH9W5BvbyYot+FzpNtPKVWvIUw8rinWqssgNWwcYQ==
X-Received: by 10.223.190.14 with SMTP id n14mr7137478wrh.46.1509056306945;
        Thu, 26 Oct 2017 15:18:26 -0700 (PDT)
Received: from [192.168.1.214] (42.4.7.51.dyn.plus.net. [51.7.4.42])
        by smtp.gmail.com with ESMTPSA id o197sm568145wmg.3.2017.10.26.15.18.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 15:18:26 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jonny Grant <jg@jguk.org>
Subject: gitk --version and --help
Message-ID: <e24428eb-ec48-6252-e58d-80f6bd80a78d@jguk.org>
Date:   Thu, 26 Oct 2017 23:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would be useful if these missing options could be added.

Was just checking the version using regular git when I noticed.

$ git --version
git version 2.7.4

I'm not a member of the list, so please cc me in any replies.

Cheers, Jonny
