Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0EF203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcGVWdd (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 18:33:33 -0400
Received: from mout.web.de ([212.227.17.12]:56992 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbcGVWdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 18:33:32 -0400
Received: from [192.168.0.52] ([24.48.64.236]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MTyDl-1brV5K3YnJ-00QjfX; Sat, 23 Jul 2016 00:33:20
 +0200
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
Cc:	peff@peff.net, jnareb@gmail.com
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <32d8feda-0fff-6c8c-1ac3-9cc3d783d0ef@web.de>
Date:	Sat, 23 Jul 2016 00:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160722154900.19477-4-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:epapKjoHxMl8ono/sTMvGGD6hS4YmshHOnONt/d+aV7zJjHLXgC
 WcShf6u25jfcR+Os1mlyDvE1VKhHA027GoYEHO3wE99Seg7rgWnMofSQigPKQw1SDuTcmIy
 xX8MoskyMUur7sR2X1L0P+xqaNZqWGsMD1BEkZO4HNDr1JRkaf40adOXrzl1QCyfhLQU9Yi
 Mq7pdBJy02IOfAC/imnJQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:spq40MTvLAQ=:F/D81rvFhwI3zyksNhEOST
 JCH91tdCwuSVC35uMuYnRov4fxCCLW8CfLNkatzw56FRtlb9CGlhTpa/N+3fKkGyNF4vtpXsR
 OePu6u/6pKkDdZUM3p/1MlZ0+1pqElzHLuoFj88fSW2E6eo7y9zo/yaZDOMM57RJi+habR3KC
 odIVlJHQ2ld2BQLrrwhYM116IItgxgo6JtDo96B4ZHaFviBJw3lar6jDtBp/jM+qscfkhrJCu
 +2xBZB+FHxqCxCtD4ny4GElriGS7eAX+Az/eEsGb3O8r4pynZZ5cdN2nlurHBIrqXPM9I4PZA
 7uNu1oLf3Tz+LAAcHvo5Btflytci7wxhxFWOBpundWi3chaM+IUwSK077BK5LZOJQrPYRQ+NX
 0CNQ/BesyjN0x5GLqMHEo+Z8S8+hI0Ju/A2r4uJ8rA7ApVN6eIk37lLvH4ow8ROdLrs/TF9gG
 6WRX8TJ4ULqekyQ684SfoVdGC7h/2JsyewqYrOLKA6z7n7K9N5FT+bC1fe8haBPbg3wa3w88b
 OP0ZSeT8WnCwrSQHgM6EMU8LP+H57Zg3c0M0sjwDCSkoQtMOXdnuJ2iOfjRJAZDFiYjn1Ik6Z
 rk7/LuCDL9cwwgIgHghgc1laniMKSuDhlh4jh776yGATJjqr/zm1IGwUW7ujonPMxKQYykBhf
 B2Bcpc9Hb/NJ8WObFLkbqgyV9cW7sZtxzCxSOYLVWwKNl5Hk6PemyMVpx5Uc+uGREhjjECYCM
 Oh5xozhpgzl2J0KyhhTizZq812cIDE1Rbz51fMeYQatTJ66yJtiB1bChJqUyWlP5xikCBc0NK
 O/2iU5j
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/22/2016 05:49 PM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Git's clean/smudge mechanism invokes an external filter process for every
> single blob that is affected by a filter. If Git filters a lot of blobs
> then the startup time of the external filter processes can become a
> significant part of the overall Git execution time.
>
> This patch adds the filter.<driver>.useProtocol option which, if enabled,
> keeps the external filter process running and processes all blobs with
> the following protocol over stdin/stdout.
>
> 1. Git starts the filter on first usage and expects a welcome message
> with protocol version number:
> 	Git <-- Filter: "git-filter-protocol\n"
> 	Git <-- Filter: "version 1"
Is there no terminator here ?
How long should the reading side wait without a '\n', or should it read
"version 1\n" ?

>
> 2. Git sends the command (either "smudge" or "clean"), the filename, the
> content size in bytes, and the content separated by a newline character:
> 	Git --> Filter: "smudge\n"
> 	Git --> Filter: "testfile.dat\n"
> 	Git --> Filter: "7\n"
> 	Git --> Filter: "CONTENT"
>
> 3. The filter is expected to answer with the result content size in
> bytes and the result content separated by a newline character:
> 	Git <-- Filter: "15\n"
> 	Git <-- Filter: "SMUDGED_CONTENT"
>
> 4. The filter is expected to wait for the next file in step 2, again.
>
> Please note that the protocol filters do not support stream processing
> with this implemenatation because the filter needs to know the length of
             ^^^^^^^^^^^^^^^^typo
> the result in advance. A protocol version 2 could address this in a
> future patch.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> ---
>  Documentation/gitattributes.txt |  41 +++++++-
>  convert.c                       | 210 ++++++++++++++++++++++++++++++++++++++--
>  t/t0021-conversion.sh           | 170 ++++++++++++++++++++++++++++++++
>  t/t0021/rot13.pl                |  80 +++++++++++++++
>  4 files changed, 494 insertions(+), 7 deletions(-)
>  create mode 100755 t/t0021/rot13.pl
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 8882a3e..7026d62 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -300,7 +300,10 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate. If the setting filter.<driver>.useProtocol is
> +enabled then Git can process all blobs with a single filter command
> +invocation (see filter protocol below).
>
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -375,6 +378,42 @@ substitution.  For example:
>  ------------------------
>
>
> +Filter Protocol
> +^^^^^^^^^^^^^^^
> +
> +If the setting filter.<driver>.useProtocol is enabled then Git
> +can process all blobs with a single filter command invocation
> +by talking with the following protocol over stdin/stdout.
> +
> +Git starts the filter on first usage and expects a welcome
> +message with protocol version number:
> +------------------------
> +Git < Filter: "git-filter-protocol\n"
> +Git < Filter: "version 1"
> +------------------------
> +
> +Afterwards Git sends a blob command (either "smudge" or "clean"),
> +the filename, the content size in bytes, and the content separated
> +by a newline character:
> +------------------------
> +Git > Filter: "smudge\n"
> +Git > Filter: "testfile.dat\n"
> +Git > Filter: "7\n"
> +Git > Filter: "CONTENT"
> +------------------------
> +
> +The filter is expected to answer with the result content size in
> +bytes and the result content separated by a newline character:
> +------------------------
> +Git < Filter: "15\n"
> +Git < Filter: "SMUDGED_CONTENT"
> +------------------------
> +
> +Afterwards the filter is expected to wait for the next blob process
> +command. A demo implementation can be found in `t/t0021/rot13.pl`
> +located in the Git core repository.
> +
> +
>  Interaction between checkin/checkout attributes
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> diff --git a/convert.c b/convert.c
> index 522e2c5..91ce86f 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -481,12 +481,188 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return ret;
>  }
>
> +static int cmd_process_map_init = 0;
> +static struct hashmap cmd_process_map;
> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	const char *cmd;
> +	long protocol;
> +	struct child_process process;
> +};
> +
> +static int cmd2process_cmp(const struct cmd2process *e1,
> +							const struct cmd2process *e2,
> +							const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}
> +
> +static struct cmd2process *find_protocol_filter_entry(const char *cmd)
> +{
> +	struct cmd2process k;
> +	hashmap_entry_init(&k, strhash(cmd));
> +	k.cmd = cmd;
> +	return hashmap_get(&cmd_process_map, &k, NULL);
> +}
> +
> +static void stop_protocol_filter(struct cmd2process *entry) {
> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);
> +	child_process_clear(&entry->process);
> +	hashmap_remove(&cmd_process_map, entry, NULL);
> +	free(entry);
> +}
> +
> +static struct cmd2process *start_protocol_filter(const char *cmd)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry = NULL;
> +	struct child_process *process = NULL;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	struct string_list split = STRING_LIST_INIT_NODUP;
> +	const char *argv[] = { NULL, NULL };
> +	const char *header = "git-filter-protocol\nversion";
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	argv[0] = cmd;
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external persistent filter '%s'", cmd);
> +		return NULL;
> +	}
> +	strbuf_reset(&nbuf);
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
> +	sigchain_pop(SIGPIPE);
> +
> +	strbuf_stripspace(&nbuf, 0);
> +	string_list_split_in_place(&split, nbuf.buf, ' ', 2);
> +	ret &= split.nr > 1;
> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;
> +	if (ret) {
> +		entry->protocol = strtol(split.items[1].string, NULL, 10);
> +		switch (entry->protocol) {
> +			case 1:
> +				break;
> +			default:
> +				ret = 0;
> +				error("unsupported protocol version %s for external persistent filter '%s'",
> +					nbuf.buf, cmd);
> +		}
> +	}
> +	string_list_clear(&split, 0);
> +	strbuf_release(&nbuf);
> +
> +	if (!ret) {
> +		error("initialization for external persistent filter '%s' failed", cmd);
> +		return NULL;
> +	}
> +
> +	hashmap_add(&cmd_process_map, entry);
> +	return entry;
> +}
> +
> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> +						int fd, struct strbuf *dst, const char *cmd,
> +						const char *filter_type)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry = NULL;
> +	struct child_process *process = NULL;
> +	struct stat fileStat;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	size_t nbuf_len;
> +	char *strtol_end;
> +	char c;
> +
> +	if (!cmd || !*cmd)
> +		return 0;
> +
> +	if (!dst)
> +		return 1;
> +
> +	if (!cmd_process_map_init) {
> +		cmd_process_map_init = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +	} else {
> +		entry = find_protocol_filter_entry(cmd);
> +	}
> +
> +	if (!entry){
> +		entry = start_protocol_filter(cmd);
> +		if (!entry) {
> +			stop_protocol_filter(entry);
> +			return 0;
> +		}
> +	}
> +	process = &entry->process;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	switch (entry->protocol) {
> +		case 1:
> +			if (fd >= 0 && !src) {
> +				ret &= fstat(fd, &fileStat) != -1;
> +				len = fileStat.st_size;
> +			}
> +			strbuf_reset(&nbuf);
> +			strbuf_addf(&nbuf, "%s\n%s\n%zu\n", filter_type, path, len);
> +			ret &= write_str_in_full(process->in, nbuf.buf) > 1;
> +			if (len > 0) {
> +				if (src)
> +					ret &= write_in_full(process->in, src, len) == len;
> +				else if (fd >= 0)
> +					ret &= copy_fd(fd, process->in) == 0;
> +				else
> +					ret &= 0;
> +			}
> +
> +			strbuf_reset(&nbuf);
> +			while (xread(process->out, &c, 1) == 1 && c != '\n')
> +				strbuf_addchars(&nbuf, c, 1);
> +			nbuf_len = (size_t)strtol(nbuf.buf, &strtol_end, 10);
> +			ret &= (strtol_end != nbuf.buf && errno != ERANGE);
> +			strbuf_reset(&nbuf);
> +			if (nbuf_len > 0)
> +				ret &= strbuf_read_once(&nbuf, process->out, nbuf_len) == nbuf_len;
> +			break;
> +		default:
> +			ret = 0;
> +	}
> +	sigchain_pop(SIGPIPE);
> +
> +	if (ret) {
> +		strbuf_swap(dst, &nbuf);
> +	} else {
> +		// Something went wrong with the protocol filter. Force shutdown!
> +		stop_protocol_filter(entry);
> +	}
> +	strbuf_release(&nbuf);
> +	return ret;
> +}
> +
>  static struct convert_driver {
>  	const char *name;
>  	struct convert_driver *next;
>  	const char *smudge;
>  	const char *clean;
>  	int required;
> +	int use_protocol;
>  } *user_convert, **user_convert_tail;
>
>  static int read_convert_config(const char *var, const char *value, void *cb)
> @@ -526,6 +702,11 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>  	if (!strcmp("clean", key))
>  		return git_config_string(&drv->clean, var, value);
>
> +	if (!strcmp("useprotocol", key)) {
> +		drv->use_protocol = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp("required", key)) {
>  		drv->required = git_config_bool(var, value);
>  		return 0;
> @@ -823,7 +1004,10 @@ int would_convert_to_git_filter_fd(const char *path)
>  	if (!ca.drv->required)
>  		return 0;
>
> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> +	if (ca.drv->use_protocol)
> +		return apply_protocol_filter(path, NULL, 0, -1, NULL, ca.drv->clean, "clean");
> +	else
> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>  }
>
>  const char *get_convert_attr_ascii(const char *path)
> @@ -857,16 +1041,20 @@ int convert_to_git(const char *path, const char *src, size_t len,
>  {
>  	int ret = 0;
>  	const char *filter = NULL;
> -	int required = 0;
> +	int required = 0, use_protocol = 0;
>  	struct conv_attrs ca;
>
>  	convert_attrs(&ca, path);
>  	if (ca.drv) {
>  		filter = ca.drv->clean;
>  		required = ca.drv->required;
> +		use_protocol = ca.drv->use_protocol;
>  	}
>
> -	ret |= apply_filter(path, src, len, -1, dst, filter);
> +	if (use_protocol)
> +		ret |= apply_protocol_filter(path, src, len, -1, dst, filter, "clean");
> +	else
> +		ret |= apply_filter(path, src, len, -1, dst, filter);
>  	if (!ret && required)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>
> @@ -885,13 +1073,19 @@ int convert_to_git(const char *path, const char *src, size_t len,
>  void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
>  			      enum safe_crlf checksafe)
>  {
> +	int ret = 0;
>  	struct conv_attrs ca;
>  	convert_attrs(&ca, path);
>
>  	assert(ca.drv);
>  	assert(ca.drv->clean);
>
> -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
> +	if (ca.drv->use_protocol)
> +		ret = apply_protocol_filter(path, NULL, 0, fd, dst, ca.drv->clean, "clean");
> +	else
> +		ret = apply_filter(path, NULL, 0, fd, dst, ca.drv->clean);
> +
> +	if (!ret)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>
>  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
> @@ -904,13 +1098,14 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  {
>  	int ret = 0, ret_filter = 0;
>  	const char *filter = NULL;
> -	int required = 0;
> +	int required = 0, use_protocol = 0;
>  	struct conv_attrs ca;
>
>  	convert_attrs(&ca, path);
>  	if (ca.drv) {
>  		filter = ca.drv->smudge;
>  		required = ca.drv->required;
> +		use_protocol = ca.drv->use_protocol;
>  	}
>
>  	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
> @@ -930,7 +1125,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  		}
>  	}
>
> -	ret_filter = apply_filter(path, src, len, -1, dst, filter);
> +	if (use_protocol)
> +		ret_filter = apply_protocol_filter(path, src, len, -1, dst, filter, "smudge");
> +	else
> +		ret_filter |= apply_filter(path, src, len, -1, dst, filter);
>  	if (!ret_filter && required)
>  		die("%s: smudge filter %s failed", path, ca.drv->name);
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index a05a8d2..d9077ea 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -268,4 +268,174 @@ test_expect_success 'disable filter with empty override' '
>  	test_must_be_empty err
>  '
>
> +test_expect_success 'required protocol filter should filter data' '
> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.useprotocol true &&
> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		git branch empty &&
> +
> +		cat ../test.o >test.r &&
> +		echo "test22" >test2.r &&
> +		echo "test333" >test3.r &&
> +
> +		rm -f output.log &&
> +		git add . &&
> +		sort output.log | uniq -c | sed "s/^[ ]*//" >uniq_output.log &&
> +		cat >expected_add.log <<-\EOF &&
> +			1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
> +			1 IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
> +			1 IN: clean test3.r 8 [OK] -- OUT: 8 [OK]
> +			1 start
> +			1 wrote version
> +		EOF
> +		test_cmp expected_add.log uniq_output.log &&
> +
> +		printf "" >output.log &&
> +		git commit . -m "test commit" &&
> +		sort output.log | uniq -c | sed "s/^[ ]*//" |
> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq_output.log &&
> +		cat >expected_commit.log <<-\EOF &&
> +			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
> +			x IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
> +			x IN: clean test3.r 8 [OK] -- OUT: 8 [OK]
> +			1 start
> +			1 wrote version
> +		EOF
> +		test_cmp expected_commit.log uniq_output.log &&
> +
> +		printf "" >output.log &&
> +		rm -f test?.r &&
> +		git checkout . &&
> +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
> +		cat >expected_checkout.log <<-\EOF &&
> +			start
> +			wrote version
> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
> +			IN: smudge test3.r 8 [OK] -- OUT: 8 [OK]
> +		EOF
> +		test_cmp expected_checkout.log smudge_output.log &&
> +
> +		git checkout empty &&
> +
> +		printf "" >output.log &&
> +		git checkout master &&
> +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
> +		cat >expected_checkout_master.log <<-\EOF &&
> +			start
> +			wrote version
> +			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
> +			IN: smudge test3.r 8 [OK] -- OUT: 8 [OK]
> +		EOF
> +		test_cmp expected_checkout_master.log smudge_output.log
> +	)
> +'
> +
> +test_expect_success EXPENSIVE 'protocol filter large file' '
> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "2GB filter=largefile" >.gitattributes &&
> +		for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
Side question:
Is there a way to "re-use" the 2GB test file through t0021?
It takes a long time to produce it, especially on my 32 Bit systems ;-)
But this may be a different patch.

