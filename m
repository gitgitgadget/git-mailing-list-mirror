Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBF7203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbcGYUYy (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:24:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36765 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbcGYUYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 16:24:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so18275027wma.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 13:24:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iKm/u/QNuytty9I0KSH75G0dJ/gaFWu2yRzjl5VjvRw=;
        b=YVY4IDgL+NYoihpo7sG3gmwXmlh9SLV3b1Vu6XL2gFBTQwzlL1ZOSRqHvTZLuBIuDp
         +vuH2o1f3ib2vmM1Weo+UARFMNYqDwWmDFnjNoclZZl8Mn41jpOrfSMs3Y8l8lLRSe+I
         mWGkraYuSvnpnZe58pl72n6yQv10gnbugmX3d20AxT2cFR4UPnt28IvOoEKsPTctvg/J
         qwrtCmsjfMcizyCwaHMVgrJQUc6OwO5q6T0+YtBRZ/IZxed6JO+Bx3sbFLBb042ZHs34
         e5CwS7KsDyjo2Jf4mqlIn1bvGBHDs95w7lxogiYUp2eN2Er8/MP//uWMGVfg9Vgs7yvU
         2cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iKm/u/QNuytty9I0KSH75G0dJ/gaFWu2yRzjl5VjvRw=;
        b=AxGFP+fzr6768T8A0lkIMXAfOSckDeJVxzBr7EX3X8IBRBRD1xuMjUOPIFihS4GZZP
         081Bd+b37MvF8Qnol6sIabM1uoDrZhWKqnuHttWuR0AEMvE4v4fNpUbGz6Vl3Xkiq6iN
         twSzTq1j3xkYGbcyYbdyZL9Qg815t1LWM+c3zr8fAUhoNOSph7eDj4/zWCa9NwKCrNKR
         maj+3mI7e1jOrQ1fRUIsvLNdN2Dds/MWyCrCWRRkrDlLKMTw9i0/QSmuwupOapwXd0sq
         PS+d8fsrPj2CXY46IfF6/f5tyDQIblflZHcdc/7YinWYyXTBTWB6Eo/+5xMU7gJXyo7x
         ko4w==
X-Gm-Message-State: AEkoouuqoRkLO++1Edv+C0tUnXFOomOxbDFxzeXzLozdYlUeooVp8+kTDwGzGpoMxDhQOg==
X-Received: by 10.28.208.206 with SMTP id h197mr14434492wmg.17.1469478291277;
        Mon, 25 Jul 2016 13:24:51 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7A6F.dip0.t-ipconnect.de. [93.219.122.111])
        by smtp.gmail.com with ESMTPSA id va3sm17491797wjb.18.2016.07.25.13.24.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 13:24:47 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
