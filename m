Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1112920954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdLGVdU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:33:20 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35080 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdLGVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:33:20 -0500
Received: by mail-qt0-f194.google.com with SMTP id u10so21383830qtg.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1kVYXn4wPJ0hcHoAl1setw8H9ZXWilX0CaCKqqCiGA=;
        b=UfyPhusfJYiDGPpYmX6UHGbT7y9rDgZrJ2K0vXe6Oi6YiS18ysZ8gQi/eJRfS2kIXe
         4kQFrr7gHeTn9rh1zdpSkm7wzT/ClHxr3NzKnduaTyM0RDTm0AvGgdr/xqSCKlP878di
         5wrgkUMLWrh7N190Za0VSOlIVZ3KUaAbg3dIfH7WzECfQG73m21zovaNhPgxdx2/f5z6
         zH9MZcnrWnLD/Ce8RS24LP/FhUpkxGubhCXnTrp8OsdLquo/FX8yX6emWF7tyE5+VpEg
         E5hSX8+FaGVmD+F7ZYF2g8ZYpH94PgOgwDZyuNc931e2a4dYDWE/rzbFSKWKosZMu0ct
         3j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1kVYXn4wPJ0hcHoAl1setw8H9ZXWilX0CaCKqqCiGA=;
        b=nppyO9zxDaPfqWHXNB0ADiz81KoceHNfIX+lNbbhMlQgi3V3e+GqbtFN385aTdRfOE
         k/TnWK3HV47jR8CahlaenaB2b7d7uPjAykZ4NWNrVRjHpWFTs6z/ay3rbMFxWzOG8Zjr
         F7snPvKJn3ImZCAfUs1+S9WSDSZ5sgMA1+ei4JNJ+cIgCkQcEVWbHwcpNVSRGuITb4eN
         YtqyPufm6maIZiFAfUeKe75VQSDAl04tf4+JxAmYHUXX4H+jjLbqm5qS541FaQxgyDgH
         TL7gn3ySNXdBZk/4Jv/z4WjQuCy9Z/1ZdBqozbunVUKwNfqL++ho5iEqVMiSHuND/S8N
         JmYA==
X-Gm-Message-State: AKGB3mIHg2Iw9TNfoC0xT/0GGqL4j1+BuSkzmOD9KYA9j+tdtx7pozZn
        qJ1Ckxx+h2LZLhzQzK66LDo=
X-Google-Smtp-Source: AGs4zMbRScLsjJnqIGOAr55XSaYZDUWnbloBlarSOPZfB8CULmn3DOPhysgvRzaj17ipq18dqNIC2g==
X-Received: by 10.237.60.238 with SMTP id e43mr12079611qtf.23.1512682399217;
        Thu, 07 Dec 2017 13:33:19 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id d6sm4073542qte.4.2017.12.07.13.33.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 13:33:14 -0800 (PST)
Date:   Thu, 7 Dec 2017 16:33:12 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
Message-ID: <20171207213312.GB3693@zaya.teonanacatl.net>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
 <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
 <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
 <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <175f87bc-0270-fb18-fc14-24e8f59321d6@jeffhostetler.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:
> I'm looking at t5616 now on my mac.
> Looks like the MAC doesn't like my line counting in the tests.
> I'll fix in my next version.

Perhaps that's as simple as using the test_line_counts helper?

diff --git i/t/t5616-partial-clone.sh w/t/t5616-partial-clone.sh
index fa573f8cdb..6d673de90c 100755
--- i/t/t5616-partial-clone.sh
+++ w/t/t5616-partial-clone.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup normal src repo' '
 		git -C src ls-files -s file.$n.txt >>temp
 	done &&
 	awk -f print_2.awk <temp | sort >expect_1.oids &&
-	test "$(wc -l <expect_1.oids)" = "4"
+	test_line_count = 4 expect_1.oids
 '
 
 # bare clone "src" giving "srv.bare" for use as our server.
@@ -76,7 +76,7 @@ test_expect_success 'push new commits to server' '
 	grep blob <temp \
 		| awk -f print_1.awk \
 		| sort >expect_2.oids &&
-	test "$(wc -l <expect_2.oids)" = "8" &&
+	test_line_count = 8 expect_2.oids &&
 	git -C src blame master -- file.1.txt >expect.blame
 '
 
@@ -100,7 +100,7 @@ test_expect_success 'partial fetch inherits filter settings' '
 # it should be in a new packfile (since the promisor boundary is
 # currently a packfile, it should not get unpacked upon receipt.)
 test_expect_success 'verify diff causes dynamic object fetch' '
-	test "$(wc -l <observed.oids)" = "4" &&
+	test_line_count = 4 observed.oids &&
 		cat observed.oids &&
 	git -C pc1 diff master..origin/master -- file.1.txt &&
 	(	cd pc1/.git/objects/pack;
@@ -110,7 +110,7 @@ test_expect_success 'verify diff causes dynamic object fetch' '
 		| awk -f print_1.awk \
 		| sort >observed.oids &&
 		cat observed.oids &&
-	test "$(wc -l <observed.oids)" = "4"
+	test_line_count = 4 observed.oids
 '
 
 # force dynamic object fetch using blame.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If quizzes are quizzical, what are tests?

