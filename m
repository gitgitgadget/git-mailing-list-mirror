From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] Test for WIN32 instead of __MINGW32_
Date: Mon, 14 Sep 2009 12:31:26 -0700
Message-ID: <7v1vm9cohd.fsf@alter.siamese.dyndns.org>
References: <cover.1252925290.git.mstormo@gmail.com>
 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
 <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
 <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
 <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com>
 <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com>
 <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
 <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
 <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnHH9-00004s-VR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbZINTbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbZINTbh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:31:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbZINTbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:31:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C2432B47;
	Mon, 14 Sep 2009 15:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nAoqWGH9noM239SqW18SUiRNzmc=; b=txrpw1
	BNwExDy+Ilqyaawj1StfNcQwJmagBNKydMQP2TpoviirI1xX+cKvsbw7K9UPJGPS
	laZCFMzb+PNU1FXYNCRcHl3HSF7vr6GuLiu5nSpkSqttbn46SY+3ZphkdAcRWW2g
	jzAKTxmXmDaEZGb53qLas0wiBrQrmpSEdl8OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjJ3sr01PuksUdn+x2Ys0z2L8KLjwx6q
	84444aa5SbKsYFrkFArcGledxnUYPWVOWnyxhLG95zcipgcwBXWpXIIB10uPrRUj
	DiCRLe5wwggz0Jkeo+bLqZvOlZs3c0sUpc2EcHL4FoxKmxV36KsqkPn9Y+WaEpw6
	G010fUyAAlQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50ECD32B44;
	Mon, 14 Sep 2009 15:31:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0041432B3F; Mon, 14 Sep
 2009 15:31:27 -0400 (EDT)
In-Reply-To: <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
 (Marius Storm-Olsen's message of "Mon\, 14 Sep 2009 15\:11\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3655CCDE-A165-11DE-8454-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128494>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> From: Frank Li <lznuaa@gmail.com>
>
> The code which is conditional on MinGW32 is actually conditional on Windows.
> Use the WIN32 symbol, which is defined by the MINGW32 and MSVC environments,
> but not by Cygwin.
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>

The description sounds very sensible; I wish I read this one first, before
wasting time scratching my head while reading 03/17.  Shouldn't that patch
be squashed into this one?

> ---
>  help.c        |    2 +-
>  pager.c       |    4 ++--
>  run-command.c |    8 ++++----
>  run-command.h |    2 +-
>  setup.c       |    2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/help.c b/help.c
> index fd51b8e..e8db31f 100644
> --- a/help.c
> +++ b/help.c
> @@ -126,7 +126,7 @@ static int is_executable(const char *name)
>  	    !S_ISREG(st.st_mode))
>  		return 0;
>  
> -#ifdef __MINGW32__
> +#ifdef WIN32
>  {	/* cannot trust the executable bit, peek into the file instead */
>  	char buf[3] = { 0 };
>  	int n;
> diff --git a/pager.c b/pager.c
> index f416d38..86facec 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -9,7 +9,7 @@
>  
>  static int spawned_pager;
>  
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  static void pager_preexec(void)
>  {
>  	/*
> @@ -72,7 +72,7 @@ void setup_pager(void)
>  		static const char *env[] = { "LESS=FRSX", NULL };
>  		pager_process.env = env;
>  	}
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	pager_process.preexec_cb = pager_preexec;
>  #endif
>  	if (start_command(&pager_process))
> diff --git a/run-command.c b/run-command.c
> index 91f6d2e..cb006e7 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -75,7 +75,7 @@ fail_pipe:
>  
>  	trace_argv_printf(cmd->argv, "trace: run_command:");
>  
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	fflush(NULL);
>  	cmd->pid = fork();
>  	if (!cmd->pid) {
> @@ -315,7 +315,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
>  	return run_command(&cmd);
>  }
>  
> -#ifdef __MINGW32__
> +#ifdef WIN32
>  static unsigned WINAPI run_thread(void *data)
>  {
>  	struct async *async = data;
> @@ -331,7 +331,7 @@ int start_async(struct async *async)
>  		return error("cannot create pipe: %s", strerror(errno));
>  	async->out = pipe_out[0];
>  
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	/* Flush stdio before fork() to avoid cloning buffers */
>  	fflush(NULL);
>  
> @@ -360,7 +360,7 @@ int start_async(struct async *async)
>  
>  int finish_async(struct async *async)
>  {
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	int ret = wait_or_whine(async->pid, "child process", 0);
>  #else
>  	DWORD ret = 0;
> diff --git a/run-command.h b/run-command.h
> index 0c00b25..fb34209 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -70,7 +70,7 @@ struct async {
>  	int (*proc)(int fd, void *data);
>  	void *data;
>  	int out;	/* caller reads from here and closes it */
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	pid_t pid;
>  #else
>  	HANDLE tid;
> diff --git a/setup.c b/setup.c
> index e3781b6..029371e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
>  const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  {
>  	static char path[PATH_MAX];
> -#ifndef __MINGW32__
> +#ifndef WIN32
>  	if (!pfx || !*pfx || is_absolute_path(arg))
>  		return arg;
>  	memcpy(path, pfx, pfx_len);
> -- 
> 1.6.2.1.418.g33d56.dirty
