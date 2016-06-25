Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946051FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 13:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcFYN3d (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 09:29:33 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35650 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbcFYN3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 09:29:32 -0400
Received: by mail-it0-f50.google.com with SMTP id g127so34809835ith.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 06:28:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uUA320zxK4rsVuQXlRD8EEoRrZyIBRcwIcyQ6e44JbM=;
        b=oKhgkNtqLNOj7l0tgMbsc4aGh9J8QjDDPnKzmABndm6lg5Cx6ZZwQL/pFwsGwR/0/T
         WjjMx849BF7SfzsZPhmZQCId0XbRXrBKtmzCn6B3m/sdQ5HGUyWxHoQCqOqh+FAcKHcv
         Sgidv0zVkWs3rauu4nzDW1zycY/MZcFfe2QCI+Opwg5u3R2qV7Y1ugxzMtxO2eRvOEPQ
         Q9X/bMCn3N+TvzWIELg7G0gh8LWQ76soxV2N8U3BZP9+Y0nm7uAkDQd36+Co3s4zj29t
         BpBMIYzhcwDqbZc6RjcdEPuv1DIA+OhEM4mUSuhp9pq47l034TdmISAdywIApmsie6Nx
         EAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uUA320zxK4rsVuQXlRD8EEoRrZyIBRcwIcyQ6e44JbM=;
        b=Y6ZRJBmTPg/9u9QSc5S+2w3S50faAMe66InHaBarhmicMV300PFulKISLZN1PxZruH
         BZ2PbYPUjV0ik/06ur2muZO6lHoTSw9tO1JdFYz85jUE/lNnhYFajp8F9AfTXCmXKejJ
         nnIxGUrM1pVOFy1CT/i3sulahnCYeP1F1mtN2EjV8CzpEdOuB0z57ru+t0CfcSRCcOP5
         0Euv8/6Ub17GsL//bOv1UeTd4eJjd0nzMVaxxGVajdaqONA72pyzfhLmZvW7yzA5s68+
         umdRjF7oVPcpifxVXJJ4osgQRirWNuYB70eZozmzMcNFRi1wTzxhrb1oCmWxV79Sms3D
         ZonQ==
X-Gm-Message-State: ALyK8tJwVwb3V75wBYbvqhgCSGgqfnWnguRdgb11r8AbhjNXucAHKixaNERnqw1MQj98JPNhZRFuA3Xb1gae1A==
X-Received: by 10.36.81.15 with SMTP id s15mr2320406ita.57.1466861337617; Sat,
 25 Jun 2016 06:28:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 06:28:28 -0700 (PDT)
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 15:28:28 +0200
Message-ID: <CACsJy8CKxzpphPB4iST_QzP1BqxYZuPKftyvsovwphysXzGa3A@mail.gmail.com>
Subject: Re: [PATCH v12 00/20] index-helper/watchman
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> Of course, as soon as I pinged on the previous version, I noticed an issue.
> ...

A bit off-topic, but you may want to cut a release for libwatchman
(even 0.1.0 would do) so it can be properly packaged.
-- 
Duy
