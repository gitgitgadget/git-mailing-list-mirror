Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C330020986
	for <e@80x24.org>; Sat,  1 Oct 2016 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbcJAS7x (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 14:59:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35863 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJAS7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 14:59:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so8184537wma.3
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lE1vC0lT6HDIsU6Dfl9gH1QIUx1lGn1mDfqYr4zBhQQ=;
        b=oZQC9BRj4XuuRPjjmIoPc/DgHQZz1DrMYXP2NVNd5jWhXZw7L8nWuzPSPbAHEDQC6y
         HiKPzM5XsMDN7eWhUSXdJuwQu+z0PihcvHZhLGlIT6KM0f+lOn1X9grV2zealOiM21Bv
         GVnMz1dr9ZDRAWVu1ARnULdIqj95UdbR0U9Hi17viZqhLj6+qmbYi3GOZQ0PoghUh9N5
         UujI9CyHT0WKsUsQgvLtl0MDlVsobvo791OFsAn9SVk2i9Qqs3dm/XoK1Gn5fttEHWWi
         t6mwVa4QTnV1asCfqNij+cnps5ms6MYVlo64qlp7DoWoRXtawTmg1desK8H4ezIyze9m
         md2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lE1vC0lT6HDIsU6Dfl9gH1QIUx1lGn1mDfqYr4zBhQQ=;
        b=LHXfTdSd7SaoSb6NIkECN4DVpGGLKnb9OhkFE0KeupTkQWM+SzeHxZ1jlkGDVManTr
         0omSYiN9R8DAl/m/V2mitqC9MMdLS24odNiNLZONre68kcwsV3jiI9lJWC1DzBuwKcqw
         DqLOrIXVCEJuc9+A5aEmrniSaLdHoIg65HKoXko51Rvj44FCGfyBdRvknPkXqbWUFjgp
         n7InH/carjT33MSk7nZnaeB6f6CVyt9IL1+skO5KsqpfFsfyQHdRwAle9mk3NKF497Gr
         zJANuoStugMr2wylBCCqsrPKceD+j029ngMNplztUAnG5J+tFMrGl06Q+6E+Z1iaD4vv
         9h5Q==
X-Gm-Message-State: AA6/9RkvkaoBYQXeZRibOmqP6xzUIHr4KBg+QOaH+tAaBfZTHp721mydkkLRd8SW5VP63Q==
X-Received: by 10.28.155.203 with SMTP id d194mr3279764wme.72.1475348389913;
        Sat, 01 Oct 2016 11:59:49 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA8B3.dip0.t-ipconnect.de. [80.139.168.179])
        by smtp.gmail.com with ESMTPSA id w138sm11262068wmd.1.2016.10.01.11.59.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Oct 2016 11:59:49 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 1 Oct 2016 20:59:48 +0200
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com> <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com> <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Sep 2016, at 23:27, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> We discussed that issue in v4 and v6:
>> =
http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.p=
eff.net/
>> =
http://public-inbox.org/git/xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com/
>>=20
>> My impression was that you don't want Git to wait for the filter =
process.
>> If Git waits for the filter process - how long should Git wait?
>=20
> I am not sure where you got that impression.  I did say that I do
> not want Git to _KILL_ my filter process.  That does not mean I want
> Git to go away without waiting for me.
>=20
> If the filter process refuses to die forever when Git told it to
> shutdown (by closing the pipe to it, for example), that filter
> process is simply buggy.  I think we want users to become aware of
> that, instead of Git leaving it behind, which essentially is to
> sweep the problem under the rug.
>=20
> I agree with what Peff said elsewhere in the thread; if a filter
> process wants to take time to clean things up while letting Git
> proceed, it can do its own process management, but I think it is
> sensible for Git to wait the filter process it directly spawned.

To realize the approach above I prototyped the run-command patch below:

I added an "exit_timeout" variable to the "child_process" struct.
On exit, Git will close the pipe to the process and wait "exit_timeout"=20=

seconds until it kills the child process. If "exit_timeout" is negative
then Git will wait until the process is done.

If we use that in the long running filter process, then we could make
the timeout even configurable. E.g. with =
"filter.<driver>.process-timeout".

What do you think about this solution?=20

Thanks,
Lars



diff --git a/run-command.c b/run-command.c
index 3269362..a933066 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,8 @@ void child_process_clear(struct child_process *child)
=20
 struct child_to_clean {
 	pid_t pid;
+	int stdin;
+	int timeout;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -28,9 +30,30 @@ static int installed_child_cleanup_handler;
=20
 static void cleanup_children(int sig, int in_signal)
 {
+	int status;
+	struct timeval tv;
+	time_t secs;
+
 	while (children_to_clean) {
 		struct child_to_clean *p =3D children_to_clean;
 		children_to_clean =3D p->next;
+
+		if (p->timeout !=3D 0 && p->stdin > 0)
+			close(p->stdin);
+
+		if (p->timeout < 0) {
+			// Wait until the process finishes
+			while ((waitpid(p->pid, &status, 0)) < 0 && =
errno =3D=3D EINTR)
+				;	/* nothing */
+		} else if (p->timeout !=3D 0) {
+			// Wait until the process finishes or timeout
+			gettimeofday(&tv, NULL);
+			secs =3D tv.tv_sec;
+			while (getpgid(p->pid) >=3D 0 && tv.tv_sec - =
secs < p->timeout) {
+				gettimeofday(&tv, NULL);
+			}
+		}
+
 		kill(p->pid, sig);
 		if (!in_signal)
 			free(p);
@@ -49,10 +72,12 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
=20
-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, int timeout, int stdin)
 {
 	struct child_to_clean *p =3D xmalloc(sizeof(*p));
 	p->pid =3D pid;
+	p->stdin =3D stdin;
+	p->timeout =3D timeout;
 	p->next =3D children_to_clean;
 	children_to_clean =3D p;
=20
@@ -422,7 +447,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd->exit_timeout, =
cmd->in);
=20
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -483,7 +508,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D =
ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >=3D 0)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd->exit_timeout, =
cmd->in);
=20
 	argv_array_clear(&nargv);
 	cmd->argv =3D sargv;
@@ -765,7 +790,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
=20
-	mark_child_for_cleanup(async->pid);
+	mark_child_for_cleanup(async->pid, 0, -1);
=20
 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index cf29a31..f2eca33 100644
--- a/run-command.h
+++ b/run-command.h
@@ -33,6 +33,7 @@ struct child_process {
 	int in;
 	int out;
 	int err;
+	int exit_timeout;
 	const char *dir;
 	const char *const *env;
 	unsigned no_stdin:1;


