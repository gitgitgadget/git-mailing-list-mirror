Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9E220248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfCEWtw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:49:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39278 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfCEWtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:49:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so4099840wmg.4
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QNOGoAaUBBTGrMhCO2bZ+7MtahX0mYLBdXwDSQ+5wjk=;
        b=SnZ9nAZ0pKMJH7RzpFIOj3ZEp36ep+yjQRCe1zHWvxk4DIDC3AWDOZHNXzcE+fpU5p
         ZQWQAl6ZiaY8Wu4QAbFtkpPWxqmjT0qlF4A8O+qPysR+dWSw96s7sI347vQsM7nPLrfQ
         zdeKSRZ8Q03gA4ZIFH7dTF3EPC3RKPLtjNRxcRLQpK2jV9RyBS6N+3gNd6sYQ5ukgBup
         xetj72Sp0JjtRMtOm9BM7sNSvjODb+soi4I4DhyAvJ2pNnCO3N1aZWlHUqM3XBU0gWKA
         UHy6U3rzuF5cdJRw44LyyULVrP6EJbWaD6u+cEvqYZunP4GBTATdp+QANOIwJaGjSfMG
         +kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QNOGoAaUBBTGrMhCO2bZ+7MtahX0mYLBdXwDSQ+5wjk=;
        b=fpA589V4STzXVp4nBc1uKiouKyKYRCUEkGKwGlckYrVaXHSNh4xSOrVciTmPj6pVce
         5GetHKZrG43IXSjfgPi70w6Fl9SUrbjtlHZKeoVbbk3zCEQ5JqSto98dnTNMRU1VuTeL
         JHJ+GmN78DExJegx4aQq+azmFJ5WOEI79ZkvPkqG1D4Y6XMDGSKzfsFirTSRMVvRIshC
         uapqzZ9ekybqIYrLx617Fy3tVYvRdiwaBYlBBVbkYtaL2dOl8C9utw13k45Y8dDwkpol
         4TI3YG0VE2SEKnm+FImdEb+jwpAqM19uKcg2v+Vb0kSg0sLxJExOFPOzTveQAUwbH81o
         C2Sw==
X-Gm-Message-State: APjAAAUDj2FWwk3Jk/m6eMGwh9IXpigBQRbhKER2EX4PNxU4tVf3x+Q5
        c4t3vGTgIZV34x4wUcPB/bA=
X-Google-Smtp-Source: APXvYqzTcfn466HeUDE8C612cBkNgTH+Qa6Kmnpd25HumC6Ou3YU5yUAexvD9/TNZPW6mYJpKWIUBg==
X-Received: by 2002:a7b:cbd3:: with SMTP id n19mr414575wmi.131.1551826189111;
        Tue, 05 Mar 2019 14:49:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u17sm28578973wrg.71.2019.03.05.14.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 14:49:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-reset.txt: clarify documentation
References: <20190305185423.GA22260@dev-l>
        <xmqqh8cht0mn.fsf@gitster-ct.c.googlers.com>
        <20190305223753.GA18006@dev-l>
Date:   Wed, 06 Mar 2019 07:49:47 +0900
In-Reply-To: <20190305223753.GA18006@dev-l> (Denton Liu's message of "Tue, 5
        Mar 2019 14:37:53 -0800")
Message-ID: <xmqq8sxtszqs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Should reflowing the text be done in a separate patch or should it just
> not be done at all and just be considered noise?

Of course when the rewrite is so extensive that the two versions of
the whole paragraph needs to be carefully read and compared to judge
if the change is desirable, reflowing of the paragraph would not
waste reviewer's time trying to spot where the change is and also
trying to verify there is no other change, and in such a case,
reflowing would be very much OK.

For this particular case, however, I would say it is the latter, as
the way I would have done it would look like either of these, which
would not leave the result any harder to read with unnaturally uneven
lines.

Thanks.


(variant #1)

 Documentation/git-reset.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 132f8e55f6..26e746c53f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -428,8 +428,8 @@ working index HEAD target         working index HEAD
 
 `reset --merge` is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
-involved in the merge does not have local change wrt the index before
-it starts, and that it writes the result out to the working tree. So if
+involved in the merge does not have a local change with respect to the index
+before it starts, and that it writes the result out to the working tree. So if
 we see some difference between the index and the target and also
 between the index and the working tree, then it means that we are not
 resetting out from a state that a mergy operation left after failing



(variant #2)

 Documentation/git-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 132f8e55f6..e952b28305 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -428,7 +428,8 @@ working index HEAD target         working index HEAD
 
 `reset --merge` is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
-involved in the merge does not have local change wrt the index before
+involved in the merge does not have a local change with respect to
+the index before
 it starts, and that it writes the result out to the working tree. So if
 we see some difference between the index and the target and also
 between the index and the working tree, then it means that we are not
