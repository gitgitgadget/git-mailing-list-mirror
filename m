Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8716120986
	for <e@80x24.org>; Sat,  1 Oct 2016 19:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbcJATvw (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 15:51:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36359 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbcJATvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 15:51:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so8316109wma.3
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZgyZRKaaU9exVjJze3Lt0ii6kzjQBiXG+IGgCRcYtgg=;
        b=Eq81JovsSSgFUNdClZJB0wtDixjGzxgm1LXo73TrS7JalLYbF4Nyp3eaYymJw+y740
         epuCZH8JtC4lZHBBJI6wFtCh43+ZTP8QdJQRpzilhx5aD233tsi83rBI3yhDAMAm7vBo
         d1XuiDakXzL+jscsqnd+fnW/Z/MVjoqGoxbZtzM/31Qeqwv0gZHGFQdYmNzYNFvD8z6w
         EOpc31WBN5S3uEMLKwjgQmXNU6geyJYs7EbCIFGh2zdfk/9F8uxR4XoBzMYmgeJhMera
         9sHWw2FmeKnOkjGq/apPt02Oh3/ku806OZIQ6I9qEcePJg3igsJpc5nPtbnXsvxPzred
         oifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZgyZRKaaU9exVjJze3Lt0ii6kzjQBiXG+IGgCRcYtgg=;
        b=AP1mvtuTbFdk+xj4AgAJpzOhDjbENPWLhPyTs0oGWuw3/AHG6OZxaiW0vlHPWoMvdV
         9hbB736JZPWekqruH45B+sfO3xiP6tcKuib2Du4IIsyPl2XOni6vfEz9pvIr4DJ9AUmH
         nqeQcqKyC1b46vN45h8GEl7uI1QHpI/sLHQ45zA7UrvmAxBWRyQ/9sKohrtkEF6fROXW
         9ow3Ws6Q7UV0TO5+W3A5iW64vyUbMgcg024ekJ3O++HvTSorIJEtyDNSVBA03ouEdp8i
         SK5nC/HnlHz4yu8m7I8v9Ype7WwKkvofajlNzz6082XXwtb+n730u1oAP2uiU0Nu1T2M
         l+xw==
X-Gm-Message-State: AA6/9Rl8si0gygpZhPElcIT1jhAsQn4UmXKSZeAfVqqho2fiW6rU8won6B0wh5HmECRbxg==
X-Received: by 10.28.229.131 with SMTP id c125mr2981518wmh.97.1475351509784;
        Sat, 01 Oct 2016 12:51:49 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id v128sm4093585wmv.3.2016.10.01.12.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 12:51:48 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] i18n: send-email: mark warnings and errors for
 translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-10-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <37c2efce-90b1-9415-eb85-64358e43b853@gmail.com>
Date:   Sat, 1 Oct 2016 21:51:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1472646690-9699-10-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:

> Mark warnings, errors and other messages for translation.
>

Which discovered a few places with questionable code...

(though there is one place with bad handling of translation)
 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-send-email.perl | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2521832..e7f712e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -118,20 +118,20 @@ sub format_2822_time {
>  	my $localmin = $localtm[1] + $localtm[2] * 60;
>  	my $gmtmin = $gmttm[1] + $gmttm[2] * 60;
>  	if ($localtm[0] != $gmttm[0]) {
> -		die "local zone differs from GMT by a non-minute interval\n";
> +		die __("local zone differs from GMT by a non-minute interval\n");
>  	}
>  	if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
>  		$localmin += 1440;
>  	} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
>  		$localmin -= 1440;
>  	} elsif ($gmttm[6] != $localtm[6]) {
> -		die "local time offset greater than or equal to 24 hours\n";
> +		die __("local time offset greater than or equal to 24 hours\n");

As one can see that this is the same message as below, so I wondered
why the same test is repeated... But it is even worse.  This test
is first, wrongly described: it checks that the day of week is the
same in local timezone and in UTC / GMT.  But second, it is WRONG!

For example if UTC time is just before midnight, then any positive
timezone has different day of week (next day); if UTC is just before
midnight, then any negative timezone has different day of week (previous
day).

  $ LC_ALL=C TZ=US/Hawaii date --date="2016-10-01 01:00 UTC"
  Fri Sep 30 15:00:00 HST 2016
  $ LC_ALL=C TZ=US/Hawaii date --date="2016-10-01 01:00 UTC" --utc
  Sat Oct  1 01:00:00 UTC 2016


>  	}
>  	my $offset = $localmin - $gmtmin;
>  	my $offhour = $offset / 60;
>  	my $offmin = abs($offset % 60);
>  	if (abs($offhour) >= 24) {
> -		die ("local time offset greater than or equal to 24 hours\n");
> +		die __("local time offset greater than or equal to 24 hours\n");

This is good test.

>  	}
>  
>  	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
> @@ -199,13 +199,13 @@ sub do_edit {
>  		map {
>  			system('sh', '-c', $editor.' "$@"', $editor, $_);
>  			if (($? & 127) || ($? >> 8)) {
> -				die("the editor exited uncleanly, aborting everything");
> +				die(__("the editor exited uncleanly, aborting everything"));
>  			}
>  		} @_;
>  	} else {
>  		system('sh', '-c', $editor.' "$@"', $editor, @_);
>  		if (($? & 127) || ($? >> 8)) {
> -			die("the editor exited uncleanly, aborting everything");
> +			die(__("the editor exited uncleanly, aborting everything"));
>  		}
>  	}

Here we see some unnecessary code duplication, and thus
message duplication.


> @@ -1410,7 +1410,7 @@ Message-Id: $message_id
>  		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
>  	}
>  	if ($quiet) {
> -		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
> +		printf (($dry_run ? "Dry-" : ""). __("Sent %s\n"), $subject);
>  	} else {
>  		print (($dry_run ? "Dry-" : ""). __("OK. Log says:\n"));
>  		if (!file_name_is_absolute($smtp_server)) {

You would want to translate Dry-Sent and Dry-OK.

-- 
Jakub Narębski

