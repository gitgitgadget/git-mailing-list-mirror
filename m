Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C63620706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbcGENGR (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:06:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36111 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbcGENFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 09:05:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so28581359wme.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 06:05:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BF1tyyx5y28gXF43bvQOybdDaeuDCTYvlq/iEAEZ30g=;
        b=rP77OXvpx+b989spENH1dbrWqrHCBDUhuY8T94GA1aJB99FRYxGxFd4HBbeCDcsajr
         o13TUIblGAisFbz1dVPotppOzRqQLM+bUsIBmlRRI4baWD++r3IkuWGNfOBJM446J19+
         LnrAqZY9byOX+j4g2Zs8VqIC5moEvjC4jRlbqgqHJzcuT6q1tjPivBCEozK4GDNC39ir
         maOIWj1F8cRgBYnAcCjmO9Z14khicldMfL6QJCuDRaC826ktyWT5JzANLnmgxIdI/b5Z
         187XwXgPg9KuioHBRH5jl0M8FKFEQNp6+zNCexNZOvTbccZnghb/2vewu46qgv2CcRmz
         uoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=BF1tyyx5y28gXF43bvQOybdDaeuDCTYvlq/iEAEZ30g=;
        b=kP2P8FlHvFus8oePpVTnx3fY0eWb03tngp6TRJr6jajNjxpM8LARUKFtIl2+3FjAdf
         SdBJyTFY+HCXuGix+YNCQmuZKOEBikkxKbTqlplFKofIEa+9sUkSLZWuI8cITI9iBvXu
         m7TGaHoZi3HqAaBNKs0HAQL8HHLc4qeGT8X8CB4SYtl/Cyb3SmjAUx0FtdD2A3H2+Can
         V90bjecVFZGnHRV0JiZjnIPhhWfQxinBcaYclvy9PzsW31uyA0v/yyoJvJ2i7/I9z0N5
         6NOWnUB2zVeuzntPChAI9oDm6dhKDaZtBSz0MAsf3fBbaxcheQf00+fzQsrwabSK613b
         sBxA==
X-Gm-Message-State: ALyK8tKlvbBmi+APrOdTjdnTsaKxxbVfP6eh5oFETx1o2MqgfPClDUlzUJ3h+FAbXWdibg==
X-Received: by 10.194.67.39 with SMTP id k7mr17231670wjt.23.1467723939501;
        Tue, 05 Jul 2016 06:05:39 -0700 (PDT)
Received: from [192.168.1.34] (acvd198.neoplus.adsl.tpnet.pl. [83.11.109.198])
        by smtp.googlemail.com with ESMTPSA id t188sm2975712wma.8.2016.07.05.06.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 06:05:38 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] Report bugs consistently
To:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <cover.1467717729.git.johannes.schindelin@gmx.de>
 <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577BB09E.5070801@gmail.com>
Date:	Tue, 5 Jul 2016 15:05:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-05 o 13:23, Johannes Schindelin pisze:
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index f02e3d2..00ea91a 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -118,7 +118,8 @@ static void show_killed_files(struct dir_struct *dir)
>  				 */
>  				pos = cache_name_pos(ent->name, ent->len);
>  				if (0 <= pos)
> -					die("bug in show-killed-files");
> +					die("BUG: killed-file %.*s not found",
> +						ent->len, ent->name);
>  				pos = -pos - 1;
>  				while (pos < active_nr &&
>  				       ce_stage(active_cache[pos]))

This has an additional improvement (not mentioned in the commit
message, but probably not worth it) in that it shows which file
was not found, not only that there was some bug, isn't it?

-- 
Jakub Narębski

