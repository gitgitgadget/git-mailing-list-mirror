Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B95D202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdGGPnh (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:43:37 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33576 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdGGPng (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:43:36 -0400
Received: by mail-pg0-f49.google.com with SMTP id k14so19097857pgr.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vfLaWMYDgkJcU5Z/j7CYPkwSONKjI919eim7ON7gUv8=;
        b=OJDWiG0HYoUjEgx0NbZoyhcMG8NlJXvwQl1IX/MYbgv7wTs+Q95T8PwMyo0SGb95cJ
         /5xyrCVnGkRRNh2J5msFABnQ2iUSUln5NB5GeKHdIF6zSIl8QLUe88yBvSR1exqCvqt0
         pw8p6SJ9dKD6q3RDpyqBsESK7uZvQiJ/kW6Ke8X8iu1eiha7NOhS3T3JY2hiJrUrKB2i
         yUjuazYpZp0Sev4SYJ+37rzrAjEbWAJ70URAMA11jJDITk5EaaOTcggZT3B/dumOf8K0
         ZRYbWB4ML9OIZeb+tPIEhWq0NunA5cdRIzvHw6QhnNHG2Q78IOSnDRXfS4rDvVvnviup
         NQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vfLaWMYDgkJcU5Z/j7CYPkwSONKjI919eim7ON7gUv8=;
        b=ojU/yJnrOlpAgrok5wNq0AklX+OhXHaJ9nQdqRwQO0/oBvu1rlxUv2jAaUQf1yx7pb
         PO14mxlL+q3j2rfdUSuVI7aQX3Brw31WnIBea3DgE+KX/8ZjfLFQmVuCpCmB37Oj3Qlz
         uLnaIszSPlkk7PuF28aiFSSS1ueSJU5OHzWS+B3dZAVakBDKtRHcUdOc/NArdNYIxc+Y
         hTeXKMeGHDKLbfmBedBiVNIzJt/TzQftpGYVXgxrHgW+nngMv7F5Zfj62Y48DyR2PGPB
         5aPptOZNQD9rEiykXAgp7C9iaiNvefPn89PHuESgSGEKNuzCNmQguiSgxTxhVERkEaVu
         kisQ==
X-Gm-Message-State: AIVw111WSPUxfrPbet7r8S54kSp/4OhkLf80BRD9EQbUkEPA0/aT93Wt
        VrpwWy7P1VAtrA==
X-Received: by 10.98.202.12 with SMTP id n12mr32645741pfg.187.1499442215402;
        Fri, 07 Jul 2017 08:43:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id 133sm6673175pgc.19.2017.07.07.08.43.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 08:43:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 10
References: <20170707120844.18049-1-dev+git@drbeat.li>
Date:   Fri, 07 Jul 2017 08:43:32 -0700
In-Reply-To: <20170707120844.18049-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Fri, 7 Jul 2017 14:08:44 +0200")
Message-ID: <xmqqh8yockwr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Now that the Unicode 10 has been announced[0], update the character
> width tables to the new version.
>
> [0] http://blog.unicode.org/2017/06/announcing-unicode-standard-version-100.html
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---

Thanks, again, for keeping an eye on the progress in the external
world ;-)  Will apply.
