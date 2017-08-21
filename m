Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE68E1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbdHUKUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:20:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34218 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbdHUKT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:19:59 -0400
Received: by mail-qt0-f196.google.com with SMTP id p13so1910765qtp.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CH0z3IcaSnuFgTx7ujG0hPd16mi7sVvnxwI9RCjab0M=;
        b=kuGLtKxYT/3Ql5phiHqgHRpfBQ3gGlb1I25bNwGHFV6L1NDY5GwhUiDrATKMv/ZEE+
         Mxa6PTjOQJtiYEDl1ojHEGCbvvbgO35Jqzd3CcZKk4ArHxSMQqJm5QC4M4+gh5XQ1XL4
         LM6mUP2ug3k8oFFC5QGBl0d0wnlagIyFS63wM/f8ufmFXrI9YiPViay7PTBA6ZAEFEtQ
         XyXrhTE+xpccxoWIfSfY01fQW6liZaumuVGauMX2XSyDlFpmscDj5DJwSFbsf2tG9nKq
         /d9vbzACjjmHUjvNs5096vdAsEnNAJmIZMPzPHyAJWlDQ/xkA4GISC8z/8L7KU3Hf0as
         5gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CH0z3IcaSnuFgTx7ujG0hPd16mi7sVvnxwI9RCjab0M=;
        b=bkQ5RzvNsyg5jd+gG4qObX3vkYkNpfVGJ4yhqEu70CUMvVR52PguKUB6HleZ+eoh3A
         Evz1M7Jy3aIIQDCPHhsgKSDp/QyvbUOQ4i+Q4Js7n2SLBKGMFrGeXCPVWv/Nv9g6b+02
         NWW4nYbTAbv34W5W4c3A692ooVP8RzBFe9V+kiuec6hhQilHANiRH7bFaDciera0XyeR
         MdbHQwBtG1athbwMGyq8l2ZcMxcdV+JYYYD1ZQTpXd5Y2o6eTQ2/xexl4R4VieCXKN7V
         paS8ZI/HeRDJe4aDEA1C9JebCIPWyWQ9MTI9Tib0PbPk9SwN+zcoLB4oNv8DahL8yuLV
         eHJQ==
X-Gm-Message-State: AHYfb5jJVfRC2Fo8YZfti9oyYx6DawvmZKokX+4JABIlKQ/RSY2D3/4v
        SupHUYwbnLT+00R8xkmj3cz/7czDcA==
X-Received: by 10.200.33.232 with SMTP id 37mr25121906qtz.11.1503310798930;
 Mon, 21 Aug 2017 03:19:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.16.242 with HTTP; Mon, 21 Aug 2017 03:19:38 -0700 (PDT)
In-Reply-To: <20170820180332.GC39363@Vurt.local>
References: <20170802185901.GA27243@Vurt.local> <20170820180332.GC39363@Vurt.local>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 21 Aug 2017 12:19:38 +0200
Message-ID: <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
To:     Job Snijders <job@instituut.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sun, Aug 20, 2017 at 8:03 PM, Job Snijders <job@instituut.net> wrote:
> bump?

(As a side note, I have also noticed that gitweb patches tend to go
unreviewed for long)

> On Wed, Aug 02, 2017 at 08:59:01PM +0200, Job Snijders wrote:
>> We often work with very large plain text files in our repositories and
>> found it friendlier to the users if we can click directly to the raw
>> version of such files.
>>
>> This patch adds a 'raw' blob_plain link in history overview.
>>
>> Signed-off-by: Job Snijders <job@instituut.net>
>> ---
>>  gitweb/gitweb.perl | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 3d4a8ee27..ad79c518e 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -5961,8 +5961,11 @@ sub git_history_body {
>>                                         href(action=>"commit", hash=>$commit), $ref);
>>               print "</td>\n" .
>>                     "<td class=\"link\">" .
>> -                   $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
>> -                   $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>> +                   $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | ";
>> +             if ($ftype eq 'blob') {
>> +                     print $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw") . " | ";
>> +             }
>> +             print $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>>
>>               if ($ftype eq 'blob') {
>>                       my $blob_current = $file_hash;

Arguably, the addition of the 'raw' link should be done in the same
conditional that also adds the 'diff to current' link, before the diff
to current link.
This would be more consistent with the tree view (which puts the raw
link last), while still preserving the alignment of the link position
independently of the existence of the 'diff to current' link. (Bonus
extra: smaller patch)

-- 
Giuseppe "Oblomov" Bilotta
