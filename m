Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A0C20248
	for <e@80x24.org>; Thu, 21 Mar 2019 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfCUKhT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 06:37:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfCUKhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 06:37:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so4551228edc.8
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SpRmu/K3ET+tYbtRlMQMGAYZPmWHW9gVXN6tEigStKE=;
        b=J+q/OEtUJB1Y9gr4IKq3uz5V9ErQOWzSy83ZJ5G703BfoIku7tcRAPapzfGrAv9Eh2
         /Jx4uNYKQ+y7z3IzQl3YLidSTJPnQuugm+V8tvQKKL9qB0TUOSSmWqtNQb1+S5E68flf
         anM6CPQNECOY3U0Ry8Egr5grfpXP5FC/2JM8eR9slAELky5v8d4DEMwHT8bwfGbQX3wn
         Um/nUhb5YZ8X3txJ7IBehaZQPaXTDf02hk874u7NXPH/XV53W9GvANetDoZAba2/VdFB
         5I1ZtymH+v/TK3J7RlupdASkmfdwSmS3VBLxLK+srABLMfaTTwHpJK8HXpd8Bkcw25lZ
         6luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SpRmu/K3ET+tYbtRlMQMGAYZPmWHW9gVXN6tEigStKE=;
        b=c5wUjAJ8tbUVFoO62usGm4xJjH9RbeZ/pEDKlyfdr/gyoBVHUrHwJJrRPO2Ij8GVfM
         NENszUrblP7887l/IUgkIlRs0lIzdmd406mVuGxmmaDL7ximbkaN3zI4nM0r56IadMz3
         w2lgAM1eimDL2FyOGXXKdF+tbnYxy1gW5IskMn7RAXrD/0oZKlPRnc/HISjYtHeOiVod
         MmnXd3w8yCR+DDFtBHAoJmvpN7RReAF8WI6+MWw1Y8Sm1uHWpLvNSYzv2vTl5H8prSCW
         1oAdm+YlPpthBSyKr9B7g7m2XAKogvOmTW8mVJ77eo0hoEOiecuAnXaeRX8Iv+NSB8Xs
         IHSQ==
X-Gm-Message-State: APjAAAXPuzEBdM6W02Gl/huw7joITZygZoZ2cWaOR3efAfnYUFeSFMnU
        Pmm2BCfk3N0vvAjF8NgzLC4=
X-Google-Smtp-Source: APXvYqyrUGGSYPIDci5dWMVfkcLLvBQoV6r+RZiuxBKxACHasZveTMZGVV/MiCS7rMRULgv6sgTY5Q==
X-Received: by 2002:a17:906:288d:: with SMTP id o13mr1936006ejd.66.1553164637608;
        Thu, 21 Mar 2019 03:37:17 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l15sm975098ejn.77.2019.03.21.03.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 03:37:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com> <871s31dv6o.fsf@evledraar.gmail.com> <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com> <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com> <87va0cd1zp.fsf@evledraar.gmail.com> <xmqq7ecssgpc.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq7ecssgpc.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 11:37:15 +0100
Message-ID: <87sgvgcy3o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>     	graph_version =3D *(unsigned char*)(data + 4);
>>     <<<<<<< HEAD
>>     	if (!graph_version || graph_version > 2) {
>>     		error(_("unsupported graph version %X"),
>>     		      graph_version);
>>     =3D=3D=3D=3D=3D=3D=3D
>>     	if (graph_version !=3D GRAPH_VERSION) {
>>     		error(_("commit-graph version %X does not match version %X"),
>>     		      graph_version, GRAPH_VERSION);
>>     		return NULL;
>>     	}
>>
>>     	hash_version =3D *(unsigned char*)(data + 5);
>>     	if (hash_version !=3D oid_version()) {
>>     		error(_("commit-graph hash version %X does not match version %X"),
>>     		      hash_version, oid_version());
>>     >>>>>>> commit-graph-fix-segfault-and-exit-3
>>     		return NULL;
>>     	}
>>
>> Needs to be resolved as:
>>
>> 	graph_version =3D *(unsigned char*)(data + 4);
>> 	if (!graph_version || graph_version > 2) {
>> 		error(_("commit-graph the graph version %X is unsupported"),
>> 		      graph_version);
>> 		return NULL;
>> 	}
>>
>> I.e. there's a test that greps out "graph version".
>
> Yikes.
>
> Given the common ancestor version's phrasing, and also the updated
> phrasing of the other message since we started supporting v2 of the
> commit-graph file, I resolved this message to
>
> 	 "unsupported commit-graph version %X"
>
> instead.  Of course, I wasn't expecting the test to be depending on
> the exact error message's phrasing X-<.
>
> Thanks.

The "pu" just pushed out as a155e16903ecb60e374d9577216bd1f548bb681a
fails the tests. The "hash_version =3D" part of the conflict is code that
needs to be deleted. In Derrick's v2 code it's been moved down into some
other code, and checking it there produces a failure.

This on top of "pu" fixes it. Note the changing of the error messages,
in my earlier 39cd8897bf ("commit-graph: improve & i18n error messages",
2019-03-14) I'd changed all the errors to start with "commit-graph ..."
something.

It would be really neat if you could resolve to carry that forward for
consistency, since e.g. the "hash version..." error will otherwise be
printed out by e.g. "git status" and friends without giving the user any
context about it being the commit-graph that's at fault. Maybe
"commit-graph the graph version[...]" is bad wording, but otherwise it's
the only error that doesn't start with "commit-graph...":

diff --git a/commit-graph.c b/commit-graph.c
index b2f64790aa..28b5b599ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -155,14 +155,8 @@ struct commit_graph *parse_commit_graph(void *graph_ma=
p, int fd,

 	graph_version =3D *(unsigned char*)(data + 4);
 	if (!graph_version || graph_version > 2) {
-		error(_("unsupported commit-graph version %X"), graph_version);
-		return NULL;
-	}
-
-	hash_version =3D *(unsigned char*)(data + 5);
-	if (hash_version !=3D oid_version()) {
-		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		error(_("commit-graph the graph version %X is unsupported"),
+			graph_version);
 		return NULL;
 	}

@@ -172,7 +166,7 @@ struct commit_graph *parse_commit_graph(void *graph_map=
, int fd,
 	case 1:
 		hash_version =3D *(unsigned char*)(data + 5);
 		if (hash_version !=3D oid_version()) {
-			error(_("hash version %X does not match version %X"),
+			error(_("commit-graph hash version %X does not match version %X"),
 			      hash_version, oid_version());
 			return NULL;
 		}
