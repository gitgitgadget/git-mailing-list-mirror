Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86ADD1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 12:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFZMZC (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 08:25:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44394 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 08:25:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so2052024qtk.11
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3FZHNDzl0fGP25HAZ28G//xNgLv6NYPK6L8gvwGUF+s=;
        b=OQvcF8P9X6x975jg85HJdZdPiM//6/sqFUNcXIxq2vAl6I94lGwRXHOCxu3p3yM53r
         n00WRJAPj6RTs56xDQ8QWok2MSdMT2HaPWpnsEGxmwfNHZjScp3wvDTO9SVnJPgLXbsS
         n5EE3pHB5WlMo7RnrPx9qXhq4pYdYXPAugpk7T1sC59RNM3iY6yKjAY++awk+DxuFj7u
         COY9OFL5iansGaL7cS1eyFWVQVWaoWn0Nc70VJ+irGiejXzkhhjFdbycBSD+8i/mcxOo
         G/iT/wqKsFidfLdK8AeFPI4mOJMEWDUQ8FY2jZ2yjyHNpYgq7XKEOKNhdapAfAwGr0j0
         1scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3FZHNDzl0fGP25HAZ28G//xNgLv6NYPK6L8gvwGUF+s=;
        b=X3DD+5KSQDf9EvyZ42YBAYaJ1I9v6d7+w/VnnaCc+n/FrszNXOGTfdaR4MS/uxFR1C
         4dGX/Uny5KKLExmpoY0mZjb6LnuXAUNN+1R7gzlLECcFaabrem8lCXHBFdvIOtatikjU
         SGUUPloO4OW5lsVNKnN0Jnwl8ck2q92msQvD+yKlYc99I6bkircCCc2nS8SOwWXtb4I9
         uRU9/98guqjQQQEyQd0lPV5Yi6WSWo2Dzwr6k7kyhQosQg1Zz/shCI/SGgNCZGwTN+u/
         7ZSbkNlS+YQfMHdEFrSI6YQ/Za2e5luJpkelBlyXVS2fdvkgkkluHz2XbfA3OeD3+j0+
         mJZQ==
X-Gm-Message-State: APjAAAWuXuhyvqo/GPN/MLjul1ODWOwMKJgMJnSF6UcoUc2AQZj1L5nc
        jlpB0Igw4MAYSBIN/J3y7mH9AETY
X-Google-Smtp-Source: APXvYqymZHpJwnXiftMDlqGrAgnpFwUIUwv8rmWbuigC4AWQ1Tlz+4Jw7UVxHl5gtdI7JBhdlb2z8Q==
X-Received: by 2002:ac8:156:: with SMTP id f22mr3446864qtg.58.1561551900776;
        Wed, 26 Jun 2019 05:25:00 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id y29sm9203329qkj.8.2019.06.26.05.24.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 05:24:59 -0700 (PDT)
Subject: Re: [BUG] Bad coloring
To:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
References: <1817947890.20190626113231@yandex.ru>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e77e3ee-3daf-da00-fd81-323e34122004@gmail.com>
Date:   Wed, 26 Jun 2019 08:24:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1817947890.20190626113231@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2019 4:32 AM, Eugen Konkov wrote:
> Hello,
> 
> For next diff the `}` line should not be detected as removed/added.
> 
> As  you can see there are differences only at new lines. (see attached
> pics)
> 
> git version 2.21.0
> 
> 
> git diff -b -w --ignore-blank-lines
> 
> 
> git config:
> 
> [color "diff"]
>     old = red bold
>     new = green bold
> 
> [diff]
>     tool = sublimerge
>     colorMoved = default
>     colorMovedWS = ignore-all-space
> 

Below, I pasted your diff in the message body for
easier discussion on-list.

Your diff shows that the content was moved. However, it was
also changed during the move by adding that extra line of
whitespace. The "ignore-all-space" setting can only ignore
whitespace when matching lines. It cannot ignore entire
lines of whitespace.

For that reason, the last three lines are not matched as moved
because they are not part of the larger hunk that moved. You
are using the 'default' mode for diff.colorMoved which defaults
to the 'zebra' mode and that matches blocks of at least 20
characters. These lines at the end are only four characters
("}\n\n\n").

If we used a smaller block size, then we would have too many
false-positives when using the color-moved option.

Thanks,
-Stolee

---

--- a/Service.pm
+++ b/Service.pm
@@ -34,46 +34,4 @@ $X->set_primary_key("id");
 $X->has_many( service_types => $X, 'parent_id' );
 
 
-sub sqlt_deploy_hook {
-    my( $self, $sqlt_table ) =  @_;
-
-    my $sqlt =  $sqlt_table->schema;
-    $sqlt->add_procedure(
-        name =>  'service_level_tree',
-        parameters =>  [
-            { argmode => 'in',  type => 'integer' },
-        ],
-        extra =>  {
-            returns =>  { type => 'table( id int, parent_id int, name text, display text,
-            definitions =>  [
-                { language  =>  'sql' },
-                { attribute =>  'STABLE' },
-                { quote => "\$\$\n",  body => <<'   FUNC' =~ s!^\t!!grm  =~ s!;\n!;/**/\n
-        WITH RECURSIVE service_level_tree (id, parent_id, name, display, depth ) AS (
-            SELECT
-              id,
-              parent_id,
-              name,
-              display,
-              1
-            FROM service_level
-            WHERE id = $1
-            UNION
-            SELECT
-              sl.id,
-              sl.parent_id,
-              sl.name,
-              sl.display,
-              depth +1
-            FROM service_level_tree t
-            INNER JOIN service_level sl ON sl.id = t.parent_id
-            WHERE depth < 10   -- Prohibit deep hierarchy
-        )
-        SELECT * FROM service_level_tree;
-    FUNC
-    ]});
-
-}
-
-
 1;
diff --git a/ServiceLevel.pm b/S
index 73fa9dea..f7da48c8 100644
--- a/ServiceLevel.pm
+++ b/ServiceLevel.pm
@@ -34,4 +34,46 @@ $X->add_unique_constraint([ 'parent_id', 'name' ]);
 
 $X->has_many( service_levels => $X, 'parent_id' );
 
+
+sub sqlt_deploy_hook {
+    my( $self, $sqlt_table ) =  @_;
+
+    my $sqlt =  $sqlt_table->schema;
+    $sqlt->add_procedure(
+        name =>  'service_level_tree',
+        parameters =>  [
+            { argmode => 'in',  type => 'integer' },
+        ],
+        extra =>  {
+            returns =>  { type => 'table( id int, parent_id int, name text, display text,
+            definitions =>  [
+                { language  =>  'sql' },
+                { attribute =>  'STABLE' },
+                { quote => "\$\$\n",  body => <<'   FUNC' =~ s!^\t!!grm  =~ s!;\n!;/**/\n
+        WITH RECURSIVE service_level_tree (id, parent_id, name, display, depth ) AS (
+            SELECT
+              id,
+              parent_id,
+              name,
+              display,
+              1
+            FROM service_level
+            WHERE id = $1
+            UNION
+            SELECT
+              sl.id,
+              sl.parent_id,
+              sl.name,
+              sl.display,
+              depth +1
+            FROM service_level_tree t
+            INNER JOIN service_level sl ON sl.id = t.parent_id
+            WHERE depth < 10   -- Prohibit deep hierarchy
+        )
+        SELECT * FROM service_level_tree;
+    FUNC
+    ]});
+}
+
+
 1;

