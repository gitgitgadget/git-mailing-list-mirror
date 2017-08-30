Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD5E20285
	for <e@80x24.org>; Wed, 30 Aug 2017 13:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdH3Nur (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 09:50:47 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37297 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdH3NuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 09:50:01 -0400
Received: by mail-qt0-f176.google.com with SMTP id h15so12142969qta.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KpXBE9DGZge1IIKiB26XubvKMEmGWJ52XI9gzydTtuE=;
        b=uFD0f9urL1SgSM/KXewic47Q779oD+G/yS8L2W7/aoedlKa4NYQK+qY8F7LuwxOa8/
         cEmCN+PxWOhmSTLSrTqLjqaGhBtVGNJ51havDFkU1fdk6pcuwuT1vFSiFimmSnHj+g/O
         P8+fgYfVLMDcUCQx4HKztKpvq/RFdHr4QPIL84lznrHXOQrdaPzxD/Yt0xufwvLRJVXQ
         r5xBiSsw+rFYUvkAjkTuaVmrtXtNkE3z05dcpLgailyIO+bfsqSck6VWIwn2DfBc3agZ
         Rw43R/uXECpKz2RD+E4EmlzXuw1QAJPJPx1Gw5GActAsxj+VEOMiXhcf1f6xbBWDGy67
         jyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KpXBE9DGZge1IIKiB26XubvKMEmGWJ52XI9gzydTtuE=;
        b=auU5torEMvT13nqbnBnkGXEnsKHT3C0+HqrDTZZ/W+el+ALa4KENFZuScKoEwO4A7u
         /ViMqOhSZwYSGPgkK0FmXU7ZTHhwAUhkFGPEa4fi2dVPJiREGjAnnGr6TmVBcuCdksHP
         2KNGi4X4j6drWXZJD7sKGtEW/Y5OvMahizu1O6T7zIyY5OfVTbE8fl/lpccO6zwIeyo6
         DiiNbJ9MlnT/AJdRe2L5wg2f3kAziJV0OyEBZPwuZxD6tcklcy8BinioTaV+1cAeQzDv
         zZ1JhmeaiGfmpTsffMQLAt2XUDy8RZnesc5B5pz3dYOEdqLFlzTksIepbmvTvohVjGCt
         toQw==
X-Gm-Message-State: AHYfb5hFcp8p7QvukGUk92djw6uJWCt0oNw1WvRUUo5ilkNltY/RFTti
        DffwMrFA/SnPrg==
X-Received: by 10.200.8.169 with SMTP id v38mr2126014qth.85.1504101000873;
        Wed, 30 Aug 2017 06:50:00 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id l68sm3580693qkc.42.2017.08.30.06.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Aug 2017 06:49:59 -0700 (PDT)
Date:   Wed, 30 Aug 2017 09:49:59 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention that `eol` can change the dirty
 status of paths
Message-ID: <20170830134959.GA28282@megas.kitware.com>
Reply-To: mathstuf@gmail.com
References: <20170822174918.GA1005@megas.kitware.com>
 <20170823211741.9633-1-mathstuf@gmail.com>
 <20170824055054.GA32617@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170824055054.GA32617@tor.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 07:50:54 +0200, Torsten Bögershausen wrote:
>   This attribute sets a specific line-ending style to be used in the
>   working directory.  It enables end-of-line conversion without any
>  -content checks, effectively setting the `text` attribute.
>  +content checks, effectively setting the `text` attribute.  Note that
>  +setting this attribute on paths which are in the index with CRLF
>  +line endings makes the paths to be considered dirty.
>  +Adding the path to the index again will normalize the line
>  +endings in the index.

Yes, that sounds better. Will resubmit the patch.

--Ben
