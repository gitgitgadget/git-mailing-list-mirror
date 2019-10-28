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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4B81F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfJ1Obz (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 10:31:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:37833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJ1Obz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572273112;
        bh=x7i772cLryRyXwzNyQVwH4Y3xUQ/gynKBcpDXDY2t9o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FOT4rm/D82qzCayiyfd/I0EPjiitbKCq0MTTRZZGfe63hr9meSNGrTAglxwx/XWrl
         EkUGOg4hA3/ZVEBSNQLHzUltTHOZUcfxwEfq5eGfSybm5U2NkHIwm4G8kLSJvk+R6A
         H7BclEEFYXoO5VndX3x/zGxx0u5vu8hCUz5tnCtA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1iSYQE3haf-00WBzI; Mon, 28
 Oct 2019 15:31:51 +0100
Date:   Mon, 28 Oct 2019 15:31:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/9] bugreport: collect list of populated hooks
In-Reply-To: <20191025025129.250049-6-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281522200.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-6-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QiVdjqSaeGaiimcWXPqqATNueD+SSlVGGljWpRmJ/scgyxomEbr
 dMpfJEw4Z9BkdtsB6+ur1Nk1c0sV7yhvZ9SoL4k+r66GK5/KFv3W0Ar5RvhmPK3At+KQ4V7
 6/j2wvcQLKBbjlITtpfR5FCvWriiBKCltSpdNiL43YNIRH6wdhghOQ1hM03Nn32+NGQssJ8
 gt49hf+qldoLAEi2b9Ndg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTw8GCoybts=:47Y1R+NHQNvDtvSN9UBNdw
 j3YejFUHf3fnD1UxnjwT3Pb5xDgGpMTvbXzuQXjBw75n6cBLwifSmk5Nxo0XBE040ejwdNuKX
 RAjjT0ui9R3274oLHg48YrdvE/x9nr3M3r4L4uOXD9NAngvXyQ/6bUxLSdrUMY8mGmFGdHeK0
 1bYigsab46ffl/ETLhJFQe9LY1EjExurYMg1ODJbcz8XZIhwYI4+fXKdtyg8kzWZTk3T669up
 pCACPRUpSAGIN6HfXdwKbL47dmQJSpqyZ2Zu+eZB5l11k2aR2XajLARxs5TlI8VBXVEHCKvM6
 FeidFEL8tevGkf9c4gUpkQQncIpTlXED0BM6gPVH1WMo2Bfn51ziI1iJO+KL89gkZAC6nDXsJ
 HWJo9hqI8+z+FgUSNVyBEQQn32REljt6iVtgxAwWsnWSYmcmWBAKLkb1NGzeeEBXz3vO/7W5R
 oEhTKOt+5gWIXcCQR93vC38jdK2jgHSmwPE3acSbNoQHhpwiiPHysB8n5+rQieFPzP00dlOnW
 spkmkcH1vali3Ls2srQ2N6wbTm2RJnXFJOVHOsfKGrrfqGsEvGiMiju+U6CGloHJmNrT7xdaV
 EQ0/uH1BBWDgFi+aAs7c/YQJzDruooNkq7JPRjgIEzI1ZGAJB1AYPNkkV8ryITv/9GiAwlo1M
 9/BiPiSrJaTt+u4S48iBPp6vcBA+f0redt8SSZMvMIRk1q2CmI8K/kljIO0QPx3GQf8GGnEC5
 hYZ7tctEuMFMiiyy4tVJVyebdLUk5FwYmzXGDCOnVCpxjk3yWiEhlPZHbiz2HqOxlqGMPHN2e
 FbjjwBRMPl5/cN9Rtwy9gXq+duLged+yFWDmV7LRDxXUKDMOypE7Rj/mt2WBLauQOow7kUtIo
 l2mgXQyKVw1+sHM0LTtss56n/Nc2YB80e4yiroU2XPG8dS1EsJldxn0C1nwct6hZmzRqFvyzW
 M5DGLUzL7nULgM/6JnRXEmBlK+UDX3GPKI1k2uUjhMX9D2GKgH3laLIB+Ww5lj0jjGl0RJbq5
 XWbznqZWa29QXmxK5f2Bnb8o8eAYUOw+rUqWQzQhGxL3EvSZZlA3Orh6WW8hRtaclmu58Odo7
 X6VYZJf3EqqqbGsp31WX+s4uNI6AIR/Gwlyu03GBJGgHy7YjsV2H8nNXv+KwKct2LhqQZ9kdP
 jS4AEzecmral0sZwyDz6W+jfnxGkbCAndKAdlkwyapM7M8ju7dh1ky3TJnbLbdOFV0u/MFj5E
 5KZclzFcF03VfD6TRqwMhmW5vXw0OOIrypoiL+QTlsmzPEa2awOT5kH8PNq8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> Occasionally a failure a user is seeing may be related to a specific
