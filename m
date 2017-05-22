Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66D22023D
	for <e@80x24.org>; Mon, 22 May 2017 19:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761967AbdEVT6e (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:58:34 -0400
Received: from mout.web.de ([217.72.192.78]:53568 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761814AbdEVT6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:58:32 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8Qtq-1e7cgP3HRS-00vxGN; Mon, 22
 May 2017 21:58:15 +0200
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, e@80x24.org, ttaylorr@github.com
References: <20170522135001.54506-1-larsxschneider@gmail.com>
 <20170522135001.54506-5-larsxschneider@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
Date:   Mon, 22 May 2017 21:58:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170522135001.54506-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:r+A78xWnnOOqvgV/t8iPMv7m+qQsLYfMACDac0TqG+3GF1PP8or
 /cNV4+jDoG4RfXPcY57UBgXiJsxSisk/b01AQqxEF/0Fa36CNK4ZWaI5Y79mFuETJulQVX7
 eMJ5+HeXAlKSm+dnm8O8ghPECBBVf7FgxoCDqu+Z8EeRyoD6XP3kBVAC738mpxM/RxSWQBD
 hVbl1s8gzU2xiuEsdVJpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9XBbn8yxees=:UuUG4DR7w3loL0Xia2DNZw
 cJWB+BGyPHG6VXjnNnUqMUnuare5pQkdflWOnY+i0kKLwtOqEMqFdIggOAZV9yG5vtlTvjEFt
 o66J7Lhz/JzvNukkiVYkSh1hfVPvIkHcSDY/IVPu+PvSmNkr6ujsf17iCK+imMvJfQIy5qdEN
 a3ay6CQ83b6znNKiWvD5OBjXS3tqXWbrFHC+LUYNS4ZS5T0tj3H/DG4nWuDDH8YDsq+8ntjHg
 O+Oa77+hZq6Y0ej9bd7PPPaC3Sdg01qiM/ZuxiY2YqklKdMUx7F7/vG1QK8gyGV6OwN95SYoa
 AmISraWC2hO0Io+4lZr5dAtqHLxz3TouVGn/JG0O0CIj1k6k6wR2peT9z49Kw3OdiiZ1hVTCs
 HYaXPHL8rRINJrS6xIL938wG+tYSvUZUFcDvWJaW00a2ryktszNLtNwi4Eh41xjNf3dchHU0g
 XbAU0GxOFV3/Zl59qrz9i5brZt+3vzCWeLileeiBNSem3Cw08IJzYV67mx3O5NnqjIpr96/PS
 5cTJ0PMvvHGgCQLaP3VpnW+eFFKGhatc+lTF0GCW7dWZeFYpf2ZjeN20ptpH+xDzpz6c38i7R
 4M1SbnDCBsmQ63qiuSNICdYFPskfZVCz719yoaJUJsAZNto/R/xxS3KZWaBVmjcvHUk+dmac3
 FZhjXYY4YfhFy1NKG39+yii0ZE5vMr0IVshHVsGCXT4mn99fOWHJaU3jlS4uiaue/KAeT3f9o
 1hxIHwqVKWe6ht1No2N1LpuCbh59QlQGV1OwlYSz90AnXYkkMz1YKKV7pG1ysQjIo7yolkp34
 VMCiEF7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-22 15:50, Lars Schneider wrote:
> +
> +int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths)
> +{
> +	int err;
> +	char *line;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct strbuf filter_status = STRBUF_INIT;
> +
> +	entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
> +	if (!entry) {
> +		error("external filter '%s' is not available anymore although "
> +		      "not all paths have been filtered", cmd);
> +		return 0;
> +	}
> +	process = &entry->process;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	err = packet_write_fmt_gently(
> +		process->in, "command=list_available_blobs\n");
> +	if (err)
> +		goto done;
> +
> +	err = packet_flush_gently(process->in);
> +	if (err)
> +		goto done;
> +
> +	for (;;) {
> +		const char* pre = "pathname=";
> +		const int pre_len = strlen(pre);
> +		line = packet_read_line(process->out, NULL);
> +		if (!line)
> +			break;
> +		err = strlen(line) <= pre_len || strncmp(line, pre, pre_len);
> +		if (err)
> +			goto done;
> +		string_list_insert(delayed_paths, xstrdup(line+pre_len));
> +	}
> +
> +	read_multi_file_filter_status(process->out, &filter_status);
> +	err = strcmp(filter_status.buf, "success");
> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err || errno == EPIPE) {

This looks strange, at first glance.
Do we set errno to 0 before ?
Or is there a trick that EPIPE can only be reached,
if it is "our" error ?


> +		if (!strcmp(filter_status.buf, "error")) {
> +			/* The filter signaled a problem with the file. */
> +		} else {
> +			/*
> +			 * Something went wrong with the protocol filter.
> +			 * Force shutdown and restart if another blob requires
> +			 * filtering.
> +			 */
> +			error("external filter '%s' failed", cmd);
> +			kill_multi_file_filter(&cmd_process_map, entry);
> +		}
> +	}
> +	return !err;
> +}
> +

