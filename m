Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B071F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeGaUFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:05:31 -0400
Received: from mout.web.de ([212.227.15.4]:39969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbeGaUFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:05:31 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfEfA-1gHP4r3mjg-00oos5; Tue, 31
 Jul 2018 20:23:45 +0200
Date:   Tue, 31 Jul 2018 20:23:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180731182344.GA3286@tor.lan>
References: <20180729092759.GA14484@sigill.intra.peff.net>
 <20180730152756.15012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730152756.15012-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:BHJQZ9QDEt0Ypi9OUZOe1gUYWCc9PJ4U6MTQGo1n8Y2emgcA2D4
 t0M5ZB3pxxep1mazRxL7aRLLAJQVNf+eT+Vn3Bsq/PNKIgORBZFLy9mUJ/rCohnOs9nxF3Q
 p6Ryn0Q8wWuCfpp1Cyn2YbUQ8R5wEkyu6y5Iq3nubsZtNZ4tUyE2mlD2PprsRDHiWk2kwl9
 /HIP5CIhdi2TcZzlFty0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xHFIb/9sC5I=:LDNsA3UnNe/N+fYBPkb6fx
 rFKykDRhPrAjrKtTXyfM1guuqeBO+Z0aOjsCQ9QITQMMXnUDVBK2X4aZAhzBErZbx0an/V/Eo
 K//vA8oJj4vbhEqtKLBJ/U4ukycSEaHhV1bz5QW+g8U38Uo+fiN5EtIzpZ+B7cR8Ywc35SzSa
 P2La6qIPby2U7JQj7zBARRlSGEfvfrvgQ96vonwd2uuThAb5q78k9AZkIKIl0hrWC2E6q9vHn
 t26qzkJp1kINXa9nFKcf8ZFdi+bfbuS9arfWXLEpVnCjeD7PlpzMhRoWU8j7VV6pm6ceKyGjj
 j10mj4Rig8EXNJSSpozeRxI4MwMUKRFbki2D2rdGWwqK1skOB7EFKCTKzl1wKAlAQIysxfk9l
 pNjTUvnMhI1CbbEUGBekAAr/NAwvVoQK0kw7QBGw6NqGDHErLIx7CH5Z3w0HHfzr1nZNcd3lP
 4h7YObiFFaJYkfdYR/avL6PWB2GV1Ao3VxGb2MwLUSxR5BvJcN0jULIYBQ1W9iHDTRCLaaX4M
 ck2V9zP/Yx2qu9hY6mqUFIRfUVK9jRxbhiDaTVAccOta2BfGPhDDB5kxviRlsE0OLuQO+TBhW
 4kxEWEqOsGW8V7ixSXq8mwPGjaVGTNRRab8g5KzUfNANykpdPyUHYcXk58zmJQRZnQgImz4+k
 pL0hdXryS79jGtAQPayGUrHS1fud/n1wixhYO5x95Wb1qnkP0x6M6G0cRfQOmB6GQqQ0K+bVo
 UezwCbAxLwX4zdPMzmniQwmb2Q1NoaPTKbgOvAsSd2hXCL2r1SUo+4AwVio=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 05:27:55PM +0200, Nguyễn Thái Ngọc Duy wrote:
> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what's exactly is "dirty".
> 
> This patch helps the situation a bit by pointing out the problem at
> clone time. I have not suggested any way to work around or fix this
> problem. But I guess we could probably have a section in
> Documentation/ dedicated to this problem and point there instead of
> a long advice in this warning.
> 
> Another thing we probably should do is catch in "git checkout" too,
> not just "git clone" since your linux/unix colleage colleague may
> accidentally add some files that your mac/windows machine is not very
> happy with. But then there's another problem, once the problem is
> known, we probably should stop spamming this warning at every
> checkout, but how?
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/clone.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5c439f1394..32738c2737 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -711,6 +711,33 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  	}
>  }
>  
> +static void find_duplicate_icase_entries(struct index_state *istate,
> +					 struct string_list *dup)
> +{
> +	struct string_list list = STRING_LIST_INIT_NODUP;
> +	int i;
> +
> +	for (i = 0; i < istate->cache_nr; i++)
> +		string_list_append(&list, istate->cache[i]->name);
> +
> +	list.cmp = fspathcmp;
> +	string_list_sort(&list);
> +
> +	for (i = 1; i < list.nr; i++) {
> +		const char *cur = list.items[i].string;
> +		const char *prev = list.items[i - 1].string;
> +
> +		if (dup->nr &&
> +		    !fspathcmp(cur, dup->items[dup->nr - 1].string)) {
> +			string_list_append(dup, cur);
> +		} else if (!fspathcmp(cur, prev)) {
> +			string_list_append(dup, prev);
> +			string_list_append(dup, cur);
> +		}
> +	}
> +	string_list_clear(&list, 0);
> +}
> +
>  static int checkout(int submodule_progress)
>  {
>  	struct object_id oid;
> @@ -761,6 +788,20 @@ static int checkout(int submodule_progress)
>  	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>  
> +	if (ignore_case) {
> +		struct string_list dup = STRING_LIST_INIT_DUP;
> +		int i;
> +
> +		find_duplicate_icase_entries(&the_index, &dup);
> +		if (dup.nr) {
> +			warning(_("the following paths in this repository only differ in case and will\n"
> +				  "cause problems because you have cloned it on an case-insensitive filesytem:\n"));

Thanks for the patch.
I wonder if we can tell the users more about the "problems"
and how to avoid them, or to live with them.

This is more loud thinking:

"The following paths only differ in case\n"
"One a case-insensitive file system only one at a time can be present\n"
"You may rename one like this:\n"
"git checkout <file> && git mv <file> <file>.1\n"

> +				fprintf(stderr, "\t%s\n", dup.items[i].string);

Another question:
Do we need any quote_path() here ?
(This may be overkill, since typically the repos with conflicting names
only use ASCII.)

> +		}
> +		string_list_clear(&dup, 0);
> +	}
> +
>  	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>  			   oid_to_hex(&oid), "1", NULL);
>  
> -- 
> 2.18.0.656.gda699b98b3
> 