> +		git add 2GB 2>err &&
> +		test_must_be_empty err &&
> +		rm -f 2GB &&
> +		git checkout -- 2GB 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
> +test_expect_success 'required protocol filter should fail with clean' '
> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.useprotocol true &&
> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cat ../test.o >test.r &&
> +		echo "this is going to fail" >clean-write-fail.r &&
> +		echo "test333" >test3.r &&
> +
> +		# Note: There are three clean paths in convert.c we just test one here.
> +		test_must_fail git add .
> +	)
> +'
> +
> +test_expect_success 'protocol filter should restart after failure' '
> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> +	test_config_global filter.protocol.useprotocol true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +
> +		cat ../test.o >test.r &&
> +		echo "1234567" >test2.o &&
> +		cat test2.o >test2.r &&
> +		echo "this is going to fail" >smudge-write-fail.o &&
> +		cat smudge-write-fail.o >smudge-write-fail.r &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		rm -f *.r &&
> +
> +		printf "" >output.log &&
Is this the same as
 >output.log
to produce an empty file ?

> +		git checkout . &&
> +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
> +		cat >expected_checkout_master.log <<-\EOF &&
> +			start
> +			wrote version
> +			IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [FAIL]
> +			start
> +			wrote version
> +			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
> +			IN: smudge test2.r 8 [OK] -- OUT: 8 [OK]
> +		EOF
> +		test_cmp expected_checkout_master.log smudge_output.log &&
> +
> +		test_cmp ../test.o test.r &&
> +		./../rot13.sh <../test.o >expected &&
> +		git cat-file blob :test.r >actual &&
> +		test_cmp expected actual
> +
> +		test_cmp test2.o test2.r &&
> +		./../rot13.sh <test2.o >expected &&
> +		git cat-file blob :test2.r >actual &&
> +		test_cmp expected actual
> +
> +		test_cmp test2.o test2.r &&
> +		./../rot13.sh <test2.o >expected &&
> +		git cat-file blob :test2.r >actual &&
> +		test_cmp expected actual
> +
> +		! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
> +		./../rot13.sh <smudge-write-fail.o >expected &&
> +		git cat-file blob :smudge-write-fail.r >actual &&
> +		test_cmp expected actual							  # Clean worked!
> +	)
> +'
> +
>  test_done
> diff --git a/t/t0021/rot13.pl b/t/t0021/rot13.pl
> new file mode 100755
> index 0000000..f2d7a03
> --- /dev/null
> +++ b/t/t0021/rot13.pl
> @@ -0,0 +1,80 @@
> +#!/usr/bin/env perl
Should this be
"$PERL_PATH" ?
And do we need to protect the TC with
test_have_prereq PERL or similar ?


