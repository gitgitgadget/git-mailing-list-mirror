Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3A5207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbcJCRNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:13:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33986 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbcJCRNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:13:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id b201so10530716wmb.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yD3RG0/arvUSP3onLoIN7bBAO0Mxy/DNBkTRNXhJ/ZA=;
        b=GR4WZ2dccI5+TX1pIpDt4M+d6W+BYqH+Dxuef7LbcCLVDIswg8B+VTDv+0zal+o4Gt
         9fxCGDVuD6GWiAoCyIZUvXFrSpFX48Hl/YGXeaYuJ/Z0XZiCdLOcL7+ZIcKUqDvva/uO
         YFkt4ZaHMVoyVyZPm3cCcn1nRhHNLAOiskVbBsgIOWg1uHvQ+diEbv84XiYAymxmCVj7
         COr/Zm5ayGUlRVHWx9TeA7HkYlVDZLb6qlBI/gCMM4MqdV3NN+yvrF9Y7vqb/Kw5UpqR
         tWKPE9MdF4X3JXbVOneCz8VZG9zGYnZS3c6nRR8rfoBmcgZJYAbIKGj0liX7nAWqQN52
         s8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yD3RG0/arvUSP3onLoIN7bBAO0Mxy/DNBkTRNXhJ/ZA=;
        b=QE27hwjhs4MQqrd3IP+xvp/UuDRgBdEjnR7x2G0ZH3JJEMklS4ZvllNiYzcoXR0e0L
         yE1KgTQY5V5GZBtEzhuo9VL9PersqlgG5283Uy+dE1TOTfdgsZK8H5IfxPKv4R4OX3Di
         oCqPLwgPgda+bysS7V7lKG6nzjnYXt4iAGmAOviaLv58rlsRSq3jQnBWHOjZtYlWTxon
         /sLF8H5WKMMdJ63kUNflxRpB4RN2mzIuqqqLXGuOZgWLW17n0sVfoRHJkVn5iy43m/O6
         Nla8r6i3rMuH9vkRFROVpFtQJ32mMwP5LqkSx0v2u6kmDoLAOYxAokjpV15P17kPECp2
         gHMQ==
X-Gm-Message-State: AA6/9Rnrn9ePthauc1uxVS/9czAvENmrtDsl5Qq+E45XA9DvYNn67ejPbLAzWXKSR03m7A==
X-Received: by 10.28.139.19 with SMTP id n19mr10011595wmd.71.1475514819238;
        Mon, 03 Oct 2016 10:13:39 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA00A.dip0.t-ipconnect.de. [80.139.160.10])
        by smtp.gmail.com with ESMTPSA id lj2sm35284560wjc.38.2016.10.03.10.13.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Oct 2016 10:13:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
Date:   Mon, 3 Oct 2016 19:13:37 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com> <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com> <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com> <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com> <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Oct 2016, at 22:48, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 01.10.2016 o 20:59, Lars Schneider pisze:=20
>> On 29 Sep 2016, at 23:27, Junio C Hamano <gitster@pobox.com> wrote:
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>=20
>>> If the filter process refuses to die forever when Git told it to
>>> shutdown (by closing the pipe to it, for example), that filter
>>> process is simply buggy.  I think we want users to become aware of
>>> that, instead of Git leaving it behind, which essentially is to
>>> sweep the problem under the rug.
>=20
> Well, it would be good to tell users _why_ Git is hanging, see below.

Agreed. Do you think it is OK to write the message to stderr?


>>> I agree with what Peff said elsewhere in the thread; if a filter
>>> process wants to take time to clean things up while letting Git
>>> proceed, it can do its own process management, but I think it is
>>> sensible for Git to wait the filter process it directly spawned.
>>=20
>> To realize the approach above I prototyped the run-command patch =
below:
>>=20
>> I added an "exit_timeout" variable to the "child_process" struct.
>> On exit, Git will close the pipe to the process and wait =
"exit_timeout"=20
>> seconds until it kills the child process. If "exit_timeout" is =
negative
>> then Git will wait until the process is done.
>=20
> That might be good approach.  Probably the default would be to wait.

I think I would prefer a 2sec timeout or something as default. This way
we can ensure Git would not wait indefinitely for a buggy filter by =
default.


>> If we use that in the long running filter process, then we could make
>> the timeout even configurable. E.g. with =
"filter.<driver>.process-timeout".
>=20
> Sidenote: we prefer camelCase rather than kebab-case for config
> variables, that is, "filter.<driver>.processTimeout".

Sure!


> Also, how would one set default value of timeout for all process
> based filters?

I think we don't need that because a timeout is always specific
to a filter (if the 2sec default is not sufficient).


>>=20
>> +			while ((waitpid(p->pid, &status, 0)) < 0 && =
errno =3D=3D EINTR)
>> +				;	/* nothing */
>=20
> Ah, this loop is here because waiting on waitpid() can be interrupted
> by the delivery of a signal to the calling process; though the result
> is -1, not just any < 0.

"< 0" is also used in wait_or_whine()


>> +			while (getpgid(p->pid) >=3D 0 && tv.tv_sec - =
secs < p->timeout) {
>> +				gettimeofday(&tv, NULL);
>> +			}
>=20
> WTF?  Busy wait loop???

