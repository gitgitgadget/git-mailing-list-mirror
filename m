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
	by dcvr.yhbt.net (Postfix) with ESMTP id 204981F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfJ1PIJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:08:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:46941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388953AbfJ1PII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572275276;
        bh=JbK+ak4wbyyPcUHW9lzNk4SK6OMFUBuXp7Upyq2N+XM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Isocw2DWLZRPjlsoTvLEf5qsDtn5lLFVtqmllcWBr7rZUVCMsy1ZPzBRIXAdtc4Sr
         Fs+1HYFWR8x3cO8/4zYPYWdRA0Lly2blHL/UEsU6Bl6HDOdBQey+6ORYvFic9/SKCf
         HSqve6pqAWYPHMffCISRglKs49IZVewSXiFUft5Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1iBgV83Yun-00DV5F; Mon, 28
 Oct 2019 16:07:55 +0100
Date:   Mon, 28 Oct 2019 16:07:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/9] bugreport: count loose objects
In-Reply-To: <20191025025129.250049-7-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281540550.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-7-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sjdE85badBrGb1ddgK/sQ/RSf2wgTBJHvnO5Tf8i2kn39sGl3eK
 qXFbSA7te5TKSEDGwoInmOd4AmJWJYEQS50p8RnnpcWawiYe14oR9rPT38BYNCH4dSjD3cC
 CxObOhop+M+Nx85YQaC1eC1QjXvzR0TE03gBOpTrWgQ+TiOXyMIpqXXT5kChWvZ6ARBJPjY
 muA6tw0I17fLv76b6mrDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cC3ylGV/vjs=:qtDcsBTo/Pb7hiY1cPHosG
 wYr9Ks7t4SziDtWfeEwTULe8Gs1I16tVtf+PX5i/siGhI7q1WifgqT+2EEMN4uleLz5SsuAV4
 FftbkZLcJ7NFt8lnPuV1JIdtWwqK9ISIbEvZxpgKiplwVF+Ew3Z41AknfUoHnO1fSi6625T3B
 8zap7LUFX0U7yqQ6USKzoYt730oByEZ1kkm0/8YtALNKbbO5pe19ekGb/kT2ZrNwfvDgdGS2t
 zeSaxgyFLlXnXmDMvvxUnRnIAtLcoEDq5OjOTgSDH7lFHSyVKE3DvPFXDFBUajKEKhHXMbe2k
 xZX7kx5VRVQwLVF1ex6mNmnINE13y1jRMEZCtNZ4r6Z+BHkuqNPyujaTIWKZ4bpZ93tHbYEDB
 SHPoPkZZm2Te861GzNhVB261SwrQuW6pB5GoGUq3bwXNpNUt4RzqWPLiQBu1eth8knkJsJp8x
 VN+CZQsN4ubtxfWF9aVUaln0o4XjOQbeGTL5mP4BadqgK9x87FYh7bTXL200x1Bj0yOSHG8ur
 F8U3t/EbLg0OY2mTY1NB6zUqUa8gJXxjOFDAuoK0XXfx6LTj+zIkKHGhOQeiFvJXBNotQHZi+
 QcWFUZeggctfPB57mykXrQco0n8NWtekJnYX3nueOxl8bqbT6v/93rRUm8X3/kWv6BCDyrg+n
 dRtFDq1VR5k87oLGrEpnP7X2nUwQ0rcc6fETIwyFaRrpVGKnF7HoPBNRvmIrybFQA53SZEawP
 j2zM/u+FQojlt4LCFeoHzqSK97x32r7nmHO+utV6QVBUEb/w3GbQLu0eaRblUNx5No/AbBDP9
 yTjCIpZdwQe0PeI0T1Iwkbxg261gXucunUMg61d8zmw9hyD+jMgGCTWV0zQXJXjCbCevs9m90
 0PMj57tKRvlXZoaIZ8p0+I+Y9iy/1joSRTGhgmzU4QYuKymMdqfFTppKkO+4sZemxGPkNYEud
 Q4o7mcwgARprEC7RUxBOFeci0xm26hqu7cSYMHCVXEgQI4rTpXqKD85WCLkVAP2/iOhTR7RMw
 IBZRI7JL0LZkxp08CscwQAxn9dmc5H1kJC8rp1HGDAhd5yxNK6eSNN6Ll2J9yvaZdQImhhKWZ
 x52qJjzG5y2wdAExXkLgxi5hYpjCqiuuX5SLP5GJ+lvP4Hio376q56aeRGJsCbiK6+/TpJLcn
 zQdRz1QUFQiGp25JXQX69GNgeAZk3JhaxzPczwgCshCcYnryj0LD9xO4947H4kb8QlNOpQykB
 NkMfe1kWO3tLQ9mI0dJwfny09QiSqfHYnlprRbcuNVoTiiHW2SIbj7kogIdU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> The number of unpacked objects in a user's repository may help us
> understand the root of the problem they're seeing, especially if a
> command is running unusually slowly.
>
> Rather than directly invoking 'git-count-objects', which may sometimes
> fail unexpectedly on Git for Windows, manually count the contents of
> .git/objects. Additionally, since we may wish to inspect other
> directories' contents for bugreport in the future, put the directory
> listing into a helper function.

Thank you, much appreciated!

I guess the next step is to count the number of packs, and the number of
submodules ;-)

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  bugreport.h         |  6 ++++
>  builtin/bugreport.c |  4 +++
>  3 files changed, 82 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index 9d7f44ff28..54e1d47103 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -5,8 +5,11 @@
>  #include "exec-cmd.h"
>  #include "help.h"
>  #include "run-command.h"
> +#include "strbuf.h"

