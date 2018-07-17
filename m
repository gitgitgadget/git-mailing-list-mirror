Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E4C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGQVnt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 17:43:49 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:36767 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeGQVnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 17:43:49 -0400
Received: by mail-qt0-f202.google.com with SMTP id i9-v6so1781727qtj.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=FORnM1fl4fogqRs98bEB/kStc6zfXU0VE5PaWXQvoTM=;
        b=jNHOZ16V2KHxA/NuyxWp2PPR8udI3onjY4uqIKH5EWIuUDXoo5loMBHnnPdgqqJXo7
         9UrcbCx2iCJif1HCTcUuUF0k47zw5QpujBAnro4Pk3YxkHDs4MqU0YsZpdFNWKxXy0sY
         /u+tIqt0qA0MFwTtf8sOZDHnxHeySsYIg8SYTMQeQ5h7RRWhJeD/fcADgTsDdf41h0Ad
         zVK2cgeMB7QQ0gPEM49rzdec0WVXrEkrMSJ+WoEEv0gGSXIE7ksYySbNODtLh09adGCE
         pAnIxpltHQM4PDhG9Gj7ZKPgBI3lE/w2wxRYS1rEwWwW5Fqp1WvOyuHCo7Vkaz0P3+na
         joIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=FORnM1fl4fogqRs98bEB/kStc6zfXU0VE5PaWXQvoTM=;
        b=IUEXTHdHlpKr+aOdo/7PotGXo/CqPdmnYshqikccReQhlmRoGkoX3VvdTRM1O7U4Wk
         uiYxoSAeyoZYpL8vGVKlNnm4K/VeZJNmapWaopcjhZrIid93rCUrCTxYt2hvwLEO7AJx
         KrvSljIpKN9OfB2VEiSk+yazXnBMhO0uTZMM+aGGdUXFFFWLZxKHrezCnMlvxx7kjJ7L
         FAA6svWgz9lbbhPW+ImT5KcV/6m/KlWFyPaNV8ZkL1JXj95IksQu9EMQRGvWPfk6UcZ/
         08/AkgCj7Ys/LNlEMRc4XzE2wFaVLiT8FXaIJOw7HA/cZL7tEkjVj6R0OWST2YSwMUBe
         MEVQ==
X-Gm-Message-State: AOUpUlE5wJU/dHgZ9EyZ4JDLMelfUYAosrPsOmRNzVZRMzUU+O6abrH4
        4+0CgTIeyIJ0kPCPsnfrDqQoFcOpCr8zEtgjg7u3bJK8KTofF2x4vB3ucp/L9mqPrC+sTFEgs/F
        tCF0orMK5SvbNVuxdEF2u03JmSXhNRJ1H9Rqw8xgdTiS7m/RAOQunkHU/ew==
X-Google-Smtp-Source: AAOMgpeSDTfSBGoatmwzQsy4635gJH02lYrjYtmvoYq4RD2QJydiEdxR4BHOTF3T/kzeE9meC0QLGRGOV8E=
MIME-Version: 1.0
X-Received: by 2002:ae9:e116:: with SMTP id g22-v6mr1726846qkm.31.1531861759174;
 Tue, 17 Jul 2018 14:09:19 -0700 (PDT)
Date:   Tue, 17 Jul 2018 14:09:15 -0700
Message-Id: <20180717210915.139521-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [RFC] push: add documentation on push v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Since introducing protocol v2 and enabling fetch I've been thinking
about what its inverse 'push' would look like.  After talking with a
number of people I have a longish list of things that could be done to
improve push and I think I've been able to distill the core features we
want in push v2.  Thankfully (due to the capability system) most of the
other features/improvements can be added later with ease.

What I've got now is a rough design for a more flexible push, more
flexible because it allows for the server to do what it wants with the
refs that are pushed and has the ability to communicate back what was
done to the client.  The main motivation for this is to work around
issues when working with Gerrit and other code-review systems where you
need to have Change-Ids in the commit messages (now the server can just
insert them for you and send back new commits) and you need to push to
magic refs to get around various limitations (now a Gerrit server should
be able to communicate that pushing to 'master' doesn't update master
but instead creates a refs/changes/<id> ref).

Before actually moving to write any code I'm hoping to get some feedback
on if we think this is an acceptable base design for push (other
features like atomic-push, signed-push, etc can be added as
capabilities), so any comments are appreciated.

 Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 49bda76d23..16c1ce60dd 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -403,6 +403,82 @@ header.
 		2 - progress messages
 		3 - fatal error message just before stream aborts
 
+ push
+~~~~~~
+
+`push` is the command used to push ref-updates and a packfile to a remote
+server in v2.
+
+Additional features not supported in the base command will be advertised
+as the value of the command in the capability advertisement in the form
+of a space separated list of features: "<command>=<feature 1> <feature 2>"
+
+The format of a push request is as follows:
+
+    request = *section
+    section = (ref-updates | packfile)
+	       (delim-pkt | flush-pkt)
+
+    ref-updates = PKT-LINE("ref-updates" LF)
+		  *PKT-Line(update/force-update LF)
+
+    update = txn_id SP action SP refname SP old_oid SP new_oid
+    force-update = txn_id SP "force" SP action SP refname SP new_oid
+    action = ("create" | "delete" | "update")
+    txn_id = 1*DIGIT
+
+    packfile = PKT-LINE("packfile" LF)
+	       *PKT-LINE(*%x00-ff)
+
+    ref-updates section
+	* Transaction id's allow for mapping what was requested to what the
+	  server actually did with the ref-update.
+	* Normal ref-updates require that the old value of a ref is supplied so
+	  that the server can verify that the reference that is being updated
+	  hasn't changed while the request was being processed.
+	* Forced ref-updates only include the new value of a ref as we don't
+	  care what the old value was.
+
+    packfile section
+	* A packfile MAY not be included if only delete commands are used or if
+	  an update only incorperates objects the server already has
+
+The server will receive the packfile, unpack it, then validate each ref-update,
+and it will run any update hooks to make sure that the update is acceptable.
+If all of that is fine, the server will then update the references.
+
+The format of a push response is as follows:
+
+    response = *section
+    section = (unpack-error | ref-update-status | packfile)
+	      (delim-pkt | flush-pkt)
+
+    unpack-error = PKT-LINE("ERR" SP error-msg LF)
+
+    ref-update-status = *(update-result | update-error)
+    update-result = *PKT-LINE(txn_id SP result LF)
+    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
+    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)
+
+    packfile = PKT-LINE("packfile" LF)
+	       *PKT-LINE(*%x00-ff)
+
+    ref-update-status section
+	* This section is always included unless there was an error unpacking
+	  the packfile sent in the request.
+	* The server is given the freedom to do what it wants with the
+	  ref-updates provided in the reqeust.  This means that an update sent
+	  from the server may result in the creation of a ref or rebasing the
+	  update on the server.
+	* If a server creates any new objects due to a ref-update, a packfile
+	  MUST be sent back in the response.
+
+    packfile section
+	* This section is included if the server decided to do something with
+	  the ref-updates that involved creating new objects.
+
  server-option
 ~~~~~~~~~~~~~~~
 
-- 
2.18.0.203.gfac676dfb9-goog

