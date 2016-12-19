Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A36D1FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761223AbcLSLWJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:22:09 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62249 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759884AbcLSLWI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 06:22:08 -0500
X-AuditID: 12074414-773ff70000004a85-30-5857c2defe77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 11.A5.19077.ED2C7585; Mon, 19 Dec 2016 06:22:06 -0500 (EST)
Received: from [192.168.69.190] (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJBM4gO027882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 06:22:06 -0500
Subject: Re: [PATCH 5/5] check-ref-format: New --stdin option
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-6-ijackson@chiark.greenend.org.uk>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9d2d25d8-e9cf-5d9f-8e7e-5d426e219344@alum.mit.edu>
Date:   Mon, 19 Dec 2016 12:22:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161104191358.28812-6-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqHv/UHiEwfEZrBZdV7qZLFa3LGJx
        YPL4dmoTs8fnTXIBTFFcNimpOZllqUX6dglcGc09V5kKtklXzH+8j6mB8ZBoFyMnh4SAicTZ
        HfcZuxi5OIQELjNKdDSvYYJwLjBJnDvwnQmkSljAVqJx9VIWEFtEwE3i7KdGsLiQQL3Em5f7
        WUFsNgFdiUU9zWBxXgF7iZvTVoPFWQRUJfY2bWYEsUUFQiQuzznKBlEjKHFy5hOwmZwCrhJf
        LvYzg9jMAnoSO67/YoWw5SW2v53DPIGRbxaSlllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3
        ODkxLy+1SNdCLzezRC81pXQTIyTwRHYwHjkpd4hRgINRiYe34H1YhBBrYllxZe4hRkkOJiVR
        3ilrQyKE+JLyUyozEosz4otKc1KLDzFKcDArifBu2xseIcSbklhZlVqUD5OS5mBREuf9tljd
        T0ggPbEkNTs1tSC1CCYrw8GhJMGrBIwwIcGi1PTUirTMnBKENBMHJ8hwHqDh4QdBhhcXJOYW
        Z6ZD5E8xKkqJ80aDJARAEhmleXC9sMTwilEc6BVh3scgVTzApALX/QpoMBPQ4IXdYINLEhFS
        Ug2MhRMtM0M4X2tbHZfQWvg+qXyn8YtDC/+dlnNoKNr1Zc6GZaLpVzMqY1k/nfmd+sRvz67G
        VobiWNMdi16KrX63qoMhYfaKGW82llTOm24Rszxj0o3LdZOdW+bacDoenPqdSY7j7c/3yVrH
        G0OP2ntadp5R25Ec8nbL0/cOqbrNte/a1L1jBJ7fUWIpzkg01GIuKk4EAB1r1oTnAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2016 08:13 PM, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
> ---
>  Documentation/git-check-ref-format.txt | 10 ++++++++--
>  builtin/check-ref-format.c             | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index e9a2657..5a213ce 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -10,8 +10,9 @@ SYNOPSIS
>  [verse]
>  'git check-ref-format' [--report-errors] [--normalize]
>         [--[no-]allow-onelevel] [--refspec-pattern]
> -       <refname>
> -'git check-ref-format' [--report-errors] --branch <branchname-shorthand>
> +       <refname> | --stdin
> +'git check-ref-format' [--report-errors] --branch
> +       <branchname-shorthand> | --stdin
>  
>  DESCRIPTION
>  -----------
> @@ -109,6 +110,11 @@ OPTIONS
>  	If any ref does not check OK, print a message to stderr.
>          (By default, git check-ref-format is silent.)
>  
> +--stdin::
> +	Instead of checking on ref supplied on the command line,
> +	read refs, one per line, from stdin.  The exit status is
> +	0 if all the refs were OK.
> +
>  
>  EXAMPLES
>  --------
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index 559d5c2..87f52fa 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -76,6 +76,7 @@ static int check_one_ref_format(const char *refname)
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
> +	int use_stdin = 0;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_check_ref_format_usage);
> @@ -93,6 +94,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  			check_branch = 1;
>  		else if (!strcmp(argv[i], "--report-errors"))
>  			report_errors = 1;
> +		else if (!strcmp(argv[i], "--stdin"))
> +			use_stdin = 1;
>  		else
>  			usage(builtin_check_ref_format_usage);
>  	}
> @@ -100,8 +103,33 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  	if (check_branch && (flags || normalize))
>  		usage(builtin_check_ref_format_usage);
>  
> -	if (! (i == argc - 1))
> -		usage(builtin_check_ref_format_usage);
> +	if (!use_stdin) {
> +		if (! (i == argc - 1))
> +			usage(builtin_check_ref_format_usage);

Given the changes that you made to support `--stdin`, it would be pretty
easy to support multiple command line arguments, now, too. (But this
needn't be part of your patch series.)

> +
> +		return check_one_ref_format(argv[i]);
> +	} else {
> +		char buffer[2048];
> +		int worst = 0;
>  
> -	return check_one_ref_format(argv[i]);
> +		if (! (i == argc))
> +			usage(builtin_check_ref_format_usage);
> +
> +		while (fgets(buffer, sizeof(buffer), stdin)) {

`strbuf_getline()` would make this a lot easier and also eliminate the
need to specify a buffer size.

> +			char *newline = strchr(buffer, '\n');
> +			if (!newline) {
> +				fprintf(stderr, "%s --stdin: missing final newline or line too long\n", *argv);
> +				exit(127);
> +			}
> +			*newline = 0;
> +			int got = check_one_ref_format(buffer);
> +			if (got > worst)
> +				worst = got;
> +		}
> +		if (!feof(stdin)) {
> +			perror("reading from stdin");
> +			exit(127);
> +		}
> +		return worst;
> +	}
>  }
> 

Michael

