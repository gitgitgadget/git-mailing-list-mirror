Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FD420133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdCCSHj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:07:39 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35981 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdCCSHa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:07:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so4312389wme.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 10:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cchrrIXm7ifocBw9zPiB7R3B8eYWpvZEUS9PErllU74=;
        b=YK+UNVNJg6jqsw65+Ihztv3nFQtvM87vZwWxH10PdrwzTLGWpmIahH0BFWQjZuEq55
         Z8nQOgMDTNklvCgyPj/BzGSipRXmGotOBsV4crNJrrVnkOk/5EXmfUla670tYcE/hqYN
         syc356rUXaYrngrTD4pXtsxNYLjeDyZpmrb1iYqnPujQD6Xv6T/YojqUbMS/KpgZ57xW
         kQrNVDEugZmp/EpWEguG7raanR3sqrmAv36AvlSlL0T/YZHgPt93EiKcqVC39yVz0G8O
         tW6PPvMs4PDE4PvDlr98nqLSKh+Rr43WpUYlsOkph84FkqSbHyKSe0DusZkzWrkMa6M2
         6Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cchrrIXm7ifocBw9zPiB7R3B8eYWpvZEUS9PErllU74=;
        b=Kzq3WffEQ9lvaZ2kR+EphzmPAZTYFcTZs4ehF062iDHxAc4ihyRYyZjaVZoMkJnnEI
         fIog6vO6eA5K/bYzuI9Qy3wKrH8xePUbv42xgWK9o1rUyD3eJKlgWtsHxJCDep8RitbG
         Z1QDjb6HkGvt0TAHNOSkst1EDEzprGW2Mb+Vl1mSQIdeyuuHeIZlbYSaOwdJ0IS6JLdR
         igyNoOYLNehdWUqiDAUDTxziNO4jftnG9P/mYGO4hD89vDqqrselGrMyrQOcg+5H34ql
         2zeHkFiOXw4Tz0mgX4uA2+m7Ui9ZJy+G67ib2gXXeh5uNrBrx0S2uGPSUrtYL71HkUiU
         HBsg==
X-Gm-Message-State: AMke39k1sJntL7woNZu3Hxof41bWM2KAQ8rghtzornenA6Y6Kg0h6VeVxK28D5x770l0tA==
X-Received: by 10.28.191.24 with SMTP id p24mr4108242wmf.118.1488564393151;
        Fri, 03 Mar 2017 10:06:33 -0800 (PST)
Received: from [192.168.1.25] (AClermont-Ferrand-651-1-328-211.w90-9.abo.wanadoo.fr. [90.9.71.211])
        by smtp.gmail.com with ESMTPSA id z198sm3930616wmz.24.2017.03.03.10.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 10:06:31 -0800 (PST)
Subject: Re: [PATCH 1/3] Add --gui option to mergetool
To:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20170303115738.GA13211@arch-attack.localdomain>
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
From:   =?UTF-8?Q?R=c3=a9mi_Galan_Alfonso?= <remi.galanalfonso@gmail.com>
Message-ID: <cc53dc5b-4f3a-bb7f-4f4f-876ba6adb31f@gmail.com>
Date:   Fri, 3 Mar 2017 19:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170303115738.GA13211@arch-attack.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Denton Liu <liu.denton@gmail.com> writes:
 > [...]
 >
 > +test_expect_success 'gui mergetool' '
 > +	test_when_finished "git reset --hard" &&
 > +	test_when_finished "git config merge.tool mytool" &&
 > +	test_when_finished "git config --unset merge.guitool" &&
 > +	git config merge.tool badtool &&
 > +	git config merge.guitool mytool &&

You should be able to squash the lines
   `test_when_finished "git config --unset merge.guitool" &&`
and
   `git config merge.guitool mytool &&`
into
   `test_config merge.guitool mytool`

(It is however not possible with merge.tool since you set it to a
specific value 'when_finished')

Thanks,
Rémi

