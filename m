Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505F91F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389962AbfJ1OPH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 10:15:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:59185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfJ1OPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572272091;
        bh=hCrQn37/DQBxbd0g0IYAw5WGGkWD7I2HBq+gfT/2BHs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jaGcNSLAPodAlkE09F/HRqhk7LLaYx3AQGYY5a9QMEnRT7ie9eXhcJ2nyQukwCir3
         O6qoH3rDZpqAyPiIkdeif+xhylNyso+/EZqDm1ZEyTXbnTa5d3odtcYayYkSzCqUzP
         qzGZgpJ1RqUJvMPY6b5SRS5ipaxYY0xZMCEqS/6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1iSGdz0h7M-00Vtim; Mon, 28
 Oct 2019 15:14:51 +0100
Date:   Mon, 28 Oct 2019 15:14:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
In-Reply-To: <20191025025129.250049-5-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281506040.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-5-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ASYe5c5xdLYVDwBw+F73whBzrc0olz+M13PMzrKWDlLix289opL
 Dvz+1mRHkHkjWptTic+VzJaj1L/Kiq6jhuLHixo9Hl2YBttArPnvQYvLimDllAYDXmcycRb
 l1/kZdH+9atzoNwvS7frLaVT9MEqNoGWxlFEE7CAef7IbBRSB/WIqPKKr/lqAnZb7IzaMai
 Vp9b5HOmmt0l+OWHCPwPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wIYIicBVouU=:aYfadOpQ091fry2FWYB/WZ
 mDOQcnUYLORREjYga2svAPM71F6gvDHjtvNEtyoFWmSbR35mOGKOM++pUAA2BsyzNqMUJLN0Y
 0G7PoMpJ9SmogV1LZ0cO6xpodxJSFrxrfZ7FH8q/6q3s9h+oyv/ERRXvwq00JDN1mpwrYFOlz
 PwvEDb0GjVQdHB6KPQudPRHd3xwK6PLlW+T8zqxceUkVulYVMmYQ0VR3iOo69sxiqFgJMHlsI
 WVwL49WHVe8Y7SW2gGfa8fL84kCnuSIWPg3bJ/cTq6jOAxQf8G4Y0DUNAVpKHLR85MA52GOal
 Wj8ygjOAYnFWIwA8Gk+lepe9O2aK1/YfEgnSwaqbRb8Gr752zcVDT2Ys7gzqQtMXGiyxI8KzC
 twO4rQ+BU1l5NyM7qK57OGV3QhWgDAxcAE+/irqmhm33NGdIpnhFMVGNl05Aygy/nnVzP9CXY
 Bxgapz8KhlNJO54a5/kCQm478rb38Fc6gFbq+CN8I4odinvqM7pfLsqWebzGs2qQk8xPY0wr4
 fSsc4tL+/CZ4/6Fw5bdvAiqQ+NBMtXohZKnqodF07p9M9u+4Yvzj+t93gI03lFGzjcGPxbD9r
 fh3yvKsDo3bshb9dY/R8q5BcuhHrKAJtp16pBuXEC/YsYJDKovoN2luJeYEm6lmaTYvXS5qpL
 iBstKTEOI+LuYQgU0Y1YBHCdgGbEIXPkEtpli164e4r9w0YJSx4zWaSpPK7sW643EzsL7DoQd
 iCv84vGdF2O2j3mypl0DFhkqCueb4SKD1ybd83zXVjRyN+dOFPRgd3kzICp49osaeU0aNB/Pf
 kaiJrMnDy5JOwk/i0IEzFFmyV/4OMaT4H/tD6429T17siMFyOXVzRaoK23vz3MoH7Lqm7GQkW
 vodjJh0J+S8NyvF5zQq13mg8J4C+TncPits/4PsqZ+b1zGhigSSMjaZ0XHlxmrlf8oY09iZzD
 3IymP2D5D7Rnd6EMjYcK5C1tw62vmYe7Lbl8C46ZKazJZFW0uXCCW7PHyBlCJBtU7gRgFf0YQ
 TZx0CqtDECeeWshpuNo2OB95k9LxLQv8ek9KUIi1F/J8ix2wnKZHCIBFphqUXn5bMLUu7lCmD
 PJHZ0iiV8rFRy5YXVCzTr7/fiO2A60J7Ox7ORLDEUaZ2PGAy0D6d5hnM8FygH/e19BeALGFPP
 mYNZVezncPXomkzRIN8RhBtpQtL3MYl6Gfa6PBAi5BM6XNgk61OdF5N44zrehxr5Ei+un/AWg
 j2qPL9nVGLcbVaSoc8sxhZCQZLb+UyGwPa+Jl13Zak7JW/f4u7PSIv+DDukg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> Teach bugreport to gather the values of config options which are present
