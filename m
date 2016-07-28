Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C2C1F859
	for <e@80x24.org>; Thu, 28 Jul 2016 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbcG1Kd3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 06:33:29 -0400
Received: from mout.web.de ([212.227.17.12]:53073 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbcG1Kd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 06:33:27 -0400
Received: from [172.20.0.236] ([207.179.142.2]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MA5qv-1bZ4Hg3Z73-00BK3z; Thu, 28 Jul 2016 12:32:58
 +0200
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <df979c36-d8a8-8074-bddc-f67b245e1589@web.de>
Date:	Thu, 28 Jul 2016 12:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160727000605.49982-6-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SgKqhHdWjH9XtcYtiGz8ur9tuz4PD0aPEFEHFTeEbJt5ppNTrYm
 DeRpAZHUKJYMwWWMm9Vj4HRhNPS+JeeUGPKRJ33ya2W1+kfj9xADLNc37sE0SvfJSqDAcak
 MbQQ1ctEZKkJDPxxXA+SC+WQfS5cQjttYsK/N1/PJC2gG5ZycGaSbjW1mzKcn0egWEC0CL2
 yg4BohNNlopYdTdjO4tmA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:v+yc+a6/bao=:CIs74GpvXfQa5XOiQ5R/od
 98xsDogr9jhlmAOkcY7wNir3g0ve/5qjDlPfVNKbSoZ25Zg8D+NWyWFLrRObg0ai04GOLoKw0
 TmEChx1VKBoNJTKYbDkDk4GJLnVeo2TgvD7Otea+jQ5RQ0LAtw+eJVVO04jkzKF07AG/0nuXv
 Q2+8KId3heHL/qoluuoNHxgGzNghpRwg7rizIQquWSQqhlHKoX6WWo++EJ5BHo/A71qqGdGQ3
 PbZbXQZUuzcmyFX0J18Tr/L1rP88eWTWfHK8VNmqofGRao3ye8aLmAtLrH/vh2Y8oGH4OyWwk
 Hdix+C1jLDVgcp6Xt4j0Q0mvGoqF2nMQA5i9M3yoeyukOXeFzUM8R6XGCteUzCYLUYn4VLjMj
 Xx4JSdwi8mh12t5v+2lnWeSy7bAGXNK5FGEmtD95FDNgfbRQ+EujOTqzyl4Q6uaagNeLupIJO
 ClXyYH+u6bsXZCR9eOABBdPiE28hxbPXpwnMyXwacYWF9UAkDIXmSoAEhY64TQfKYWQqwUu6r
 P1E4A+U4VfSKs8LjN7KO8XaqRDoNuC2nma8mENbGYm2VTB+2C9z9Jn8uMn8+yhYRSVH5h1Utn
 QxsAJHWhZRPPu/MIH4y9aaDapHfQ7SxOUbLQHJqU0Ma//rUi26WvuoIZ7fwN7CV62McjIHOpb
 FxPVTkakUsSDV1DMNxxKVopR4d/R1X9cGm4Vzai2S1iZ8Ckzj2aJrqKJNzqNdZhVWthvy5/UK
 ome/GUxg3arWbVuYQ/n+u8omPbQAJ+R3mt33dZoJPCukdPklfALjBrzGBnC8EO0/aV8pkJpbL
 wRhShNq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 07/27/2016 02:06 AM, larsxschneider@gmail.com wrote:
Some comments inline
[]
 > The filter is expected to respond with the result content size as
 > ASCII number in bytes and the result content in packet format with
 > a flush packet at the end:
 > ------------------------
 > packet:          git< 57
 > packet:          git< SMUDGED_CONTENT
 > packet:          git< 0000
how does the filter report possible errors here ?
Let's say I want to convert UTF-8 into ISO-8859-1,
but the conversion is impossible.

  > packet:          git< -1
  > packet:          git< Error message, (or empty), followed by a '\n'
  > packet:          git< 0000

Side note: a filter may return length 0.
Suggestion: add 2 test cases.


 > ------------------------
 > Please note: In a future version of Git the capability "stream"
 > might be supported. In that case the content size must not be
 > part of the filter response.
 >
 > Afterwards the filter is expected to wait for the next command.
 >
 > Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
 > Helped-by: Martin-Louis Bright <mlbright@gmail.com>
 > Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
 > ---
 >  Documentation/gitattributes.txt |  54 +++++++-
 >  convert.c                       | 269 
++++++++++++++++++++++++++++++++++++++--
 >  t/t0021-conversion.sh           | 175 ++++++++++++++++++++++++++
 >  t/t0021/rot13-filter.pl         | 146 ++++++++++++++++++++++
 >  4 files changed, 631 insertions(+), 13 deletions(-)
 >  create mode 100755 t/t0021/rot13-filter.pl
 >
 > diff --git a/Documentation/gitattributes.txt 
b/Documentation/gitattributes.txt
 > index 8882a3e..8fb40d2 100644
 > --- a/Documentation/gitattributes.txt
 > +++ b/Documentation/gitattributes.txt
 > @@ -300,7 +300,11 @@ checkout, when the `smudge` command is 
specified, the command is
 >  fed the blob object from its standard input, and its standard
 >  output is used to update the worktree file.  Similarly, the
 >  `clean` command is used to convert the contents of worktree file
 > -upon checkin.
 > +upon checkin. By default these commands process only a single
 > +blob and terminate. If a long running filter process (see section
 > +below) is used then Git can process all blobs with a single filter
 > +invocation for the entire life of a single Git command (e.g.
 > +`git add .`).
 >
 >  One use of the content filtering is to massage the content into a shape
 >  that is more convenient for the platform, filesystem, and the user 
to use.
 > @@ -375,6 +379,54 @@ substitution.  For example:
 >  ------------------------
 >
 >
 > +Long Running Filter Process
 > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > +
 > +If the filter command (string value) is defined via
 > +filter.<driver>.process then Git can process all blobs with a
 > +single filter invocation for the entire life of a single Git
 > +command by talking with the following packet format (pkt-line)
 > +based protocol over standard input and standard output.
 > +
 > +Git starts the filter on first usage and expects a welcome
 > +message, protocol version number, and filter capabilities
 > +seperated by spaces:
 > +------------------------
 > +packet:          git< git-filter-protocol
 > +packet:          git< version 2
 > +packet:          git< clean smudge
 > +------------------------
 > +Supported filter capabilities are "clean" and "smudge".
 > +
 > +Afterwards Git sends a command (e.g. "smudge" or "clean" - based
 > +on the supported capabilities), the filename, the content size as
 > +ASCII number in bytes, and the content in packet format with a
 > +flush packet at the end:
 > +------------------------
 > +packet:          git> smudge
 > +packet:          git> testfile.dat
 > +packet:          git> 7
 > +packet:          git> CONTENT
 > +packet:          git> 0000
 > +------------------------
 > +
 > +The filter is expected to respond with the result content size as
 > +ASCII number in bytes and the result content in packet format with
 > +a flush packet at the end:
 > +------------------------
 > +packet:          git< 57
 > +packet:          git< SMUDGED_CONTENT
 > +packet:          git< 0000
 > +------------------------
 > +Please note: In a future version of Git the capability "stream"
 > +might be supported. In that case the content size must not be
 > +part of the filter response.
 > +
 > +Afterwards the filter is expected to wait for the next command.
 > +A demo implementation can be found in `t/t0021/rot13-filter.pl`
 > +located in the Git core repository.
 > +
 > +
 >  Interaction between checkin/checkout attributes
 >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 >
 > diff --git a/convert.c b/convert.c
 > index 522e2c5..5ff200b 100644
 > --- a/convert.c
 > +++ b/convert.c
 > @@ -3,6 +3,7 @@
 >  #include "run-command.h"
 >  #include "quote.h"
 >  #include "sigchain.h"
 > +#include "pkt-line.h"
 >
 >  /*
 >   * convert.c - convert a file when checking it out and checking it in.
 > @@ -481,11 +482,232 @@ static int apply_filter(const char *path, 
const char *src, size_t len, int fd,
 >  	return ret;
 >  }
 >
 > +static off_t multi_packet_read(struct strbuf *sb, const int fd, 
const size_t size)
 > +{
 > +	off_t bytes_read;
 > +	off_t total_bytes_read = 0;
 > +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet 
flush
 > +	do {
 > +		bytes_read = packet_read(
 > +			fd, NULL, NULL,
 > +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
 > +			PACKET_READ_GENTLE_ON_EOF
 > +		);
 > +		total_bytes_read += bytes_read;
 > +	}
 > +	while (
 > +		bytes_read > 0 && 					// the last packet was no flush
 > +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in 
the buffer
 > +	);
 > +	strbuf_setlen(sb, total_bytes_read);
 > +	return total_bytes_read;
 > +}
 > +
 > +static int multi_packet_write(const char *src, size_t len, const int 
in, const int out)
 > +{
 > +	int ret = 1;
 > +	char header[4];
 > +	char buffer[8192];
 > +	off_t bytes_to_write;
 > +	while (ret) {
 > +		if (in >= 0) {
 > +			bytes_to_write = xread(in, buffer, sizeof(buffer));
 > +			if (bytes_to_write < 0)
 > +				ret &= 0;
 > +			src = buffer;
 > +		} else {
 > +			bytes_to_write = len > LARGE_PACKET_MAX - 4 ? LARGE_PACKET_MAX - 
4 : len;
 > +			len -= bytes_to_write;
 > +		}
 > +		if (!bytes_to_write)
 > +			break;
 > +		set_packet_header(header, bytes_to_write + 4);
 > +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
 > +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
 > +	}
 > +	ret &= write_in_full(out, "0000", 4) == 4;
 > +	return ret;
 > +}
 > +
 > +struct cmd2process {
 > +	struct hashmap_entry ent; /* must be the first member! */
 > +	const char *cmd;
 > +	int clean;
 > +	int smudge;
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
 > +static struct cmd2process *find_protocol_filter_entry(struct hashmap 
*hashmap, const char *cmd)
 > +{
 > +	struct cmd2process k;
 > +	hashmap_entry_init(&k, strhash(cmd));
 > +	k.cmd = cmd;
 > +	return hashmap_get(hashmap, &k, NULL);
 > +}
 > +
 > +static void stop_protocol_filter(struct hashmap *hashmap, struct 
cmd2process *entry) {
 > +	if (!entry)
 > +		return;
 > +	sigchain_push(SIGPIPE, SIG_IGN);
 > +	close(entry->process.in);
 > +	close(entry->process.out);
 > +	sigchain_pop(SIGPIPE);
 > +	finish_command(&entry->process);
 > +	child_process_clear(&entry->process);
 > +	hashmap_remove(hashmap, entry, NULL);
 > +	free(entry);
 > +}
 > +
 > +static struct cmd2process *start_protocol_filter(struct hashmap 
*hashmap, const char *cmd)
 > +{
 > +	int ret = 1;
 > +	struct cmd2process *entry;
 > +	struct child_process *process;
 > +	const char *argv[] = { NULL, NULL };
 > +	struct string_list capabilities = STRING_LIST_INIT_NODUP;
 > +	char *capabilities_buffer;
 > +	int i;
 > +
 > +	entry = xmalloc(sizeof(*entry));
 > +	hashmap_entry_init(entry, strhash(cmd));
 > +	entry->cmd = cmd;
 > +	entry->clean = 0;
 > +	entry->smudge = 0;
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
 > +		stop_protocol_filter(hashmap, entry);
 > +		return NULL;
 > +	}
 > +
 > +	sigchain_push(SIGPIPE, SIG_IGN);
 > +	ret &= strcmp(packet_read_line(process->out, NULL), 
"git-filter-protocol") == 0;
 > +	ret &= strcmp(packet_read_line(process->out, NULL), "version 2") == 0;
 > +	capabilities_buffer = packet_read_line(process->out, NULL);
 > +	sigchain_pop(SIGPIPE);
 > +
 > +	string_list_split_in_place(&capabilities, capabilities_buffer, ' ', 
-1);
 > +	for (i = 0; i < capabilities.nr; i++) {
 > +		const char *requested = capabilities.items[i].string;
 > +		if (!strcmp(requested, "clean")) {
 > +			entry->clean = 1;
 > +		} else if (!strcmp(requested, "smudge")) {
 > +			entry->smudge = 1;
 > +		} else {
 > +			warning(
 > +				"filter process '%s' requested unsupported filter capability '%s'",
 > +				cmd, requested
 > +			);
 > +		}
 > +	}
 > +	string_list_clear(&capabilities, 0);
 > +
 > +	if (!ret) {
 > +		error("initialization for external persistent filter '%s' failed", 
cmd);
 > +		stop_protocol_filter(hashmap, entry);
 > +		return NULL;
 > +	}
 > +
 > +	hashmap_add(hashmap, entry);
 > +	return entry;
 > +}
 > +
 > +static int cmd_process_map_init = 0;
 > +static struct hashmap cmd_process_map;
 > +
 > +static int apply_protocol_filter(const char *path, const char *src, 
size_t len,
 > +						int fd, struct strbuf *dst, const char *cmd,
 > +						const char *filter_type)
 > +{
 > +	int ret = 1;
 > +	struct cmd2process *entry;
 > +	struct child_process *process;
 > +	struct stat file_stat;
 > +	struct strbuf nbuf = STRBUF_INIT;
 > +	off_t expected_bytes;
 > +	char *strtol_end;
 > +	char *strbuf;
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
 > +		entry = NULL;
 > +	} else {
 > +		entry = find_protocol_filter_entry(&cmd_process_map, cmd);
 > +	}
 > +
 > +	if (!entry) {
 > +		entry = start_protocol_filter(&cmd_process_map, cmd);
 > +		if (!entry) {
 > +			return 0;
 > +		}
 > +	}
 > +	process = &entry->process;
 > +
 > +	if (!(!strcmp(filter_type, "clean") && entry->clean) &&
 > +		!(!strcmp(filter_type, "smudge") && entry->smudge)) {
 > +		return 0;
 > +	}
 > +
 > +	if (fd >= 0 && !src) {
 > +		ret &= fstat(fd, &file_stat) != -1;
 > +		len = file_stat.st_size;
 > +	}
 > +
 > +	sigchain_push(SIGPIPE, SIG_IGN);
 > +
 > +	packet_write(process->in, "%s\n", filter_type);
 > +	packet_write(process->in, "%s\n", path);
 > +	packet_write(process->in, "%zu\n", len);
%zu is not portable, e.g. Windows
It may be better to cast len to an unsigned int64
and use
packet_write(process->in, "%" PRId64 "\n", (uint64_t)len);

But this is not ideal either, it could be

packet_write(process->in, "%" PRIdMAX "\n", (uintmax_t)len);


 > +	ret &= multi_packet_write(src, len, fd, process->in);
 > +
 > +	strbuf = packet_read_line(process->out, NULL);
 > +	expected_bytes = (off_t)strtol(strbuf, &strtol_end, 10);

A long is 32 bit under Windows. It could be better to use:
   gitstrtodmax (const char *nptr, char **endptr, int base)

 > +	ret &= (strtol_end != strbuf && errno != ERANGE);
 > +
 > +	if (expected_bytes > 0) {
As pointed out earlier, it is possible that the result of
a filter gives a len of 0, which should be handled.


 > +		ret &= multi_packet_read(&nbuf, process->out, expected_bytes) == 
expected_bytes;
 > +	}
 > +
 > +	sigchain_pop(SIGPIPE);
 > +
 > +	if (ret) {
 > +		strbuf_swap(dst, &nbuf);
 > +	} else {
 > +		// Something went wrong with the protocol filter. Force shutdown!
 > +		stop_protocol_filter(&cmd_process_map, entry);

Is there a warning() missing ?
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
 > +	const char *process;
 >  	int required;
 >  } *user_convert, **user_convert_tail;
 >
 > @@ -526,6 +748,10 @@ static int read_convert_config(const char *var, 
const char *value, void *cb)
 >  	if (!strcmp("clean", key))
 >  		return git_config_string(&drv->clean, var, value);
 >
 > +	if (!strcmp("process", key)) {
 > +		return git_config_string(&drv->process, var, value);
 > +	}
 > +
 >  	if (!strcmp("required", key)) {
 >  		drv->required = git_config_bool(var, value);
 >  		return 0;
 > @@ -823,7 +1049,10 @@ int would_convert_to_git_filter_fd(const char 
*path)
 >  	if (!ca.drv->required)
 >  		return 0;
 >
 > -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 > +	if (!ca.drv->clean && ca.drv->process)
 > +		return apply_protocol_filter(path, NULL, 0, -1, NULL, 
ca.drv->process, "clean");
 > +	else
 > +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 >  }
 >
 >  const char *get_convert_attr_ascii(const char *path)
 > @@ -856,17 +1085,22 @@ int convert_to_git(const char *path, const 
char *src, size_t len,
 >                     struct strbuf *dst, enum safe_crlf checksafe)
 >  {
 >  	int ret = 0;
 > -	const char *filter = NULL;
 > +	const char *clean_filter = NULL;
 > +	const char *process_filter = NULL;
 >  	int required = 0;
 >  	struct conv_attrs ca;
 >
 >  	convert_attrs(&ca, path);
 >  	if (ca.drv) {
 > -		filter = ca.drv->clean;
 > +		clean_filter = ca.drv->clean;
 > +		process_filter = ca.drv->process;
 >  		required = ca.drv->required;
 >  	}
 >
 > -	ret |= apply_filter(path, src, len, -1, dst, filter);
 > +	if (!clean_filter && process_filter)
 > +		ret |= apply_protocol_filter(path, src, len, -1, dst, 
process_filter, "clean");
 > +	else
 > +		ret |= apply_filter(path, src, len, -1, dst, clean_filter);
 >  	if (!ret && required)
 >  		die("%s: clean filter '%s' failed", path, ca.drv->name);
 >
 > @@ -885,13 +1119,19 @@ int convert_to_git(const char *path, const 
char *src, size_t len,
 >  void convert_to_git_filter_fd(const char *path, int fd, struct 
strbuf *dst,
 >  			      enum safe_crlf checksafe)
 >  {
 > +	int ret = 0;
 >  	struct conv_attrs ca;
 >  	convert_attrs(&ca, path);
 >
 >  	assert(ca.drv);
 > -	assert(ca.drv->clean);
 > +	assert(ca.drv->clean || ca.drv->process);
 >
 > -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 > +	if (!ca.drv->clean && ca.drv->process)
 > +		ret = apply_protocol_filter(path, NULL, 0, fd, dst, 
ca.drv->process, "clean");
 > +	else
 > +		ret = apply_filter(path, NULL, 0, fd, dst, ca.drv->clean);
 > +
 > +	if (!ret)
 >  		die("%s: clean filter '%s' failed", path, ca.drv->name);
 >
 >  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 > @@ -902,14 +1142,16 @@ static int 
convert_to_working_tree_internal(const char *path, const char *src,
 >  					    size_t len, struct strbuf *dst,
 >  					    int normalizing)
 >  {
 > -	int ret = 0, ret_filter = 0;
 > -	const char *filter = NULL;
 > +	int ret = 0, ret_filter;
 > +	const char *smudge_filter = NULL;
 > +	const char *process_filter = NULL;
 >  	int required = 0;
 >  	struct conv_attrs ca;
 >
 >  	convert_attrs(&ca, path);
 >  	if (ca.drv) {
 > -		filter = ca.drv->smudge;
 > +		process_filter = ca.drv->process;
 > +		smudge_filter = ca.drv->smudge;
 >  		required = ca.drv->required;
 >  	}
 >
 > @@ -922,7 +1164,7 @@ static int 
convert_to_working_tree_internal(const char *path, const char *src,
 >  	 * CRLF conversion can be skipped if normalizing, unless there
 >  	 * is a smudge filter.  The filter might expect CRLFs.
 >  	 */
 > -	if (filter || !normalizing) {
 > +	if (smudge_filter || process_filter || !normalizing) {
 >  		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 >  		if (ret) {
 >  			src = dst->buf;
 > @@ -930,7 +1172,10 @@ static int 
convert_to_working_tree_internal(const char *path, const char *src,
 >  		}
 >  	}
 >
 > -	ret_filter = apply_filter(path, src, len, -1, dst, filter);
 > +	if (!smudge_filter && process_filter)
 > +		ret_filter = apply_protocol_filter(path, src, len, -1, dst, 
process_filter, "smudge");
 > +	else
 > +		ret_filter = apply_filter(path, src, len, -1, dst, smudge_filter);
 >  	if (!ret_filter && required)
 >  		die("%s: smudge filter %s failed", path, ca.drv->name);
 >
 > @@ -1383,7 +1628,7 @@ struct stream_filter *get_stream_filter(const 
char *path, const unsigned char *s
 >  	struct stream_filter *filter = NULL;
 >
 >  	convert_attrs(&ca, path);
 > -	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
 > +	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 >  		return NULL;
 >
 >  	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 > diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
 > index b9911a4..c4793ed 100755
 > --- a/t/t0021-conversion.sh
 > +++ b/t/t0021-conversion.sh
 > @@ -4,6 +4,11 @@ test_description='blob conversion via gitattributes'
 >
 >  . ./test-lib.sh
 >
 > +if ! test_have_prereq PERL; then
 > +	skip_all='skipping perl interface tests, perl not available'
 > +	test_done
 > +fi
 > +
 >  if test_have_prereq EXPENSIVE
 >  then
 >  	T0021_LARGE_FILE_SIZE=2048
 > @@ -283,4 +288,174 @@ test_expect_success 'disable filter with empty 
override' '
 >  	test_must_be_empty err
 >  '
 >
 > +test_expect_success 'required protocol filter should filter data' '
 > +	test_config_global filter.protocol.process 
\"$TEST_DIRECTORY/t0021/rot13-filter.pl\" &&
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
 > +			1 wrote filter header
 > +		EOF
 > +		test_cmp expected_add.log uniq_output.log &&
 > +
 > +		>output.log &&
 > +		git commit . -m "test commit" &&
 > +		sort output.log | uniq -c | sed "s/^[ ]*//" |
 > +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq_output.log &&
 > +		cat >expected_commit.log <<-\EOF &&
 > +			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
 > +			x IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
 > +			x IN: clean test3.r 8 [OK] -- OUT: 8 [OK]
 > +			1 start
 > +			1 wrote filter header
 > +		EOF
 > +		test_cmp expected_commit.log uniq_output.log &&
 > +
 > +		>output.log &&
 > +		rm -f test?.r &&
 > +		git checkout . &&
 > +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
 > +		cat >expected_checkout.log <<-\EOF &&
 > +			start
 > +			wrote filter header
 > +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
 > +			IN: smudge test3.r 8 [OK] -- OUT: 8 [OK]
 > +		EOF
 > +		test_cmp expected_checkout.log smudge_output.log &&
 > +
 > +		git checkout empty &&
 > +
 > +		>output.log &&
 > +		git checkout master &&
 > +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
 > +		cat >expected_checkout_master.log <<-\EOF &&
 > +			start
 > +			wrote filter header
 > +			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
 > +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
 > +			IN: smudge test3.r 8 [OK] -- OUT: 8 [OK]
 > +		EOF
 > +		test_cmp expected_checkout_master.log smudge_output.log
 > +	)
 > +'
 > +
 > +test_expect_success 'protocol filter large file' '
 > +	test_config_global filter.protocol.process 
\"$TEST_DIRECTORY/t0021/rot13-filter.pl\" &&
 > +	test_config_global filter.protocol.required true &&
 > +	rm -rf repo &&
 > +	mkdir repo &&
 > +	(
 > +		cd repo &&
 > +		git init &&
 > +
 > +		echo "*.file filter=protocol" >.gitattributes &&
 > +		cp ../generated-test-data/large.file large.file &&
 > +		cp large.file large.original &&
 > +		./../rot13.sh <large.original >large.rot13 &&
 > +
 > +		git add large.file .gitattributes &&
 > +		git commit . -m "test commit" &&
 > +
 > +		rm -f large.file &&
 > +		git checkout -- large.file &&
 > +		git cat-file blob :large.file >actual &&
 > +		test_cmp large.rot13 actual
 > +	)
 > +'
 > +
 > +test_expect_success 'required protocol filter should fail with clean' '
 > +	test_config_global filter.protocol.process 
\"$TEST_DIRECTORY/t0021/rot13-filter.pl\" &&
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
 > +		# Note: There are three clean paths in convert.c we just test one 
here.
 > +		test_must_fail git add .
 > +	)
 > +'
 > +
 > +test_expect_success 'protocol filter should restart after failure' '
 > +	test_config_global filter.protocol.process 
\"$TEST_DIRECTORY/t0021/rot13-filter.pl\" &&
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
 > +		git checkout . &&
 > +		cat output.log | grep -v "IN: clean" >smudge_output.log &&
 > +		cat >expected_checkout_master.log <<-\EOF &&
 > +			start
 > +			wrote filter header
 > +			IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [FAIL]
 > +			start
 > +			wrote filter header
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
 > diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
 > new file mode 100755
 > index 0000000..7176836
 > --- /dev/null
 > +++ b/t/t0021/rot13-filter.pl
 > @@ -0,0 +1,146 @@
 > +#!/usr/bin/perl
 > +#
 > +# Example implementation for the Git filter protocol version 2
 > +# See Documentation/gitattributes.txt, section "Filter Protocol"
 > +#
 > +# This implementation supports two special test cases:
 > +# (1) If data with the filename "clean-write-fail.r" is processed with
 > +#     a "clean" operation then the write operation will die.
 > +# (2) If data with the filename "smudge-write-fail.r" is processed with
 > +#     a "smudge" operation then the write operation will die.
 > +#
 > +
 > +use strict;
 > +use warnings;
 > +
 > +my $MAX_PACKET_CONTENT_SIZE = 65516;
 > +
 > +sub rot13 {
 > +    my ($str) = @_;
 > +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
 > +    return $str;
 > +}
 > +
 > +sub packet_read {
 > +    my $buffer;
 > +    my $bytes_read = read STDIN, $buffer, 4;
 > +    if ( $bytes_read == 0 ) {
 > +        return;
 > +    }
 > +    elsif ( $bytes_read != 4 ) {
 > +        die "invalid packet size '$bytes_read' field";
 > +    }
 > +    my $pkt_size = hex($buffer);
 > +    if ( $pkt_size == 0 ) {
 > +        return ( 1, "" );
 > +    }
 > +    elsif ( $pkt_size > 4 ) {
 > +        my $content_size = $pkt_size - 4;
 > +        $bytes_read = read STDIN, $buffer, $content_size;
 > +        if ( $bytes_read != $content_size ) {
 > +            die "invalid packet";
 > +        }
 > +        return ( 0, $buffer );
 > +    }
 > +    else {
 > +        die "invalid packet size";
 > +    }
 > +}
 > +
 > +sub packet_write {
 > +    my ($packet) = @_;
 > +    print STDOUT sprintf( "%04x", length($packet) + 4 );
 > +    print STDOUT $packet;
 > +    STDOUT->flush();
 > +}
 > +
 > +sub packet_flush {
 > +    print STDOUT sprintf( "%04x", 0 );
 > +    STDOUT->flush();
 > +}
 > +
 > +open my $debug, ">>", "output.log";
 > +print $debug "start\n";
 > +$debug->flush();
 > +
 > +packet_write("git-filter-protocol\n");
 > +packet_write("version 2\n");
 > +packet_write("clean smudge\n");
 > +print $debug "wrote filter header\n";
 > +$debug->flush();
 > +
 > +while (1) {
 > +    my $command = packet_read();
 > +    unless ( defined($command) ) {
 > +        exit();
 > +    }
 > +    chomp $command;
 > +    print $debug "IN: $command";
 > +    $debug->flush();
 > +    my $filename = packet_read();
 > +    chomp $filename;
 > +    print $debug " $filename";
 > +    $debug->flush();
 > +    my $filelen = packet_read();
 > +    chomp $filelen;
 > +    print $debug " $filelen";
 > +    $debug->flush();
 > +
 > +    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
 > +    my $output;
 > +
 > +    if ( $filelen > 0 ) {
 > +        my $input = "";
 > +        {
 > +            binmode(STDIN);
 > +            my $buffer;
 > +            my $done = 0;
 > +            while ( !$done ) {
 > +                ( $done, $buffer ) = packet_read();
 > +                $input .= $buffer;
 > +            }
 > +            print $debug " [OK] -- ";
 > +            $debug->flush();
 > +        }
 > +
 > +        if ( $command eq "clean" ) {
 > +            $output = rot13($input);
 > +        }
 > +        elsif ( $command eq "smudge" ) {
 > +            $output = rot13($input);
 > +        }
 > +        else {
 > +            die "bad command";
 > +        }
 > +    }
 > +
 > +    my $output_len = length($output);
 > +    packet_write("$output_len\n");
 > +    print $debug "OUT: $output_len ";
 > +    $debug->flush();
 > +    if ( $output_len > 0 ) {
 > +        if (   ( $command eq "clean" and $filename eq 
"clean-write-fail.r" )
 > +            or
 > +            ( $command eq "smudge" and $filename eq 
"smudge-write-fail.r" ) )
 > +        {
 > +            print $debug " [FAIL]\n";
 > +            $debug->flush();
 > +            die "write error";
 > +        }
 > +        else {
 > +            while ( length($output) > 0 ) {
 > +                my $packet = substr( $output, 0, 
$MAX_PACKET_CONTENT_SIZE );
 > +                packet_write($packet);
 > +                if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
 > +                    $output = substr( $output, 
$MAX_PACKET_CONTENT_SIZE );
 > +                }
 > +                else {
 > +                    $output = "";
 > +                }
 > +            }
 > +            packet_flush();
 > +            print $debug "[OK]\n";
 > +            $debug->flush();
 > +        }
 > +    }
 > +}
 >

