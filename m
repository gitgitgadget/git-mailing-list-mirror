Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B372027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbdCAW7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:59:06 -0500
Received: from mout.web.de ([212.227.15.3]:62833 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752979AbdCAW6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:58:52 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lrrva-1cJTrj0HmA-013cPj; Wed, 01
 Mar 2017 23:57:53 +0100
Subject: Re: What's cooking in git.git (Mar 2017, #01; Wed, 1)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq60jsfww5.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <52f043cc-7b39-5ab7-bcdc-894aeb402c12@web.de>
Date:   Wed, 1 Mar 2017 23:57:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq60jsfww5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JQ/MinkXinIhKmqMxRhkLWMw8vEjY3NLQvAHgQ2TWMUyI2GV+73
 IkfhNl1Jx/SnSzgfZF4K0u6Rm0DWtXDnIBzbSKVSUwG1PB7wNRBIkuxXOWwtna4FMMi38ga
 I2Y/2cRFbUGmzj9Dw3ouHxbCRtXhIYNwIlCuH5gpNbY214sW+ns84IuZbaltBVx6yiTbjtu
 TLeT1ZN9vkTntz8LHnTyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sc+RSK2pcjM=:p87ZZiTwglI6xIPzOvqMj7
 QmFTUtss7y7RJRj0E/MvxztnXd0oDmgnC9xjK0BsFUmBC1X8YEzJnbGuSMCnCjaKucasXp5/g
 U0KD4JBdKC4fOKMxBDdruRdEv/OzpqiUtAEpEoFCQW35vUqvtBxIpf9OAo6DVAHccS5jCEmRw
 jL1/7gG+UlZdyS3Wpi8SDLJ+SSGKNcpVuvBWjxSJAKg+PSlxb1GJEBekpYm5VF72QG31H09Jj
 2VimCw1iCuRGGJz/X1ZyB+kyKPNIV6dyR9vqvcUMW9vDGH07jqqcph9DWKhrv0umuTDSUlyhA
 SSPxZ6rFSPof2t8T8YksNLQsWeIxXxAqgGGoMoDwkMiBQTA2/rKiWKQrSHJU7ARF0ZbbEI8XZ
 A0oLIts+aUnbgHW2XiG7z+W+Jv1YrXiJWubB3O8U/kwKI/XNB1yeRmFsdpxLxM18/TmRGTLKB
 6ZeKFAme0PbbgdoRjaXT4U/GRS1mWWZ0UWIIMQqPhtOz5LO34gCigymjWbNumKpuv1rjuY5+C
 htjAqDmt/pC/N4hd9PBlFRg4GHIZpRoJDiap2GYFqxMOb5Yylh6KGbnbTnLAxg8POipSoNVow
 byJhtpgMd2rVyW/4BvcxJl80fvUJujlEi2RGlqvLlW373y7EkAllCJANPzrWWrtqLrVsF94oY
 Xz7LSlSkbGpG0FXGZDaHdSy+0nZ5VgA31SCdspcemVx1mFzaxuzeEIA23psSXcj+JP43B8VQD
 8zNqICU4JzJ3SxmFphwRXRKJR4RwWIpeHlicwPK8qLhxfZ5up6r7CRrt4cr9E6hQVJm9+NnKc
 OH2S0Js
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.2017 um 23:35 schrieb Junio C Hamano:
> * rs/log-email-subject (2017-03-01) 2 commits
>  - pretty: use fmt_output_email_subject()
>  - log-tree: factor out fmt_output_email_subject()
> 
>  Code clean-up.
> 
>  Will merge to 'next'.

Could you please squash this in?  We only use a single context (as
opposed to an array), so it doesn't have to be especially compact,
and using a bitfield slows down half of the tests in p4000 by 3%
for me.

---
 commit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 459daef94a..528272ac9b 100644
--- a/commit.h
+++ b/commit.h
@@ -154,7 +154,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-	unsigned print_email_subject:1;
+	int print_email_subject;
 	int expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
-- 
2.12.0

