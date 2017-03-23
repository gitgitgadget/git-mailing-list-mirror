Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2522B1FC19
	for <e@80x24.org>; Thu, 23 Mar 2017 11:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdCWLDO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 07:03:14 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34796 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbdCWLDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 07:03:13 -0400
Received: by mail-wr0-f181.google.com with SMTP id l37so144920947wrc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H4e4cFnMiXNjQLBdwoKhm2lLznND0yQAKT8e1rYqZkY=;
        b=pzrkX/JO60qMoAxvMQK6hSLkdLRuP6ugTTOgs8sy0oaiirq9XvnPo/+0TC+S5/knVG
         D8LJ8O3bjAvGudZmOdHY1+iW2oXFTrEbkXMCIMamvG3JWqv0PztqIrxgqwZP9zxA2vSy
         ve5gtlvJvb1X0zmqWfg4upf1PvCRoXeyoO2Jl8fqr8UcYB9dBZlJucpMVriJKjZk9bp2
         kQ/DEE0AnzSCuzf8HoOxM4FgZ3zx6l58eurQIhTN4mXUVxrfg3A/nKdAuV9BzM7y8B7a
         Ol0L83pFCFKdsY3LFmi4Ta046aX8UmGGnjxZMQ+fww7hvzWm7rMLTfjwBE2SxeiZMTB5
         efFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4e4cFnMiXNjQLBdwoKhm2lLznND0yQAKT8e1rYqZkY=;
        b=YjHvhHXSjrFurijFwVq3M9nYzHIIONVbURPMgaD2G+rcGh3cHoi9/Rli/s/2H/92pD
         vR0RAK4cSZiA/jaKshIbwofTuYopW85Yr4x1HockeGBN5pUEWOjtgIoTn/LADX91mQ3w
         db8gdgZsKPBtUjaQ3hLDnKui6cZZWVigkSGtnGnLDHR9rD/MCDy0m5n9RF/xDrBToQxX
         j/n5DZeHgYmWFKhn5ypuLvQF6D0zUyhmYDfBPh62vI/hbs37qI+hnXnWJOAIIUGV9/Rh
         95kKmTS4LamIIWVJCOPbFvXrPNlnBKAKmRMbwtlOXWKp1fUtNE6ucXAEnfg4zcesuRRs
         a3HA==
X-Gm-Message-State: AFeK/H1jVaufNt+ZUfadG2bUTVLeGIv65WlLXISLQK/it1q+JaZki+E5ehD0jcCF9N0l5g==
X-Received: by 10.223.163.21 with SMTP id c21mr1929128wrb.115.1490266991384;
        Thu, 23 Mar 2017 04:03:11 -0700 (PDT)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id l138sm3937376wmd.7.2017.03.23.04.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Mar 2017 04:03:10 -0700 (PDT)
Message-ID: <1490266989.10080.6.camel@kaarsemaker.net>
Subject: Re: blame --line-porcelain is providing me with funny output
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Date:   Thu, 23 Mar 2017 12:03:09 +0100
In-Reply-To: <CAOc6etYTDyyRud9D3jubh7tC9MeyGZXONWM+=Kb+uwx0voSLpw@mail.gmail.com>
References: <CAOc6etYTDyyRud9D3jubh7tC9MeyGZXONWM+=Kb+uwx0voSLpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-03-22 at 18:32 -0600, Edmundo Carmona Antoranz wrote:
> 
> $ git blame --no-progress -w --line-porcelain -L 72,72
> author-mail <somemail@gmail.com>
> 
> $ git cat-file -p 3290fe6dd2a7e2bb35ac760443335dec58802ff1
> author Stefan Beller <somemail@google.com> 1484160452 -0800
> 
> Committer mails are matching, however author mail does not match
> between line-porcelain and cat-file. Is there a reason for that?

The commit object has Stefan's Google address, but git.git's  mailmap
maps that to his gmail address.

git blame actually does this mapping, where git cat-file does not.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
