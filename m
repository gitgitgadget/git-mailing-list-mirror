From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] parse-options: align curly braces for all options
Date: Wed, 29 Jul 2015 13:18:37 -0700
Message-ID: <1438201117-11543-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 22:18:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXoM-0003m5-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 22:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbG2USm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 16:18:42 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33149 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG2USl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 16:18:41 -0400
Received: by pdbnt7 with SMTP id nt7so11415493pdb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=G95RsXd32Rfkphbv6RxQA35N8EzYzov2Mkh1eDWyWUo=;
        b=JBHoYInW3Gpt98z66bL3otvR5iaLU+m40Lj3LPPHc+FnXKm0J2TmjLNCsmhA2j6Wwv
         4Nhy4npFX5jtgSbczSdkSI7I/5rapOzhqsS8VvxEDrJ2IdaGBjUm7/rUxZIYMVyr5pEZ
         99AwRsoDgfDX+eZXM3+c1/qDJFM0arPqOXuQdN6DU2s4HYHN0oZKYU79fNhtN9m6weCJ
         ymY8yUtocf9A6S/huGqlhzdgK0+ir1G0mbr0QJbLp1TuOI5MRh0l57C/jsqfMbesb6B9
         fNe8La7ndow5IQ0voqta5vjNtlxZq/hoWMqa0MqsuqNkNRvayq/3qC65Ralkp66thmbr
         MygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G95RsXd32Rfkphbv6RxQA35N8EzYzov2Mkh1eDWyWUo=;
        b=AT2uTsl4YnfcvxtF9vygvXKuBucPoC0JXU8nhCgK1+sn3ekMO96pNq/eArojz7LPV8
         c1Ipa/G2RW1BytW7i70wiif8inIDNEnyH49IPUZE66q2w1Rm2c0zpgd4/olPt5r9dujk
         S4hwMbuTrdia/QN3BhBs00V3mgyV8znoaB5mzxqtu4pVJnaSrHie+oHSfmvf2GflNon0
         MdfByDdeXtxeEWCpOuGUxhTKdTHTQQP7FjpxUC2nsf+Q9UpuJUN9/f79YLYNprue2DCn
         i8EGF83Z/xoYQdpYd+uwJg5N9BhA7ZHbR43f7I2kiYZ2g2/BBwm9Z5QdY3vM7o4DvJ/P
         h/uQ==
X-Gm-Message-State: ALoCoQkEH3uEhf8IHeAhEG97q34UpTiMQjxPJztmEmB/RKhZEiAPTR1UYaaiDXsdl/J6wWlK1cBw
X-Received: by 10.70.129.102 with SMTP id nv6mr98368569pdb.55.1438201120715;
        Wed, 29 Jul 2015 13:18:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d0b2:591c:7542:4aff])
        by smtp.gmail.com with ESMTPSA id oe13sm59442pdb.20.2015.07.29.13.18.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 13:18:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.391.g15b60ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274949>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

The non alignment of white space harmed my feelings for aesthetics more
than it should have.

 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index c71e9da..08d7818 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -126,7 +126,7 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
+#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
-- 
2.5.0.rc1.391.g15b60ce
