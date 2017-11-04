Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AFF7202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbdKDMQg (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 08:16:36 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:56216 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdKDMQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 08:16:35 -0400
Received: by mail-qk0-f196.google.com with SMTP id x195so518563qkb.12
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeancarlomachado-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWpCeXNiE3z2wGhfFTbLscNtkDJa+D1RjRj9vd81WvE=;
        b=uCPqq1DGYRR/IT4B47BAdzKlSC5HjXEQwrrAVek0YQLTQfpD7xK6RSEDreDq35wCEo
         X9sh2BLyd/hiuwx09SGupr5fhKtHMoWyAiFCoBVgQmCgN8LUUFDo5YkqZ1gIHY8gTn7n
         MeeF3HpK8NXaL+L49Xn70p/12T/inWCmDBdhssDYIc3kEXUu+lIJ/h/4Bsc30+2eWMvd
         +3GmLGvElimaoUCtAauJt/UesOtj9wlk6MI1fVUfSMSzIIzr+1l+InCD+lL7FEXh33Yb
         qoMwlbovKZGyRhMX/gpQ39PbWvJoTYipNZhBi3JAPhHtvijSWnFCOP1woIjCtX7eaoGs
         JYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWpCeXNiE3z2wGhfFTbLscNtkDJa+D1RjRj9vd81WvE=;
        b=Nhu+oM0DbUnuHsPExK8lulGPLiHyBdtfSlVM2ahrjoT2K4TS0+V+89M5ZaXoSMMhss
         7Ktgjw5wDGIhg9Y7ozyueQmOzSI8Yq9zjV6TfrzN8RqbATNJy5jJdG/4sHxnZMXc6jVT
         s1irv1PsCHYbScqJKXfc+4y5ggwu2Hz1VxYjkkgWcGVIX2GTMeULmj+mt/LhU5vSFNxk
         TWZ/TCL3obXsX86s1bJgJ8W/wiRI1kUu2FaqglQgr0Og+sJ5pOPQmCASYlnhY41E/tdW
         uq2/9Txc2fvsB97BmyZTm7lUg//EnA9MY1RwjGIqV+pTSmr+omfNM1/oQ23pAe0VrhAD
         nLQA==
X-Gm-Message-State: AJaThX4PFxWenvS+RsaaNyshPz6AA/gBtOD1JbqdwxloPwq7joo4mTkn
        A5L5R7yRt6/O/hEBNz6ZE/pJyQ==
X-Google-Smtp-Source: ABhQp+SNOwBAXODrTyKOLOI6LWCyeCaEUJv5xYeZIecTxYAKqy6WV3EWgvbtWdDfy5PWhaQ/nJ66Rw==
X-Received: by 10.55.133.71 with SMTP id h68mr13395196qkd.17.1509797794448;
        Sat, 04 Nov 2017 05:16:34 -0700 (PDT)
Received: from localhost.localdomain ([200.18.122.31])
        by smtp.gmail.com with ESMTPSA id d5sm5173817qkf.44.2017.11.04.05.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 05:16:33 -0700 (PDT)
From:   Jean Carlo Machado <contato@jeancarlomachado.com.br>
To:     jrnieder@gmail.com
Cc:     contato@jeancarlomachado.com.br, git@vger.kernel.org
Subject: 
Date:   Sat,  4 Nov 2017 10:16:15 -0200
Message-Id: <20171104121616.22264-1-contato@jeancarlomachado.com.br>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171103232831.yrfi6qdq4q4zul4e@aiede.mtv.corp.google.com>
References: <20171103232831.yrfi6qdq4q4zul4e@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I hope it's right this time. :)