Why not append this to the end of the `#include` list, as is common in
Git's commit history?

>  #include "version.h"
>
> +#include "dirent.h"

This header (although with pointy brackets instead of double quotes) is
already included in `git-compat-util.h`

> +
>  /**
>   * A sorted list of config options which we will add to the bugreport. =
Managed
>   * by 'gather_whitelist(...)'.
> @@ -147,3 +150,72 @@ void get_populated_hooks(struct strbuf *hook_info)
>  		}
>  	}
>  }
> +
> +/**
> + * Fill 'contents' with the contents of the dir at 'dirpath'.

Since you start this comment in JavaDoc style, there should be an almost
empty line after this one ("almost" because it still contains the
asterisk, of course).

> + * If 'filter' is nonzero, the contents are filtered on d_type as 'type=
' - see
> + * 'man readdir'. opendir() doesn't take string length as an arg, so do=
n't
> + * bother passing it in.
> + */
> +void list_contents_of_dir(struct string_list *contents, struct strbuf *=
dirpath,

Shouldn't this be `static`?

> +			  int filter, unsigned char type)
> +{
> +	struct dirent *dir =3D NULL;
> +	DIR *dh =3D NULL;
> +
> +	dh =3D opendir(dirpath->buf);
> +	while (dh && (dir =3D readdir(dh))) {
> +		if (!filter || type =3D=3D dir->d_type) {
> +			string_list_append(contents, dir->d_name);
> +		}
> +	}
> +}
> +
> +
> +void get_object_counts(struct strbuf *obj_info)

Oops. This function is no longer used.

> +{
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	struct strbuf std_out =3D STRBUF_INIT;
> +
> +	argv_array_push(&cp.args, "count-objects");
> +	argv_array_push(&cp.args, "-vH");
> +	cp.git_cmd =3D 1;
> +	capture_command(&cp, &std_out, 0);
> +
> +	strbuf_reset(obj_info);
> +	strbuf_addstr(obj_info, "git-count-objects -vH:\n");
> +	strbuf_addbuf(obj_info, &std_out);
> +}
> +
> +void get_loose_object_summary(struct strbuf *obj_info)
> +{
> +	struct strbuf dirpath =3D STRBUF_INIT;
> +	struct string_list subdirs =3D STRING_LIST_INIT_DUP;
> +	struct string_list_item *subdir;
> +
> +	strbuf_reset(obj_info);
> +
> +	strbuf_addstr(&dirpath, get_object_directory());
> +	strbuf_complete(&dirpath, '/');
> +
> +	list_contents_of_dir(&subdirs, &dirpath, 1, DT_DIR);
> +
> +	for_each_string_list_item(subdir, &subdirs)
> +	{
> +		struct strbuf subdir_buf =3D STRBUF_INIT;
> +		struct string_list objects =3D STRING_LIST_INIT_DUP;
> +
> +		/*
> +		 * Only interested in loose objects - so dirs named with the
> +		 * first byte of the object ID
> +		 */
> +		if (strlen(subdir->string) !=3D 2 || !strcmp(subdir->string, ".."))
> +			continue;
> +
> +		strbuf_addbuf(&subdir_buf, &dirpath);
> +		strbuf_addstr(&subdir_buf, subdir->string);
> +		list_contents_of_dir(&objects, &subdir_buf, 0, 0);
> +		strbuf_addf(obj_info, "%s: %d objects\n", subdir->string,
> +			    objects.nr);

Hmm. Not only does this leak `objects`, it also throws away the contents
that we so painfully constructed.

Wouldn't it make more sense to do something like this instead?

static int is_hex(const char *string, size_t count)
{
	for (; count; string++, count--)
		if (hexval(*string) < 0)
			return 0;
	return 1;
}

static ssize_t count_loose_objects(struct strbuf *objects_path)
{
	ssize_t ret =3D 0;
	size_t len;
	struct dirent *d;
	DIR *dir, *subdir;

	dir =3D opendir(objects_path->buf);
	if (!dir)
		return -1;

	strbuf_complete(objects_path, '/');
	len =3D objects_path->len;
	while ((d =3D readdir(dir))) {
		if (d->d_type !=3D DT_DIR)
			continue;
		strbuf_setlen(objects_path, len);
		strbuf_addstr(objects_path, d->d_name);
		subdir =3D opendir(objects_path->buf);
		if (!subdir)
			continue;
		while ((d =3D readdir(subdir)))
			if (d->dt_type =3D=3D DT_REG &&
			    is_hex(dir->d_name, the_repository->hash_algo->hexsz))
				ret++;
		closedir(subdir);
	}
	closedir(dir);
	strbuf_reset(objects_path, len);
	return ret;
}

Ciao,
Dscho

> +	}
> +}
> diff --git a/bugreport.h b/bugreport.h
> index 942a5436e3..09ad0c2599 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -18,3 +18,9 @@ void get_whitelisted_config(struct strbuf *sys_info);
>   * contents of hook_info will be discarded.
>   */
>  void get_populated_hooks(struct strbuf *hook_info);
> +
> +/**
> + * Adds the output of `git count-object -vH`. The previous contents of =
hook_info
> + * will be discarded.
> + */
> +void get_loose_object_summary(struct strbuf *obj_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index a0eefba498..b2ab194207 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -64,6 +64,10 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_populated_hooks(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Object Counts");
> +	get_loose_object_summary(&buffer);
> +	strbuf_write(&buffer, report);
> +
>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
