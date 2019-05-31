Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C744F1F609
	for <e@80x24.org>; Fri, 31 May 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEaOvL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 10:51:11 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42372 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaOvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 10:51:11 -0400
Received: by mail-wr1-f49.google.com with SMTP id l2so6711940wrb.9
        for <git@vger.kernel.org>; Fri, 31 May 2019 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gs9s9FNlCJuk0a92k+VgLSl9YS2MrfJa/p/P/EqHicI=;
        b=p6kmbSmbdGBeKMiaFyCS2/WgDvTvUttKXi0+CaYcfgeLBRDyPJAeO3B+TiS9R4iNJU
         ax7LjNCEOQbawheSwpL23ec8Q/sw49963PzHdOgKVxd747q6tEOHHJVIUnLGoBu9KLFp
         7P5EJjSvbtspfn9Wnsp8A17nB8YX5j/HeyHuJYlrABijKIQg8/LfpoieBY3DtYUWLu3Z
         qpWodNU/N2ST1YN4gIW4yW9esXRUrkaqRwt8iCa42cNfy4JEQeShqYW8iv7Xfh6rKLrS
         8dV3K/m2tmz1kJiy2QEbEeZsFjFMCAj4hQyWGsppS//bZWjzKI7QPxJOMtAmwm4Skijl
         vGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gs9s9FNlCJuk0a92k+VgLSl9YS2MrfJa/p/P/EqHicI=;
        b=XZCKAG2WBTz7TJc3OzoROaDiVPaToZWXtB1b7Bmo8slwN4wlmPf+TbYup7KYGv/I89
         /WIdvJBA6/MsaOn1wkTFQtTMAQXoI5oIh/+uodkrWHSou7KI3ynMIYr5r0YVXuSENlFc
         01WY67Z9jTtlNBRO3zlik80yPaH0VaCduVhhvhDpa89xbxbKt6u0Qh9WFp9XEts1pvAz
         aF0KNJHfVu1ps9tKQs/c9orWNL7vPc3uT35v1wZ+uTO240VVkxuRbswhgQ/w4MY0cFU/
         YywP2VlJrHZkrM5PIYRHun3UWqWM6vyhbMoDpEd1nwlC8gZuNWCGffLNyqNvO0DKAaQJ
         QabA==
X-Gm-Message-State: APjAAAUwPlzEuMhb+Vx26ed24b5bztXJkJbTO7mALpk2Nhjf/71ZEV2t
        uKEeVsssox9a6nxRjyl/GhRct0u+NyI=
X-Google-Smtp-Source: APXvYqyEVy98V92NUZIpUmX0/Ggh7vuPVo81pA+TTdaCpA+jqgiorYot/MFmj+jLA3wAokbVX1lpXw==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr6845704wrr.70.1559314269867;
        Fri, 31 May 2019 07:51:09 -0700 (PDT)
Received: from [192.168.1.13] (adqg48.neoplus.adsl.tpnet.pl. [79.185.140.48])
        by smtp.gmail.com with ESMTPSA id a17sm3854691wrr.80.2019.05.31.07.51.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:51:09 -0700 (PDT)
Subject: Re: Simple shortcut for "git push --set-upstream origin
 newBranchName"
To:     Cliff Schomburg <clisc@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
From:   Patryk Obara <dreamer.tan@gmail.com>
Message-ID: <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
Date:   Fri, 31 May 2019 16:51:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2019 16:45, Cliff Schomburg wrote:
> I'm proposing a shortcut for this command.

What's wrong with "$ git push -u origin branch"?

--
Patryk Obara
