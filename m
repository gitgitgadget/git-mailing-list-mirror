Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02BA20966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbdDJMLN (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:11:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33972 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdDJMLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:11:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so20920390wrc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rl7M6mItNyujq3IXuoZZ8uMZtmvDR1X3031b9DgxHOY=;
        b=ogj8NgxXUwwcXrkCRG2B8dZbeoZK7tJMVl6s2b4SXVuD8WAYprguPa9xKOxDjJpWMX
         DRlv8ZmcVsU2FcKd5bQGxucTL7njN58eZWbFFCPm1s1lWCXQQqQQlp/effZTg02b5eFe
         TLKjXs+bNMaoB7H3iXYsVb7kz7nxTpdWnGFvokEIm2v7l5kHivO23hLssHzSDscVMXSP
         4ABXmM0JG5SjvmJB2KdxrEx2jOzBzGfw8q6Os9LfM2724xUzkF0ul6kswcXZGjyqcram
         lVLea19vftW3IDd0gOWM1VBb9eBySw0DkKcQNywnSjZJbM8P7Z9TBR7QZNNK2VZ53TIW
         AXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rl7M6mItNyujq3IXuoZZ8uMZtmvDR1X3031b9DgxHOY=;
        b=Y6rM/+8dJoIB5YODK9IK0ZDdh2D3He0jUv/0ONnKywZsDilsHSL6ceJPjy8z+rEFr0
         vKoP3/nxF80qv8cLfA7ERmWLUUxdyQ66vaNccglPPloR2vbynW8dU8hZQBAqp/KW7ndh
         4j7G5zLtSROf8mhRktTWNtH/6iIeUjj4PHd5/tIIMUXIEBkCIFeObJZ2ICFqT+JzA09b
         qaSeBDiqaI/m6LNLrPRK3V6E1qXqLK/MvrFvlXoskULh9AOB/Bz7PSY1nKJrx75cRQWy
         HztzhU4gAz4ZklMWzbuLYTZY9JiRMG0ZkHnu/WXU9znUyCWNVb1d3GKWJLEn9B+Ynbrf
         LGsQ==
X-Gm-Message-State: AN3rC/45h/qHtYkFPIMkMgqBpz1lhH9b9GGCLmnAohxvBnQnONnx3u7/CVaUQ1ji1O7nNA==
X-Received: by 10.223.177.155 with SMTP id q27mr1402060wra.23.1491826269879;
        Mon, 10 Apr 2017 05:11:09 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m83sm10081586wmc.7.2017.04.10.05.11.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 05:11:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 6/8] convert: rename reusable sub-process functions
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-7-benpeart@microsoft.com>
Date:   Mon, 10 Apr 2017 14:11:08 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B2A2436-8BD4-4858-BC90-BCB1617D586B@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-7-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Do a mechanical rename of the functions that will become the reusable
> sub-process module.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c | 53 +++++++++++++++++++++++++++--------------------------
> 1 file changed, 27 insertions(+), 26 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 747c0c363b..235a6a5279 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -507,8 +507,8 @@ struct cmd2process {
> 	unsigned int supported_capabilities;
> };
>=20

> ...

>=20
> -static void kill_multi_file_filter(struct subprocess_entry *entry)
> +static void subprocess_stop(struct subprocess_entry *entry)
> {
> 	if (!entry)
> 		return;
> @@ -561,14 +561,14 @@ static void kill_multi_file_filter(struct =
subprocess_entry *entry)
> 	kill(entry->process.pid, SIGTERM);
> 	finish_command(&entry->process);
>=20
> -	hashmap_remove(&cmd_process_map, entry, NULL);
> +	hashmap_remove(&subprocess_map, entry, NULL);
> 	free(entry);
> }

> ...

> @@ -777,7 +777,8 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
> 			 * Force shutdown and restart if another blob =
requires filtering.
> 			 */
> 			error("external filter '%s' failed", cmd);
> -			kill_multi_file_filter((struct subprocess_entry =
*)entry);
> +			subprocess_stop((struct subprocess_entry =
*)entry);
> +			free(entry);

I think we perform a double "free" here and in subprocess_stop(), no?
Everything else looks good to me!

Thanks,
Lars=