This was just a quick prototype to show "my thinking direction".=20
I wasn't expecting a review. Sorry :-)


> Also, if we want to wait for child without blocking, then instead
> of cryptic getpgid(p->pid) maybe use waitpid(p->pid, &status, =
WNOHANG);
> it is more explicit.

Sure!


> There is also another complication: there can be more than one
> long-running filter driver used.  With this implementation we
> wait for each of one in sequence, e.g. 10s + 10s + 10s.

Good idea, I fixed that in the version below!


>>=20
>> -static void mark_child_for_cleanup(pid_t pid)
>> +static void mark_child_for_cleanup(pid_t pid, int timeout, int =
stdin)
>=20
> Hmmmm... three parameters is not too much, but we might want to
> pass "struct child_process *" directly if this number grows.

I used parameters because this function is also used with the async =
struct...=20

I've attached a more serious patch for review below.
What do you think?

Thanks,
Lars



diff --git a/run-command.c b/run-command.c
index 3269362..ca0feef 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,9 @@ void child_process_clear(struct child_process *child)
=20
 struct child_to_clean {
 	pid_t pid;
+	char *name;
+	int stdin;
+	int timeout;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -28,12 +31,53 @@ static int installed_child_cleanup_handler;
=20
 static void cleanup_children(int sig, int in_signal)
 {
+	int status;
+	struct timeval tv;
+	time_t secs;
+	struct child_to_clean *p =3D children_to_clean;
+
+	// Send EOF to children as indicator that Git will exit soon
+	while (p) {
+		if (p->timeout !=3D 0) {
+			if (p->stdin > 0)
+				close(p->stdin);
+		}
+		p =3D p->next;
+	}
+
 	while (children_to_clean) {
-		struct child_to_clean *p =3D children_to_clean;
+		p =3D children_to_clean;
 		children_to_clean =3D p->next;
+
+		if (p->timeout !=3D 0) {
+			fprintf(stderr, _("Waiting for '%s' to =
finish..."), p->name);
+			if (p->timeout < 0) {
+				// No timeout given - wait indefinitely
+				while ((waitpid(p->pid, &status, 0)) < 0 =
&& errno =3D=3D EINTR)
+					;	/* nothing */
+			} else {
+				// Wait until timeout
+				gettimeofday(&tv, NULL);
+				secs =3D tv.tv_sec;
+				while (!waitpid(p->pid, &status, =
WNOHANG) &&
+					   tv.tv_sec - secs < =
p->timeout) {
+					fprintf(stderr, _(" \rWaiting =
%lds for '%s' to finish..."),
+						p->timeout - tv.tv_sec + =
secs - 1, p->name);
+					gettimeofday(&tv, NULL);
+					sleep_millisec(10);
+				}
+			}
+			if (waitpid(p->pid, &status, WNOHANG))
+				fprintf(stderr, _("done!\n"));
+			else
+				fprintf(stderr, _("timeout. =
Killing...\n"));
+		}
+
 		kill(p->pid, sig);
-		if (!in_signal)
+		if (!in_signal) {
+			free(p->name);
 			free(p);
+		}
 	}
 }
=20
@@ -49,10 +93,18 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
=20
-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup_with_timeout(pid_t pid, const char =
*name, int stdin, int timeout)
 {
 	struct child_to_clean *p =3D xmalloc(sizeof(*p));
 	p->pid =3D pid;
+	p->timeout =3D timeout;
+	p->stdin =3D stdin;
+	if (name) {
+		p->name =3D xmalloc(strlen(name) + 1);
+		strcpy(p->name, name);
+	} else {
+		p->name =3D "process";
+	}
 	p->next =3D children_to_clean;
 	children_to_clean =3D p;
=20
@@ -63,6 +115,13 @@ static void mark_child_for_cleanup(pid_t pid)
 	}
 }
=20
+#ifdef NO_PTHREADS
+static void mark_child_for_cleanup(pid_t pid, const char *name, int =
timeout, int stdin)
+{
+	mark_child_for_cleanup_with_timeout(pid, NULL, 0, 0);
+}
+#endif
+
 static void clear_child_for_cleanup(pid_t pid)
 {
 	struct child_to_clean **pp;
@@ -422,7 +481,8 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup_with_timeout(
+			cmd->pid, cmd->argv[0], cmd->in, =
cmd->clean_on_exit_timeout);
=20
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -483,7 +543,8 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D =
ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >=3D 0)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup_with_timeout(
+			cmd->pid, cmd->argv[0], cmd->in, =
cmd->clean_on_exit_timeout);
=20
 	argv_array_clear(&nargv);
 	cmd->argv =3D sargv;
diff --git a/run-command.h b/run-command.h
index cf29a31..4c1c1f4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,16 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	/*
+	 * clean_on_exit_timeout is only considered if clean_on_exit is =
set.
+	 * - Specify 0 to kill the child on Git exit (default)
+	 * - Specify a negative value to close the child's stdin on Git =
exit
+	 *   and wait indefinitely for the child's termination.
+	 * - Specify a positive value to close the child's stdin on Git =
exit
+	 *   and wait clean_on_exit_timeout seconds for the child's
+	 *   termination.
+	 */
+	int clean_on_exit_timeout;
 };
=20
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }

