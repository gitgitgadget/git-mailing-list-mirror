Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70041F404
	for <e@80x24.org>; Mon,  2 Apr 2018 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDBSJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 14:09:08 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54388 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbeDBSJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 14:09:07 -0400
Received: by mail-wm0-f46.google.com with SMTP id h76so27438361wme.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1yJcjEItu5kQfFYdwZxq/QPDnbzVNNnGt4A8y8xPnmI=;
        b=u4BKMVV6FqSzOPLAO36uHyUk0MD2Z+762G8KO7KQsItX12FMTPCPLN5ciCy39/gO8j
         L5Kn0+cawnphIS+BKPWwbtad2q67pLvk+6/UdwllDdUCwtmElBc1Rmpi1e4c2DMwIqBj
         0MO+VFQ2ExrO7fSP7jnrnd9pXQ7m5xfBGeEaJL/lC4kTYZyhJVa7K08BC7MehKTd6l4j
         cVP/xhgZRwdCyfxPUTc1QDwlRqcf3hVrtXRrFXtfTJ6R/DUHpWT32ScBlmxyjLn8CIS6
         v14BDWl86jE/MZMYphesPR7DTXhgnoKP711VpeIW1CIMtHqCKNG4BMD5O8qqcVEj7MiD
         XU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1yJcjEItu5kQfFYdwZxq/QPDnbzVNNnGt4A8y8xPnmI=;
        b=iutPprAZ14L6iTE5NNg0sOAGP9lv5Y6wyWcM1e32QSEeNQw0gZ6oMn7AqegSwgiHwq
         giN0opC89CyjljojGmd+EfATNYiAEs7guBRwhbqeiR1e2+GPCmpkn4KgRzaEsYN8OEae
         QolAVrFCH2dTUZvVkUCv9AuEOhkfI6xSq4eMNOVQ0i/uCvGZehicgEenxPtXOx3V3V5B
         ug1EUomOcysrDQQyTrH+Oz+GdWYTOJ4gesDvv/n9ryzgfZq3u8yBfQw6sAkEPE8oHbTJ
         SVoye3cw9euyLaA4TZADpowWHXzpgeP3OugaagjG0WqgGkFVohCTVWeM7kvxR6ZkupHj
         EyKg==
X-Gm-Message-State: ALQs6tA4EqqH0pWswOhP7RBpPRYH+Zow5AGkG7AYwb7ekQ8UT+P8Litj
        wbOT5FUv7yxhIyyUceSstVo=
X-Google-Smtp-Source: AIpwx4+BT+KQpGk7N0GneH81Nbn+vIg30Fk0d7ck7TmVF9T+G6zngYarYdlxAzoJVHHcUK0zTPJc7w==
X-Received: by 10.28.237.11 with SMTP id l11mr388118wmh.124.1522692546457;
        Mon, 02 Apr 2018 11:09:06 -0700 (PDT)
Received: from [192.168.178.26] (ipservice-092-213-029-060.092.213.pools.vodafone-ip.de. [92.213.29.60])
        by smtp.gmail.com with ESMTPSA id p4sm1055100wrf.27.2018.04.02.11.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 11:09:05 -0700 (PDT)
Subject: Re: [PATCH] l10n: de.po: translate 132 new messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>
References: <20180328055531.4769-1-ralf.thielow@gmail.com>
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <a2965f28-0db1-a560-38d2-fd7122e7137a@gmail.com>
Date:   Mon, 2 Apr 2018 20:09:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328055531.4769-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

thanks a lot for your translations!

I've only found a small issue:

>   #: git-add--interactive.perl:1405
> -#, fuzzy, perl-format
> +#, perl-format
>   msgid "Discard this hunk from worktree [y,n,q,a,d%s,?]? "
> -msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
> +msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "

"Diesen ..."


Kind regards,
Matthias