> hook which is being run, perhaps without the user realizing. While the
> contents of hooks can be sensitive - containing user data or process
> information specific to the user's organization - simply knowing that a
> hook is being run at a certain stage can help us to understand whether
> something is going wrong.
>
> Without a definitive list of hook names within the code, we compile our
> own list from the documentation. This is likely prone to bitrot. To
> reduce the amount of code humans need to read, we turn the list into a
> string_list and iterate over it (as we are calling the same find_hook
> operation on each string). However, since bugreport should primarily be
> called by the user, the performance loss from massaging the string
> seems acceptable.

Good idea!

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  bugreport.h         |  6 ++++++
>  builtin/bugreport.c |  4 ++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index afa4836ab1..9d7f44ff28 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -103,3 +103,47 @@ void get_whitelisted_config(struct strbuf *config_i=
nfo)
>  	strbuf_reset(config_info);
>  	strbuf_addbuf(config_info, &configs_and_values);
>  }
> +
> +void get_populated_hooks(struct strbuf *hook_info)
> +{
> +	/*
> +	 * Doesn't look like there is a list of all possible hooks; so below i=
s
> +	 * a transcription of `git help hook`.
> +	 */
> +	const char *hooks =3D "applypatch-msg,"
> +			    "pre-applypatch,"
> +			    "post-applypatch,"
> +			    "pre-commit,"
> +			    "pre-merge-commit,"
> +			    "prepare-commit-msg,"
> +			    "commit-msg,"
> +			    "post-commit,"
> +			    "pre-rebase,"
> +			    "post-checkout,"
> +			    "post-merge,"
> +			    "pre-push,"
> +			    "pre-receive,"
> +			    "update,"
> +			    "post-receive,"
> +			    "post-update,"
> +			    "push-to-checkout,"
> +			    "pre-auto-gc,"
> +			    "post-rewrite,"
> +			    "sendemail-validate,"
> +			    "fsmonitor-watchman,"
> +			    "p4-pre-submit,"
> +			    "post-index-changex";

Well, this is disappointing: I tried to come up with a scripted way to
extract the commit names from our source code, and I failed! This is
where I gave up:

	git grep run_hook |
	sed -n 's/.*run_hook[^(]*([^,]*, *\([^,]*\).*/\1/p' |
	sed -e '/^name$/d' -e '/^const char \*name$/d' \
		-e 's/push_to_checkout_hook/"push-to-checkout"/' |
	sort |
	uniq

This prints only the following hook names:

	"applypatch-msg"
	"post-applypatch"
	"post-checkout"
	"post-index-change"
	"post-merge"
	"pre-applypatch"
	"pre-auto-gc"
	"pre-rebase"
	"prepare-commit-msg"
	"push-to-checkout"

But at least it was easy to script the extracting from the
Documentation:

	sed -n '/^[a-z]/{N;/\n~~~/{s/\n.*//;p}}' \
		Documentation/githooks.txt

> +	struct string_list hooks_list =3D STRING_LIST_INIT_DUP;
> +	struct string_list_item *iter =3D NULL;
> +
> +	strbuf_reset(hook_info);
> +
> +	string_list_split(&hooks_list, hooks, ',', -1);
> +
> +	for_each_string_list_item(iter, &hooks_list) {

This should definitely be done at compile time, I think. We should be
able to generate an appropriate header via something like this:

	cat >hook-names.h <<-EOF
	static const char *hook_names[] =3D {
	$(sed -n '/^[a-z]/{N;/\n~~~/{s/\n.*/",/;s/^/	"/;p}}' \
		Documentation/githooks.txt)
	};
	EOF

Then you would use a simple `for()` loop using `ARRAY_SIZE()` to
iterate over the hook names.

> +		if (find_hook(iter->string)) {
> +			strbuf_addstr(hook_info, iter->string);
> +			strbuf_complete_line(hook_info);
> +		}
> +	}
> +}
> diff --git a/bugreport.h b/bugreport.h
> index 7413e7e1be..942a5436e3 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -12,3 +12,9 @@ void get_system_info(struct strbuf *sys_info);
>   * config_info will be discarded.
>   */
>  void get_whitelisted_config(struct strbuf *sys_info);
> +
> +/**
> + * Adds the paths to all configured hooks (but not their contents). The=
 previous
> + * contents of hook_info will be discarded.
> + */
> +void get_populated_hooks(struct strbuf *hook_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 70fe0d2b85..a0eefba498 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -60,6 +60,10 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_whitelisted_config(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Populated Hooks");

Wait! I should have stumbled over this in an earlier patch. The
`add_header()` function should not take a `FILE *` parameter at all, but
instead an `struct strbuf *` one!

Ciao,
Dscho

> +	get_populated_hooks(&buffer);
> +	strbuf_write(&buffer, report);
> +
>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
