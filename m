Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDC6203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbcGYQ4h (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:56:37 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33564 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbcGYQ4f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 12:56:35 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so10353973ywa.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 09:56:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8ouabbwB0e4qrJGcy3oUUXlzluweg1SwtU4ci9rEj7g=;
        b=ET2aBW6/xcSUkd+GGzK5s8eFm5HTXrOXgT7n/ynElHVkN6tvt6DnJ7W/DqaBr79jg3
         AweojbiRPjuMO7BJZwKO/uh0BFfiNDzGX8p7BkUbH0s+F/7KXFwhUiUoT9CdHyr5LGAw
         pXac6kLvfMt0r0nTTjYNgT4xV81u7RUSpwCBH/A1BrJ0lCpW6uqPMUREwpfl82IIeGnc
         9wsZsPKOtGgiL1fdFOmMvwDtpDeVXjiwc0yKF46XHIip1/DXFOzV+7xN2JK5C8tvRdPO
         wFo+d/WDTJmsu9YZrJ3GG3NqsyPh9++bJysFppoE8+lVMFT1475lYWhab8NtNu4T/LzI
         d0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8ouabbwB0e4qrJGcy3oUUXlzluweg1SwtU4ci9rEj7g=;
        b=fc7C45yU1eSbQT157POFisjegvBNmYnyqg6vUHSsMyyZCiUSLwAXFU7w161V+fPTb9
         vwnhRgjXSKlT9jSDdWNvHt3PfnHaD3G2PH88Qs24K8Tv6oT+N9YYHYFGTes5ARtcLAoh
         gppchfmNaE6xEZuRzYZTkR+KL7P/dZJUz+NixRCyQ1rep5wThZcoE6TOPceNccVbZfqI
         BXcu75GFxWxfZESlkR3QgTMhRJnToCIRaTw5PtKhwmdnlP/IXX2t6YfK+Vb5g9wCmI4T
         kwp8RM4Lk0q8N5PE5XNCh9cUfabRowgwaIzYZojCw4MP9wMmP4UWnuSoo5MP3zzZRbys
         jcjw==
X-Gm-Message-State: AEkoouu9rKA9n5tbrcncd59SCjilmkOKYTnqtlblN8RKHN02TP5lNWIDVhwUwaUYL/ynUs63htwNWy/U/76Cdw==
X-Received: by 10.129.83.213 with SMTP id h204mr16695724ywb.317.1469465794743;
 Mon, 25 Jul 2016 09:56:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Mon, 25 Jul 2016 09:56:15 -0700 (PDT)
In-Reply-To: <20160725162125.15734-1-pclouds@gmail.com>
References: <20160725162125.15734-1-pclouds@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 25 Jul 2016 09:56:15 -0700
X-Google-Sender-Auth: EPtSgCH57M1-Hkp2UuAO6Sd0ZVY
Message-ID: <CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 9:21 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> It looks the the symlink /usr/bin/perl (to /usr/local/bin/perl) has
> been removed at least on FreeBSD 10.3. See [1] for more information.
>
> [1] https://svnweb.freebsd.org/ports/head/UPDATING?r1=386270&r2=386269&pathrev=386270&diff_format=c
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
>  fbsd.

Thanks; and we know that older (but not too old that we no longer care about)
FreeBSD all have /usr/local/bin/perl?
