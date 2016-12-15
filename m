Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7DA1FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbcLOJrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 04:47:33 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35069 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755107AbcLOJrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 04:47:32 -0500
Received: by mail-wj0-f193.google.com with SMTP id he10so8769242wjc.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UKDFDA6DunBqa+2PV9/y/5i5HddhHrmwZbKmB4lq5/s=;
        b=lI8W9Hlyh4YFkxAb4uG5026UR+1+EhD5nmzjPUxMHFVIzVSJocVqXXc2y995KrCJbt
         CIXpUHh17FOQut5SGH2PLI8zYTmupTgkfauvf2vPt1MztZTpz0ex4qZV7mf6TevANkuY
         axyJ4saVMyB/Lf0E+uvwDaJPuxk/NpcF+7akcxMvXeMaFw/1PVPFt1ZmYPW7YNs0cj+G
         oclEPbFsTxHs9UjQp7sD6ZyZArgJdTMGrwWHdO4MUGUQ8lF7b33Sxcd4hfFtkNej7hlR
         7WcughZDNK5NllF3CjlXpzemIn6mI8VRImNyAkSgGJqpydFprrdGRKzzg4vBZhmirigL
         6k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKDFDA6DunBqa+2PV9/y/5i5HddhHrmwZbKmB4lq5/s=;
        b=mOot9AMJZgioH+TD1iJSjlv+awfrBwdVchAxSrDroKFm9458o4QaSo9tvZDpynrwYB
         rE2mx71kHa07uEt+vtprjPa4aAty4xg16lP/utN0uBUzCzjG91C5wIc/gLyxDV/GYaH2
         hd7X1KyYV0CgWwxpQagcNqN9XuxOyU9K5+dKBTY63eAWo9KMLrzy/Zdi6WHZQivUYYSN
         vgBdoDcqvLFDZBx24r21k/bICfvDGHnnp2yZkD7vodF+bltAuBr0b2nZhzmI4kuT0RJR
         Eq71Fy6KbsBj9wBNd0TjN/BLxdPYrkS+aP7iiTkdma+XnhrGorne039Axm+T1m5zQ1nb
         ri2g==
X-Gm-Message-State: AKaTC02dDEolFMP1on+lWUrO/YvcCdWhYwPyEJ+fQ4CqLXA0ViAq8MQA9gcibBHAJ+vBSA==
X-Received: by 10.194.137.104 with SMTP id qh8mr465579wjb.69.1481795250198;
        Thu, 15 Dec 2016 01:47:30 -0800 (PST)
Received: from [10.156.63.163] ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id g73sm1610987wme.16.2016.12.15.01.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Dec 2016 01:47:29 -0800 (PST)
Message-ID: <1481795248.4090.15.camel@kaarsemaker.net>
Subject: Re: [PATCH v2 3/6] update_unicode.sh: pin the uniset repo to a
 known good commit
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Date:   Thu, 15 Dec 2016 10:47:28 +0100
In-Reply-To: <1481671904-1143-4-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
         <1481671904-1143-4-git-send-email-dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-12-14 at 00:31 +0100, Beat Bolli wrote:
> +       ( cd uniset && git checkout 4b186196dd )

Micronit, but this is perhaps better written as

git -C uniset checkout 4b186196dd

to avoid the subshell and cd.

D.
