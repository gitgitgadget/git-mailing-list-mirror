Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B808202F4
	for <e@80x24.org>; Sun,  3 Jul 2016 20:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbcGCU20 (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 16:28:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35047 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbcGCU2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 16:28:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id t190so14591025pfb.2
        for <git@vger.kernel.org>; Sun, 03 Jul 2016 13:28:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w6hv1cb62evqmT+a/yfn5c1FFqlPNLPlJTq7Z6h33k=;
        b=mKWfTC7JXMLG6uiNOFxih44vg6y/xMPfbeDkGnQPdpkGfuoQbLrsch8hMUSwVZ4lNu
         Zz3j/XKU5Rj1jj/2Tlntat/PHonjfYPyto1iALw7ddonrhRtufAY9ev9yH0KuHX7kVHm
         F0htX5idVTdGboFqWSpl5RuHH0Ay+SPxGBUC6sulh+S57yNnblc0EIq5N/7Ewpqe1RSH
         LbOpiUR75O59fT/z08nto6m2QxPeo/Ip9qD31UXo/104g8O/D1vIxtYFyz2NYfRBwtrM
         p23UzjFaxgxsZDG5A7VVKAJPW1a9GpZMo//+PWwjz1tBRRltBSK2JS6JCAP/BTH63obU
         2TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w6hv1cb62evqmT+a/yfn5c1FFqlPNLPlJTq7Z6h33k=;
        b=khuAP9+ScLhJCLOZJeyZe8xr+jEKgHm2E1W8zR2OtiU97GCdxtHm0Q+MS3WI0iOjAf
         rlSIU/JqbSP+m49Q10mgEkZXik+7cxFEHmDPiIrxe2C0WaWHvnqvGVEss2NXYm7Bbv0n
         wpXxW4V7OU730fZ+zlm0P2fMgQdsSgZSuUHFRA0yXF2kuGazH3OkPi6rMaG+SBLWRjmf
         PCwmVnrpEzwXSQDVPswO/KX1pQzXtD+zGGcxfHBzAyHJoQGCsljGtL8CvI4m9hbC7K8z
         sIrtQt1WalMA/14myLFE3o0ttxpnLG6NsNVS6dOteworg91qQ85JaWSljTiZAQiSTZbX
         v87w==
X-Gm-Message-State: ALyK8tKgVfaLY1ZeIe9C6vG7s0PVuVfZN4y4ciZlYM6A4PEPnBFzkrhSuMsypnVSPrIxsQ==
X-Received: by 10.98.74.157 with SMTP id c29mr16431963pfj.99.1467577704413;
        Sun, 03 Jul 2016 13:28:24 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.228])
        by smtp.gmail.com with ESMTPSA id x66sm4765486pfi.84.2016.07.03.13.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Jul 2016 13:28:23 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	christian.couder@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 9
Date:	Mon,  4 Jul 2016 01:57:04 +0530
Message-Id: <20160703202704.9193-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160627071901.4294-1-pranit.bauva@gmail.com>
References: <20160627071901.4294-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

================================= SUMMARY ==================================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * I have converted check_and_set_terms(), bisect_next_check() and
   bisect_terms() and have also sent an RFC[7] to the
   mailing list for discussion which hasn't yet collected any comments from
   the list. My mentors have given their reviews on github and I will soon
   send the final patch series this week.

 * I have partly converted bisect_start() and a few ending parts are left.

 * I have stalled bisect_replay() for now as before I thought I would partly
   convert it and then call bisect_start() from it but then I realized its
   not worth the effort. So I will continue work on this after I finish
   bisect_start().

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish off bisect_start().

 * Finsh off bisect_start().

 * Finish off bisect_autostart() (small one, wouldn't take much time but it
   depends on bisect_start()).

 * Start with bisect_next().

This has been a slow week as I was meeting a few friends before their college
began and I plan to cover more in the upcoming week as even my semester is
going to start soon and I wouldn't prefer carrying over the work to my
college.

My next semester starts on 18th July.

======================= My Patches (GSoC project only) ======================

 * check_term_format patch[5]. This is in pu branch. The topic is pb/bisect.

 * bisect_write patch[6]. This is the v3 in the series. This has some minor
   nits as provided by Lars and I will send out a re-roll soon. This is also
   in the pu branch and is applied on top of pb/bisect.

 * bisect_terms patch[7]. This is an RFC and open for discussions. It would
   be very helpful if you can review it over github[8] as my mentors have also
   provided some comments.

[1]: https://github.com/pranitbauva1997/git
[3]: https://github.com/pranitbauva1997/git/pull/17
[4]: http://thread.gmane.org/gmane.comp.version-control.git/297266
[5]: http://thread.gmane.org/gmane.comp.version-control.git/295518
[6]: http://thread.gmane.org/gmane.comp.version-control.git/298263
[7]: http://thread.gmane.org/gmane.comp.version-control.git/298279
[8]: 

Regards,
Pranit Bauva
