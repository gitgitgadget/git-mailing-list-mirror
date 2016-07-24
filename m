Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916F0203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcGXRQv (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 13:16:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36290 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcGXRQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2016 13:16:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so13428422wma.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 10:16:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+mhygF8LxcvOpXJOBObsexS+7yGwHhOlA/3hrfrLMDw=;
        b=j19XK7AeMBmxyyLmmJvESGfiz+3TxUBDGU8ANYQBuZH/+xreF+pQgTe1ZdnAI5Hs4H
         I9i+KsJboZTFpSWTpZhH1H+sPgf9fpeaMjafOAfCBJZAPFDmIFo7wPN5x/a5ZDDdts7N
         6cLsEuMNQ4OaK3lgZgNiosdW2zgaq5PiZMC9l3AIwWH2UC4tsusAxgvfadDjjB5uV+I2
         iZQB1Vlwl1Pa1pwD23HDqAIfF3yBJR5ZXEPG+IloyG4pDrytYLW+3t4qqvenw3q6QcBI
         kgkH1HqDY42S/9iZOf1SAKQ2ZHpe+lStKtNSnZ97dVmTs1BhrptUIXV7QSpZru4JT24X
         nccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+mhygF8LxcvOpXJOBObsexS+7yGwHhOlA/3hrfrLMDw=;
        b=dx0bvTQo/enpxB8316NfwHiJckc4cK3acy0g+Nb2Fjz16fjl7B5bB0YBd4o0PkJizY
         sA91JItFmS7AZWQJqxo7xm+Vqlu8/brhCdZ5RxgY3/cXwB/ffybqM6MtN4nlirqlrgf1
         l4A8GJW+H1r0H0CQYIYp7oEZHu0d/Lo8zVinnf3kXTsGRDNQpzVv0036MTI/ZWb1tsLG
         YNPpX88nt2i5N7mDoQtiBM2eEUX2j0u/4PLK99o0fcoeRd/Q0auMEXDyRjJqC7eZNzdN
         3lRL3mv3uA+fIPWVc82n9T+GKmWZPr3BcxbDdZKnCOcFELSHxb+miKUXNQgRK4iBOL+g
         tIvQ==
X-Gm-Message-State: AEkoouuYCEhFfZvPAXeVAVrNioTPnJ4tpgKJS37W5fzA5ScdDItg6s+gsYsVMMOXJhc3vw==
X-Received: by 10.194.176.42 with SMTP id cf10mr12058868wjc.55.1469380608466;
        Sun, 24 Jul 2016 10:16:48 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5F1D.dip0.t-ipconnect.de. [93.219.95.29])
        by smtp.gmail.com with ESMTPSA id m81sm23164291wmf.1.2016.07.24.10.16.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 10:16:47 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
Date:	Sun, 24 Jul 2016 19:16:45 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com>
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 23 Jul 2016, at 01:19, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
>> 
>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>> keeps the external filter process running and processes all blobs with
>> the following protocol over stdin/stdout.
>> 
>> 1. Git starts the filter on first usage and expects a welcome message
>> with protocol version number:
>> 	Git <-- Filter: "git-filter-protocol\n"
>> 	Git <-- Filter: "version 1"
> 
> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
> interaction is fully defined, I guess it doesn't matter).
> 
> [If you wanted to check for a version, you could add a "version" command
> instead, just like "clean" and "smudge".]

It was a conscious decision to have the `filter` talk first. My reasoning was:

(1) I want a reliable way to distinguish the existing filter protocol ("single-shot 
invocation") from the new one ("long running"). I don't think there would be a
situation where the existing protocol would talk first. Therefore the users would
not accidentally mix them with a possibly half working, undetermined, outcome.

(2) In the future we could extend the pipe protocol (see $gmane/297994, it's very
interesting). A filter could check Git's version and then pick the most appropriate
filter protocol on startup.


> [...]
>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry = NULL;
>> +	struct child_process *process = NULL;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>> +	const char *argv[] = { NULL, NULL };
>> +	const char *header = "git-filter-protocol\nversion";
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
>> +	argv[0] = cmd;
>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
>> +	process->out = -1;
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external persistent filter '%s'", cmd);
>> +		return NULL;
>> +	}
>> +	strbuf_reset(&nbuf);
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
> 
> Hmm, how much will be read into nbuf by this single call?
> Since strbuf_read_once() makes a single call to xread(), with
> a len argument that will probably be 8192, you can not really
> tell how much it will read, in general. (xread() does not
> guarantee how many bytes it will read.)
> 
> In particular, it could be less than strlen(header).

As mentioned to Torsten in $gmane/300156, I will add a newline
and then read until I find the second newline. That should solve
the problem, right?

(You wrote in $gmane/300119 that I should ignore your email but
I think you have a valid point here ;-)


>> [...]
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	switch (entry->protocol) {
>> +		case 1:
>> +			if (fd >= 0 && !src) {
>> +				ret &= fstat(fd, &fileStat) != -1;
>> +				len = fileStat.st_size;
>> +			}
>> +			strbuf_reset(&nbuf);
>> +			strbuf_addf(&nbuf, "%s\n%s\n%zu\n", filter_type, path, len);
>> +			ret &= write_str_in_full(process->in, nbuf.buf) > 1;
> 
> why not write_in_full(process->in, nbuf.buf, nbuf.len) ?
OK, this would save a "strlen" call. Do you think such a function could be of general
use? If yes, then I would add:

static inline ssize_t write_strbuf_in_full(int fd, struct strbuf *str)
{
	return write_in_full(fd, str->buf, str->len);
}


>> +			if (len > 0) {
>> +				if (src)
>> +					ret &= write_in_full(process->in, src, len) == len;
>> +				else if (fd >= 0)
>> +					ret &= copy_fd(fd, process->in) == 0;
>> +				else
>> +					ret &= 0;
>> +			}
>> +
>> +			strbuf_reset(&nbuf);
>> +			while (xread(process->out, &c, 1) == 1 && c != '\n')
>> +				strbuf_addchars(&nbuf, c, 1);
>> +			nbuf_len = (size_t)strtol(nbuf.buf, &strtol_end, 10);
>> +			ret &= (strtol_end != nbuf.buf && errno != ERANGE);
>> +			strbuf_reset(&nbuf);
>> +			if (nbuf_len > 0)
>> +				ret &= strbuf_read_once(&nbuf, process->out, nbuf_len) == nbuf_len;
> 
> Again, how many bytes will be read?
> Note, that in the default configuration, a _maximum_ of
> MAX_IO_SIZE (8MB or SSIZE_MAX, whichever is smaller) bytes
> will be read.
Would something like this be more appropriate?

strbuf_reset(&nbuf);
if (nbuf_len > 0) {
    strbuf_grow(&nbuf, nbuf_len);
    ret &= read_in_full(process->out, nbuf.buf, nbuf_len) == nbuf_len;
}


Thanks for the review,
Lars