An other solution could be to write a filter in C-language.
> +#
> +# Example implementation for the Git filter protocol version 1
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +
> +use strict;
> +use warnings;
> +use autodie;
> +
> +sub rot13 {
> +    my ($str) = @_;
> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
> +    return $str;
> +}
> +
> +$| = 1; # autoflush STDOUT
> +
> +open my $debug, ">>", "output.log";
> +$debug->autoflush(1);
> +
> +print $debug "start\n";
> +
> +print STDOUT "git-filter-protocol\nversion 1";
Again, I don't like the missing terminator here.
What if we step up to protocol "version 10" ?
Could it work to use one and only one line,
with one terminator, like this ?
print STDOUT "git-filter-protocol version 1\1";
> +print $debug "wrote version\n";
> +
> +while (1) {
> +    my $command = <STDIN>;
> +    unless (defined($command)) {
> +        exit();
> +    }
> +    chomp $command;
> +    print $debug "IN: $command";
> +    my $filename = <STDIN>;
> +    chomp $filename;
> +    print $debug " $filename";
> +    my $filelen  = <STDIN>;
> +    chomp $filelen;
> +    print $debug " $filelen";
> +
> +    $filelen = int($filelen);
> +    my $output;
> +
> +    if ( $filelen > 0 ) {
> +        my $input;
> +        {
> +            binmode(STDIN);
> +            my $bytes_read = 0;
> +            $bytes_read = read STDIN, $input, $filelen;
> +            if ( $bytes_read != $filelen ) {
> +                die "not enough to read";
> +            }
> +            print $debug " [OK] -- ";
> +        }
> +
> +        if ( $command eq "clean") {
> +            $output = rot13($input);
> +        }
> +        elsif ( $command eq "smudge" ) {
> +            $output = rot13($input);
> +        }
> +        else {
> +            die "bad command\n";
> +        }
> +    }
> +
> +    my $output_len = length($output);
> +    print STDOUT "$output_len\n";
> +    print $debug "OUT: $output_len";
> +    if ( $output_len > 0 ) {
> +        if ( ($command eq "clean" and $filename eq "clean-write-fail.r") or
> +             ($command eq "smudge" and $filename eq "smudge-write-fail.r") ) {
> +            print STDOUT "fail";
> +            print $debug " [FAIL]\n"
> +        } else {
> +            print STDOUT $output;
> +            print $debug " [OK]\n";
> +        }
> +    }
> +}
>