Date:	Mon, 25 Jul 2016 22:24:44 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <940904FE-93EB-45E9-B3F2-54C07BBF7E54@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <9f47cf44-7163-a7a7-c1f0-87ebdee65b37@ramsayjones.plus.com> <1A0C148F-C7C3-4FAF-BAEE-58B11A2324FF@gmail.com> <194ea810-76ff-f32c-0f8a-57e8e60b65f5@ramsayjones.plus.com>
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 25 Jul 2016, at 00:36, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> On 24/07/16 18:16, Lars Schneider wrote:
>> 
>> On 23 Jul 2016, at 01:19, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> 
>>> On 22/07/16 16:49, larsxschneider@gmail.com wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> Git's clean/smudge mechanism invokes an external filter process for every
>>>> single blob that is affected by a filter. If Git filters a lot of blobs
>>>> then the startup time of the external filter processes can become a
>>>> significant part of the overall Git execution time.
>>>> 
>>>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>>>> keeps the external filter process running and processes all blobs with
>>>> the following protocol over stdin/stdout.
>>>> 
>>>> 1. Git starts the filter on first usage and expects a welcome message
>>>> with protocol version number:
>>>> 	Git <-- Filter: "git-filter-protocol\n"
>>>> 	Git <-- Filter: "version 1"
>>> 
>>> Hmm, I was a bit surprised to see a 'filter' talk first (but so long as the
>>> interaction is fully defined, I guess it doesn't matter).
>>> 
>>> [If you wanted to check for a version, you could add a "version" command
>>> instead, just like "clean" and "smudge".]
>> 
>> It was a conscious decision to have the `filter` talk first. My reasoning was:
>> 
>> (1) I want a reliable way to distinguish the existing filter protocol ("single-shot 
>> invocation") from the new one ("long running"). I don't think there would be a
>> situation where the existing protocol would talk first. Therefore the users would
>> not accidentally mix them with a possibly half working, undetermined, outcome.
> 
> If an 'single-shot' filter were incorrectly configured, instead of a new one, then
> the interaction could last a little while - since it would result in deadlock! ;-)
> 
> [If Git talks first instead, configuring a 'single-shot' filter _may_ still result
> in a deadlock - depending on pipe size, etc.]

Do you think this is an issue that needs to be addressed in the first version?
If yes, I would probably look into "select" to specify a timeout for the filter.
However, wouldn't the current "single-shot" clean/smudge filter block in the 
same way if they don't write anything?


>> (2) In the future we could extend the pipe protocol (see $gmane/297994, it's very
>> interesting). A filter could check Git's version and then pick the most appropriate
>> filter protocol on startup.
>> 
>> 
>>> [...]
>>>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>>>> +{
>>>> +	int ret = 1;
>>>> +	struct cmd2process *entry = NULL;
>>>> +	struct child_process *process = NULL;
>>>> +	struct strbuf nbuf = STRBUF_INIT;
>>>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>>>> +	const char *argv[] = { NULL, NULL };
>>>> +	const char *header = "git-filter-protocol\nversion";
>>>> +
>>>> +	entry = xmalloc(sizeof(*entry));
>>>> +	hashmap_entry_init(entry, strhash(cmd));
>>>> +	entry->cmd = cmd;
>>>> +	process = &entry->process;
>>>> +
>>>> +	child_process_init(process);
>>>> +	argv[0] = cmd;
>>>> +	process->argv = argv;
>>>> +	process->use_shell = 1;
>>>> +	process->in = -1;
>>>> +	process->out = -1;
>>>> +
>>>> +	if (start_command(process)) {
>>>> +		error("cannot fork to run external persistent filter '%s'", cmd);
>>>> +		return NULL;
>>>> +	}
>>>> +	strbuf_reset(&nbuf);
>>>> +
>>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
>>> 
>>> Hmm, how much will be read into nbuf by this single call?
>>> Since strbuf_read_once() makes a single call to xread(), with
>>> a len argument that will probably be 8192, you can not really
>>> tell how much it will read, in general. (xread() does not
>>> guarantee how many bytes it will read.)
>>> 
>>> In particular, it could be less than strlen(header).
>> 
>> As mentioned to Torsten in $gmane/300156, I will add a newline
>> and then read until I find the second newline. That should solve
>> the problem, right?
>> 
>> (You wrote in $gmane/300119 that I should ignore your email but
>> I think you have a valid point here ;-)
> 
> Heh, as I said, it was late and I was trying to do several things
> at once. (I am updating 3 installations of Linux Mint 17.3 to Linux
> Mint 18 - I decided to do a complete re-install, since I needed to
> change partition sizes anyway. I have only just got email back up ...)
> 
> I stopped commenting on the patch early but, after sending the first
> email, I decided to scan the rest of your patch before going to bed
> and noticed something which would invalidate my comments ...
> 
>> 
>> 
>>>> [...]
>>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>>> +	switch (entry->protocol) {
>>>> +		case 1:
>>>> +			if (fd >= 0 && !src) {
>>>> +				ret &= fstat(fd, &fileStat) != -1;
>>>> +				len = fileStat.st_size;
>>>> +			}
>>>> +			strbuf_reset(&nbuf);
>>>> +			strbuf_addf(&nbuf, "%s\n%s\n%zu\n", filter_type, path, len);
>>>> +			ret &= write_str_in_full(process->in, nbuf.buf) > 1;
>>> 
>>> why not write_in_full(process->in, nbuf.buf, nbuf.len) ?
>> OK, this would save a "strlen" call. Do you think such a function could be of general
>> use? If yes, then I would add:
>> 
>> static inline ssize_t write_strbuf_in_full(int fd, struct strbuf *str)
>> {
>> 	return write_in_full(fd, str->buf, str->len);
>> }
> 
> [I don't have strong feelings either way (but I suspect it's not worth it).]

OK


>>>> +			if (len > 0) {
>>>> +				if (src)
>>>> +					ret &= write_in_full(process->in, src, len) == len;
>>>> +				else if (fd >= 0)
>>>> +					ret &= copy_fd(fd, process->in) == 0;
>>>> +				else
>>>> +					ret &= 0;
>>>> +			}
>>>> +
>>>> +			strbuf_reset(&nbuf);
>>>> +			while (xread(process->out, &c, 1) == 1 && c != '\n')
>>>> +				strbuf_addchars(&nbuf, c, 1);
>>>> +			nbuf_len = (size_t)strtol(nbuf.buf, &strtol_end, 10);
>>>> +			ret &= (strtol_end != nbuf.buf && errno != ERANGE);
>>>> +			strbuf_reset(&nbuf);
>>>> +			if (nbuf_len > 0)
>>>> +				ret &= strbuf_read_once(&nbuf, process->out, nbuf_len) == nbuf_len;
>>> 
>>> Again, how many bytes will be read?
>>> Note, that in the default configuration, a _maximum_ of
>>> MAX_IO_SIZE (8MB or SSIZE_MAX, whichever is smaller) bytes
>>> will be read.
> 
> ... In particular, your 2GB test case should not have worked, so
> I assumed that I had missed a loop somewhere ...

Thanks a lot for this comment. The 2GB test case was bogus... v2
will have a much improved version :-)


>> Would something like this be more appropriate?
>> 
>> strbuf_reset(&nbuf);
>> if (nbuf_len > 0) {
>>    strbuf_grow(&nbuf, nbuf_len);
>>    ret &= read_in_full(process->out, nbuf.buf, nbuf_len) == nbuf_len;
>> }
> 
> ... and this looks better. [Note: this comment would apply equally to the
> version message.]

And it works better with large files, too :D


> [Hmm, now can I remember which packages I need to install ...]

:-)


Thanks,
Lars