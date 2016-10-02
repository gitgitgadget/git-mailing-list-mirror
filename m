Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60BF1F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbcJBRAo (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 13:00:44 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36850 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750845AbcJBRAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 13:00:43 -0400
Received: by mail-lf0-f50.google.com with SMTP id b75so6545362lfg.3
        for <git@vger.kernel.org>; Sun, 02 Oct 2016 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2kzlRdzS9pVHtB1Pe9kms7d93CQ2rcFzsurxVf/M750=;
        b=iPbrI/4KrLdqmvo1jFkR38BSBCJNZcLhoFxV+WE+g+hk5AeFXAztsWFhzw/r7s9vML
         bej5u3Ytha0k86IhWxMOpNN3LcwHdhJfAphR4FvyU5Dr5ID9oTtXBMeA9f+TZggMqUdC
         7pbNeM0uxKb9Vl5vTR0OWmRPywKFWsZ6wvyUy1iHFkOdp+POed4ZHiXmIU2pdwNoWNTR
         fX4kLIbwTuI4HM5evE2Gw+zaC/ETju3zoH+Dn6rV7r6htBlrLBzz/nkbPpF2afQ9kAu8
         7b3ppAm+pj65i0MOrncu9slIdQDMP78fJT+yHnVl2ggzzD589z4AXCp1yLDZ3wLl/DGZ
         3FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2kzlRdzS9pVHtB1Pe9kms7d93CQ2rcFzsurxVf/M750=;
        b=I41rERn43Acg8BuWc88ixkGy/zJOpu8QeynWUF+d4HMWTd7k6rtCECXfG43B68s9AR
         k89lYO+2wQOi7Zs2xi53auJMZafV5f1E1JhLTMxks6fyzx8VoKaFkMg9J/Si687+QvGc
         Fz+G43sDBvOZeblT3sXxduA+0aoABrWLRkHK4EHBYVD5+Kbd9lzS0ifErSqFAGf5ZLqa
         Aak4Sc2FL5J2lTACIC4g4pPb0WnUiAy5ZcaHYDNLnTN44Aa7VrqnQU7rx/WfZeXmzXh5
         GXwkjptHStg/JRRoAec1/UQcIt3F85x8J6wTm0V/xYwU62oES3GfvAUA00MKLa0ZleJg
         m0CA==
X-Gm-Message-State: AA6/9Rn5Gcjm58VGZOiF37A7NSRQhqxm+0iWdtC6Lx3w8kJFAais6eC+osmCBIGNJWSOaaO+wyrSdVh5Q1HFYw==
X-Received: by 10.25.31.9 with SMTP id f9mr6704837lff.34.1475427641228; Sun,
 02 Oct 2016 10:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.173.200 with HTTP; Sun, 2 Oct 2016 10:00:20 -0700 (PDT)
In-Reply-To: <e8bdb434-432b-57c6-5cb4-283aca08ab0b@hale.ee>
References: <e8bdb434-432b-57c6-5cb4-283aca08ab0b@hale.ee>
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Date:   Sun, 2 Oct 2016 19:00:20 +0200
X-Google-Sender-Auth: wCQTyFJCmCJQIqHsBuDI25bTQSw
Message-ID: <CACNzp2kd6wdE6pGsb5d5+cvkJa9M-gzG+5=oLhZr9dLn4o8gOQ@mail.gmail.com>
Subject: Re: Setting pager.add=true breaks add --patch
To:     "Ravi (Tom) Hale" <ravi@hale.ee>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ravi,


I've reported this one bug recently:

https://public-inbox.org/git/nrmbrl$hsk$1@blaine.gmane.org/

The developers know about it, but it will require some deeper refactoring.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
