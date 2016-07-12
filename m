Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A364620195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbcGLWzZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:55:25 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33203 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbcGLWzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:55:11 -0400
Received: by mail-pf0-f171.google.com with SMTP id i123so11310533pfg.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:55:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f6RiFop1wup6mM4YtjYJFwZBBQ20fcag3i7e38hP8Rs=;
        b=s9oQ7V4RHULIRF9Fc+v4Lg0CWGSQTwvlUATkzZidcgiRG/EQ+61v1aYBRj0I+ehQhe
         KQYB66li8ZjLmshJ9ojH4kd/5hZUnoeDhSPbxPUIygdwnK5lqYQM4iGhKwmrQBdyjd1X
         fcjYTPJIsOGSsznNJkZ2L2Uy2YI+6OguA8oYV9ta64AF6nfTG1fFB6bJB0MDRMUXwzH2
         Qpz1Oa4pyWgt/F5a/+obS3ZCxHomegFVHLd9cZHnJIitjFSTd3app+c1+WjV33C37gJD
         9x5okn/ecuBbRyXCbgB2LmFMGvGdZxF/fGd3aU7Ge7y7VJHcnouwbiHTkhG75MO3itRz
         zS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f6RiFop1wup6mM4YtjYJFwZBBQ20fcag3i7e38hP8Rs=;
        b=JcaO6KGM9duci+0t0PqDuyBtJ/AnxyexsB+iAhS1j4ZgiLmJ4INcN0crTSOAOlLSNR
         pi+5kGtVnRIjV+Sb8PvqrgjXTwasIty6WRsQ+VjbzMlZk7neHtAq8kI9KixCEdJsVqaJ
         F8azIxoR1BQHMGGFFWXxesBsekvx91pD8Tv5ZqL4TGpX9renJ2RgAC7dghM1nBQNQwjU
         P/9jpv+6E1nFTWfN7DbWvJGyrH44uKKtcLLDUnM7XI4i6B0Ny493fX5ZvkMtNbPYw0nq
         eA/eKFvyJCfJ36tS7E4rc+xI7RdR8+O50ECsUn9hCRBC5LNgrdmRDQMXVhgj3s1WaIiy
         82aw==
X-Gm-Message-State: ALyK8tJVDwsVJqHU4OMS6i47SeuOrIHo6JXiw9Ekcqn8fzJkOmqJDQN/2j+xh/0/Ik6L6g==
X-Received: by 10.98.55.1 with SMTP id e1mr48150862pfa.107.1468364090438;
        Tue, 12 Jul 2016 15:54:50 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id o68sm6758111pfb.18.2016.07.12.15.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:54:49 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 10
Date:	Wed, 13 Jul 2016 04:22:10 +0530
Message-Id: <20160712225210.28803-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160703202704.9193-1-pranit.bauva@gmail.com>
References: <20160703202704.9193-1-pranit.bauva@gmail.com>
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
   the list. Some discussion is happening on github and I will send out the
   patched when the dust settles.

 * I have converted bisect_start() but there is a bug which I am still working
   on.

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish off bisect_start().

 * bisect_next() has become a top priority because it would then help
   converting bisect_auto_next() and then it can be called by other important
   functions like bisect_start().

 * Following that I will convert bisect_auto_start()

 * Then bisect_replay().

======================= My Patches (GSoC project only) ======================

 * check_term_format patch[5]. This is in pu branch. The topic is pb/bisect.

 * bisect_write patch[6]. This is the v3 in the series. This has some minor
   nits as provided by Lars and I will send out a re-roll soon. This is also
   in the pu branch and is applied on top of pb/bisect.

 * bisect_terms patch[7]. This is an RFC and open for discussions. It would
   be very helpful if you can review it over github[8] as my mentors have also
   provided some comments.

============================= Notification ==================================
I will be travelling to my university campus from 14th July to 15th July so
I won't be available. I will resume my work after that.

[1]: https://github.com/pranitbauva1997/git
[3]: https://github.com/pranitbauva1997/git/pull/17
[4]: http://thread.gmane.org/gmane.comp.version-control.git/297266
[5]: http://thread.gmane.org/gmane.comp.version-control.git/295518
[6]: http://thread.gmane.org/gmane.comp.version-control.git/298263
[7]: http://thread.gmane.org/gmane.comp.version-control.git/298279
[8]: https://github.com/pranitbauva1997/git/pull/16

Regards,
Pranit Bauva
