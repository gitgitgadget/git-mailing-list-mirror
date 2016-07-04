Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651A220179
	for <e@80x24.org>; Mon,  4 Jul 2016 14:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbcGDOIF (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 10:08:05 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34442 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbcGDOIB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 10:08:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id 187so21897912wmz.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 07:08:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8332FVl1+Glk+5XKBq0HpTY8uFij7izeoC66oCJZ68o=;
        b=jvEmjYy4eZixbswXYJoz7vtE9tegxneNeYYayU2slitRd9P8PoTUblr72ylS5Mw9G8
         WKguSaQd9m18GPSHDucp1xSpsS4OSFD59HmP/oWnt9DKL4z8RwC44hHbZBOkJR4s3RAW
         fJcNgM0TeodFlTnADKilofc4WfJ0FSBw2NCiZWYMIOulA4UZDaJNAMZWoOURFWw4sMto
         4YDNJsIQBoey7ZTlhUDUgTuwl/sKXC3SmcFI5wtbPPE4uo7ov9pkiXq3XaI56OCLeRqO
         b2VSUyzD3aZis+u+MJoIK0eEYu5y+mEMxYDitcWbVyP8JJFJQNJ3pNN9kX/hANY0729c
         OnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=8332FVl1+Glk+5XKBq0HpTY8uFij7izeoC66oCJZ68o=;
        b=GexIm0KRDxPYTryVlITAD5aKGtnUm0Hj4fNAckhRp0CrdTfi+bKw+5oVuRaM2Lyqzx
         sz70wxSMEnZVA1N/XqYLtaSJJI1esk6udPDRO8PYU5zrPYOD5pZSbm+f1tCWrD6/KNEb
         FLngBsLXplJ7pVKzgerGUibEvLApNbSiDKz1DvYuvj9RJhx6FqI2pSC8lvCtU1eLdZnN
         sRoXnI/v8C86rHdI6OfKNYL09KVFfVmW3EoLMA5sCW5q+W40X9MWBdrvGbUqod10qSJm
         b/ZtJYXCFpy4arAhkYJ5QTQyaGgFlIypl21j7YARQ5AG+D9hVqGYL8EAwJ8RjOGCQNiz
         C9Mg==
X-Gm-Message-State: ALyK8tIpjV/6BM4sHCmbpD5IrPgBLfWXYFpZeNibkSefoh/qYA3v6JHh4c4x+dB8J8R70g==
X-Received: by 10.194.112.5 with SMTP id im5mr2333889wjb.89.1467641279669;
        Mon, 04 Jul 2016 07:07:59 -0700 (PDT)
Received: from [192.168.1.34] (ewv108.neoplus.adsl.tpnet.pl. [83.20.245.108])
        by smtp.googlemail.com with ESMTPSA id c74sm2085842wme.1.2016.07.04.07.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 07:07:59 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] git-fetch.txt: document fetch output
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-2-pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577A6DBB.2030902@gmail.com>
Date:	Mon, 4 Jul 2016 16:07:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160626055810.26960-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-26 o 07:58, Nguyễn Thái Ngọc Duy pisze:
> +summary::
> +	For a successfully fetched ref, the summary shows the old and new
> +	values of the ref in a form suitable for using as an argument to
> +	`git log` (this is `<old>..<new>` in most cases, and
> +	`<old>...<new>` for forced non-fast-forward updates).

It would be nice to have documented here also other <summary> formats,
like "[new branch]", and/or mention that if the <summary> is not usable
for `git log` it is put in brackets [].

-- 
Jakub Narębski 

