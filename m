Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1ADB1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcFYOqr (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:46:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36635 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcFYOqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 10:46:46 -0400
Received: by mail-io0-f195.google.com with SMTP id s63so19722056ioi.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:46:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gg/3OB2zmdT/wioRk6X2rmdYEKhNXCf1eJdKVnbbwh4=;
        b=wyyvZMyEAnNOVp4Yp9K/pnffcOq1p32+1wz5eZmkripHWHmte8j4bkBLX/pCdBbUl1
         zrWqbMl0Wpw2kPYliUTFadzfNGvJi3J0qL59Kqns0FwddumXBQ0mL2F52wplIslvYgwv
         SWU0gSz6cBu+40YDWDQZO8P9zNDPglP1SoWCemj5w3bcU3FZu8tIltvxreLMD1aWCriI
         SCm3PzlLI7YjVTjT/dJCcHdsyc/WG4dYkdMpQ2qFahw+KFK77Yny7kHXW51WDFqPrxxS
         ixoA6rfO+mi750AitXYTE+J8XezcbEg6aF7dlrvDwL8vZHnAStXA1tAjhAAFQTzz3eYZ
         k2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gg/3OB2zmdT/wioRk6X2rmdYEKhNXCf1eJdKVnbbwh4=;
        b=b32UZ924XqxDNzpc9lhtG2+kZy/g/ss5/L/0h0UU0REJ64CuH2bLMrnpbiWwwbd77+
         G+rbIbkTv72Muo7Yt5mBogLVuUqj03rnfB5KNy8QIjA8VkqP+GUVDZmjylVtu3AMB6Zs
         ieXCGasriwtiU1W5SmskiGu/WIwKqt/Rh3HE4i++vHDToNVCwgLDUBS1f5PwFB5E3tlV
         WnkhCs/SNWnRSwx/j8DCBKZjCsCikfyffW1qIErif2L98qugy0QkLCbk6qQIriZaFrQJ
         D2TfJoPDwCF6C55Wz7CqQ/Bl/v63pycVcezWTH3OTgd0vwmtXUP9l15a7y02PtgsKrZu
         MGEw==
X-Gm-Message-State: ALyK8tKbVSQ7QNXSWaWfkJftGiXD3effkxoNfpg754VoI0rBghkqOfwpeYT/Ag8szKAyRXkoyEuyPRy8/KTFHA==
X-Received: by 10.107.22.6 with SMTP id 6mr5151070iow.128.1466866005426; Sat,
 25 Jun 2016 07:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:46:16 -0700 (PDT)
In-Reply-To: <1463694357-6503-8-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-8-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:46:16 +0200
Message-ID: <CACsJy8ANHtf800O+ZGxYRV4mGrLighx+R3kd19jYJA1Vatd+Ow@mail.gmail.com>
Subject: Re: [PATCH v12 07/20] index-helper: add --detach
To:	David Turner <dturner@twopensource.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> We detach after creating and opening the socket, because otherwise
> we might return control to the shell before index-helper is ready to
> accept commands.  This might lead to flaky tests.

Another good reason for delaying detach as much as possible is we can
print errors to stderr instead of to file.
-- 
Duy
