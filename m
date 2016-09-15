Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04CA2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbcIOVAS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:00:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752161AbcIOVAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66EC33D7F7;
        Thu, 15 Sep 2016 16:51:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=u5Bs
        2e7AufeEWl3TYfi9KJ/MdPY=; b=lMQsLqGS5tuxPN0Gxy8SYry60gS2h13UQHMA
        Cf4QGa32TZIZJ+CLjH4BmCGwnZ6i7vWrNwhyLk+SAxRzbuGxvwCA6URMHo5Tptfn
        7WpxxL6mEPQNzKvYhEXHfTj/VM0WhGMQHxH2coaT5JU4M/ACxwzZZ3bLNrwPnNw5
        7akR91s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=Y34z1s
        yPinPLkHd+QRIfaGwpi8JPSVZl9hag6De+0qmxqJX/opIbvWrz9Cw81v8KzPVEUN
        6GIy9Bv7aonN40/xs30gC2oxXEALTgNYR/YftD/j+Qs44zjcEUj2sMeCpWMQ7iqz
        aI3AhENFVOJD1u/WHkFeJifK2opHD8N4X3TwY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB2B3D7F6;
        Thu, 15 Sep 2016 16:51:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8CDA3D7F5;
        Thu, 15 Sep 2016 16:51:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] SQUASH???
Date:   Thu, 15 Sep 2016 13:51:08 -0700
Message-Id: <20160915205109.12240-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-458-g97b4043
In-Reply-To: <20160915205109.12240-1-gitster@pobox.com>
References: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
 <20160915205109.12240-1-gitster@pobox.com>
X-Pobox-Relay-ID: 2477728A-7B86-11E6-B117-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0bce00..6e78c71 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -78,7 +78,7 @@ static void write_name(const char *name)
 	 * churn.
 	 */
 	static struct strbuf full_name = STRBUF_INIT;
-	if (output_path_prefix != '\0') {
+	if (*output_path_prefix) {
 		strbuf_reset(&full_name);
 		strbuf_addstr(&full_name, output_path_prefix);
 		strbuf_addstr(&full_name, name);
-- 
2.10.0-458-g97b4043

