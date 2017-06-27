Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F66620401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbdF0Vtd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:49:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36705 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbdF0Vtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:49:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so32903370wrb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iJIGahgiwa3seNMtjRi/m5pa9tW2lmgytiFL+8TBQFI=;
        b=XlFMawmZP9NaXPw368YASRH7Jh02VhZ5Uf1K1c3R23CX4nQMmuB5S0DzWiyfKC7a4F
         Wrq6fdiEw18rYsvreVgfBwn7Tw9zX2QBelGA3I5zLDquLOZrkryMWpIoPNG6VcnijDyV
         /MyLW9GpFm4/NM9VGZkIg1V8VrzTf3DXp65Z5wkOUL1fQMGpmvIYpCdneSpvwqO87NWm
         fTjfvUkDKeIj0vx83hqMgHhTsOtYcK+tIcAu+vJ3bzD/psk7c0AGYZWQqJqNcJYRPv+J
         6OuBrCuv80ed9t1iwqC1EJCFuO0ZdR9LoSXB89DKH+W8UGQ054+ov+tg2JMFEZgpYpey
         D6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iJIGahgiwa3seNMtjRi/m5pa9tW2lmgytiFL+8TBQFI=;
        b=Gcr4yWqe26yNH7PHOzOHRRGl3PADru1lZzn6l6GNnDKHagx3dhp0Duf/D5JCPiHz7Z
         aprq2BmxVRnxmRlXIfhAEXQ8bTdqynGr1JEPk5jTGW7qB9xg8dtDbawoTIIBPMY8W+hv
         utAecHrNKzNSCa1xFhaXk+qfpO47vV2A/lSjMwHzvwosKLyNu1VrSR/ATIpiy7+ta4NA
         so/uyrskkAMp+xxtIm9v+sq0h2rlqHtxJqi8os2xOX+fCWGYtgs8pdRT9VEUYHzHYO6n
         e5E96iF9Zhf3/VsNHqnp7UMILWASaMYue89J+mMiHLiJhjfkHtplfVIN8Fdy3tJDXaZW
         JTsA==
X-Gm-Message-State: AKS2vOx48p20cvkotaG/ViGGotxEWONmEElqJXXfEVOFvAUj3fuN2rs1
        lV8MaHeJLtex4g==
X-Received: by 10.223.153.65 with SMTP id x59mr18893646wrb.32.1498600170432;
        Tue, 27 Jun 2017 14:49:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4DFA.dip0.t-ipconnect.de. [93.219.77.250])
        by smtp.gmail.com with ESMTPSA id k86sm3814976wmi.16.2017.06.27.14.49.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:49:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com>
Date:   Tue, 27 Jun 2017 23:49:28 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FF53F59-1240-4BED-999F-FE9C9AD7E6AC@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com> <20170627121027.99209-7-larsxschneider@gmail.com> <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com> <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Jun 2017, at 22:34, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 27 Jun 2017, at 21:00, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>>> 	if (err)
>>> 		goto done;
>>>=20
>>> -	err =3D packet_writel(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
>>> +	err =3D packet_writel(process->in,
>>> +		"capability=3Dclean", "capability=3Dsmudge", =
"capability=3Ddelay", NULL);
>>>=20
>>> 	for (;;) {
>>> 		cap_buf =3D packet_read_line(process->out, NULL);
>>> @@ -549,6 +551,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>>> 			entry->supported_capabilities |=3D CAP_CLEAN;
>>> 		} else if (!strcmp(cap_name, "smudge")) {
>>> 			entry->supported_capabilities |=3D CAP_SMUDGE;
>>> +		} else if (!strcmp(cap_name, "delay")) {
>>> +			entry->supported_capabilities |=3D CAP_DELAY;
>>> 		} else {
>>> 			warning(
>>> 				"external filter '%s' requested =
unsupported filter capability '%s'",
>>=20
>> I thought you said something about attempting to make this more
>> table-driven; did the attempt produce a better result?  Just being
>> curious.
>=20
> I treated that as low-prio as I got the impression that you are =
generally OK with
> the current implementation. I promise to send a patch with this =
change.=20
> Either as part of this series or as a follow up patch.

How about this?


 static int start_multi_file_filter_fn(struct subprocess_entry =
*subprocess)
 {
-       int err;
+       int err, i;
        struct cmd2process *entry =3D (struct cmd2process *)subprocess;
        struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
        char *cap_buf;
@@ -516,6 +516,15 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
        struct child_process *process =3D &subprocess->process;
        const char *cmd =3D subprocess->cmd;

+       static const struct {
+               const char *name;
+               unsigned int cap;
+       } known_caps[] =3D {
+               { "clean",  CAP_CLEAN  },
+               { "smudge", CAP_SMUDGE },
+               { "delay",  CAP_DELAY  },
+       };
+
        sigchain_push(SIGPIPE, SIG_IGN);

        err =3D packet_writel(process->in, "git-filter-client", =
"version=3D2", NULL);
@@ -534,8 +543,15 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
        if (err)
                goto done;

-       err =3D packet_writel(process->in,
-               "capability=3Dclean", "capability=3Dsmudge", =
"capability=3Ddelay", NULL);
+       for (i =3D 0; i < ARRAY_SIZE(known_caps); ++i) {
+               err =3D packet_write_fmt_gently(
+                       process->in, "capability=3D%s\n", =
known_caps[i].name);
+               if (err)
+                       goto done;
+       }
+       err =3D packet_flush_gently(process->in);
+       if (err)
+               goto done;

        for (;;) {
                cap_buf =3D packet_read_line(process->out, NULL);
@@ -547,18 +563,15 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
                        continue;

                cap_name =3D cap_list.items[1].string;
-               if (!strcmp(cap_name, "clean")) {
-                       entry->supported_capabilities |=3D CAP_CLEAN;
-               } else if (!strcmp(cap_name, "smudge")) {
-                       entry->supported_capabilities |=3D CAP_SMUDGE;
-               } else if (!strcmp(cap_name, "delay")) {
-                       entry->supported_capabilities |=3D CAP_DELAY;
-               } else {
-                       warning(
-                               "external filter '%s' requested =
unsupported filter capability '%s'",
-                               cmd, cap_name
-                       );
-               }
+               i =3D ARRAY_SIZE(known_caps) - 1;
+               while (i >=3D 0 && strcmp(cap_name, known_caps[i].name))
+                       i--;
+
+               if (i >=3D 0)
+                       entry->supported_capabilities |=3D =
known_caps[i].cap;
+               else
+                       warning("external filter '%s' requested =
unsupported filter capability '%s'",
+                       cmd, cap_name);

                string_list_clear(&cap_list, 0);