> in 'git-bugreport-config-whitelist'.
>
> Many config options are sensitive, and many Git add-ons use config
> options which git-core does not know about; it is better only to gather
> config options which we know to be safe, rather than excluding options
> which we know to be unsafe.

Should we still have the `// bugreport-exclude` comments, then?

>
> Reading the whitelist into memory and sorting it saves us time -
> since git_config_bugreport() is called for every option the user has
> configured, limiting the file IO to one open/read/close and performing
> option lookup in sublinear time is a useful optimization.

Maybe we even want a hashmap? That would reduce the time complexity even
further.

> diff --git a/bugreport.c b/bugreport.c
> index ada54fe583..afa4836ab1 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -1,10 +1,24 @@
>  #include "cache.h"
>
>  #include "bugreport.h"
> +#include "config.h"
> +#include "exec-cmd.h"
>  #include "help.h"
>  #include "run-command.h"
>  #include "version.h"
>
> +/**
> + * A sorted list of config options which we will add to the bugreport. =
Managed
> + * by 'gather_whitelist(...)'.
> + */
> +struct string_list whitelist =3D STRING_LIST_INIT_DUP;
> +struct strbuf configs_and_values =3D STRBUF_INIT;
> +
> +// git version --build-options
> +// uname -a
> +// curl-config --version
> +// ldd --version
> +// echo $SHELL

These comments probably want to move to a single, C style comment, and
they probably want to be introduced together with `get_system_info()`.

I also have to admit that I might have missed where `$SHELL` was added
to the output...

>  void get_system_info(struct strbuf *sys_info)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> @@ -53,3 +67,39 @@ void get_system_info(struct strbuf *sys_info)
>  	argv_array_clear(&cp.args);
>  	strbuf_reset(&std_out);
>  }
> +
> +void gather_whitelist(struct strbuf *path)
> +{
> +	struct strbuf tmp =3D STRBUF_INIT;
> +	strbuf_read_file(&tmp, path->buf, 0);
> +	string_list_init(&whitelist, 1);
> +	string_list_split(&whitelist, tmp.buf, '\n', -1);
> +	string_list_sort(&whitelist);
> +}
> +
> +int git_config_bugreport(const char *var, const char *value, void *cb)
> +{
> +	if (string_list_has_string(&whitelist, var)) {
> +		strbuf_addf(&configs_and_values,
> +			    "%s : %s\n",
> +			    var, value);

A quite useful piece of information would be the config source. Not sure
whether we can do that outside of `config.c` yet...

> +	}
> +
> +	return 0;
> +}
> +
> +void get_whitelisted_config(struct strbuf *config_info)
> +{
> +	struct strbuf path =3D STRBUF_INIT;
> +
> +	strbuf_addstr(&path, git_exec_path());
> +	strbuf_addstr(&path, "/git-bugreport-config-whitelist");

Hmm. I would have expected this patch to come directly after the patch
2/9 that generates that white-list, and I would also have expected that
to be pre-sorted, and compiled in.

Do you want users to _edit_ the file in the exec path? In general, that
path will be write-protected, though. A better alternative would
probably be to compile in a hard-coded list, and to allow including more
values e.g. by offering command-line options to specify config setting
patterns. But if we allow patterns, we might actually want to have those
exclusions to prevent sensitive data from being included.

> +
> +	gather_whitelist(&path);
> +	strbuf_init(&configs_and_values, whitelist.nr);
> +
> +	git_config(git_config_bugreport, NULL);
> +
> +	strbuf_reset(config_info);
> +	strbuf_addbuf(config_info, &configs_and_values);
> +}
> diff --git a/bugreport.h b/bugreport.h
> index ba216acf3f..7413e7e1be 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -5,3 +5,10 @@
>   * The previous contents of sys_info will be discarded.
>   */
>  void get_system_info(struct strbuf *sys_info);
> +
> +/**

I also frequently use JavaDoc-style `/**`, but I am not sure that this
is actually desired in Git's source code ;-)

> + * Adds the values of the config items listed in
> + * 'git-bugreport-config-whitelist' to config_info. The previous conten=
ts of
> + * config_info will be discarded.
> + */
> +void get_whitelisted_config(struct strbuf *sys_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 7232d31be7..70fe0d2b85 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -56,6 +56,10 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_system_info(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Whitelisted Config");

Quite honestly, I would like to avoid the term "whitelist" for good. How
about "Selected config settings" instead?

Thanks,
Dscho

> +	get_whitelisted_config(&buffer);
> +	strbuf_write(&buffer, report);
> +
>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
