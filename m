Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5662320A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 09:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdITJCI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 05:02:08 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:46678 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdITJCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 05:02:06 -0400
Received: by mail-it0-f45.google.com with SMTP id 6so1913061itl.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DzlzaXweZuobZuYLgZCb1x4K0MgJw6R8sCOmKi9wglo=;
        b=eZPgtdhnFsagu3we7gpujCGLkTOt8XoJ1K5SDTqqvlBySaC9EjLHKyEWvqm+9fCrmP
         R7XfZRsLXsF359p//pLkas4NyVlemtuh7sAJh48x6YyOSDdfPn5jtGp20o7z2zr+8duo
         WfBUcSu9qBHhmsSEA5S1ls1NMNtM0W5GHSAz1/u0H5DvciDaKTB96dhgnln62cwX6xPk
         dK5+hqlfLozyNvyCaHsgd2qwWa9LR778jkL9dSFwabFRdvLb6RfBha97N32Y6qkvMlXh
         yqX27MqYsXAgznmeZwrPSoowsAuUc76OFjJ+GjRQj+0d0MEEBix/cop0Xwrh6pbrmRJq
         MGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DzlzaXweZuobZuYLgZCb1x4K0MgJw6R8sCOmKi9wglo=;
        b=Iex0is+FCzc9G+L7sJsmBTa+A3ynRzorgUXCoqatBIhg1ImZDXjh2WcNGXpDkT6Ar/
         mAQM+IjPGe7m36w46LtAK5wQ7ghz5zbZ1TCUK05n4UcohtK2w8LXRiZZw05/KivdiE7z
         tmNl/qsV07oT6/HCC14CAlFD1w3xvd8uIhtlyxDAsiruKfUd5P8dPAGxshCWCvdxebsY
         ivQPDKDcYJOi+zN5HZNjw65LZKadcwFbyphINdQjrH1mWpAm3fE4G2od3oKHPhQghW0k
         Jc7hnAk484Gn4E50vNG/vjX35GyM44r51HMR+UgyCmU8HHVFjLqIrGR3VRbnBCC9bCBD
         2YoQ==
X-Gm-Message-State: AHPjjUioSWNXgseH3VRr7YWYn8px4FH4TWKRRwklg9+kuZDvK3eYzh/D
        SodA5U9r3fTn+4HjxGM309+mq1m4
X-Google-Smtp-Source: AOwi7QBFvld7cRXoNdZxePqm8PnGLPkvb/x4EjlzgINbtmgxBnFl97xVZmn67dk3LcAnaR+F1NUj3Q==
X-Received: by 10.36.204.135 with SMTP id x129mr1921544itf.7.1505898125341;
        Wed, 20 Sep 2017 02:02:05 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id r14sm2106068ith.4.2017.09.20.02.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 02:02:04 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] branch: document the usage of certain parameters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-3-kaarticsivaraam91196@gmail.com>
 <xmqq4lryovnm.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <d4e61e9b-e7ed-3565-6017-128b2fe3b72a@gmail.com>
Date:   Wed, 20 Sep 2017 14:31:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lryovnm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 September 2017 09:42 AM, Junio C Hamano wrote:
>
>> @@ -15,6 +15,11 @@
>>    *
>>    *   - reflog creates a reflog for the branch
>>    *
>> + *   - if 'force' is true, clobber_head indicates whether the branch could be
>> + *     the current branch; else it has no effect
> Everybody else in this list begins with what it is describing for
> easy eyeballing.  Can you make this match that pattern?

Sure!

> Also, what does "could be" mean in that sentence?  Is the caller
> telling the function "how, I do not exactly know if that is the
> case, but the branch I am asking to create you might be the same
> branch as what is currently checked out, so be extra careful"?
>
> Or is the comment telling a potential caller that it can pass true
> to signal that create_branch() is allowed to (re)"create" the branch
> that is already checked out (hence it already exists)?

Thanks. I didn't anticipate the possibility of misinterpretation.

> I think the confusing statement above arises because an assumption
> is unstated there.  If the reader knows "Even with force, calling
> create_branch() on the currently checked out branch is normally
> forbidden", then the reader can guess your "could" mean the latter.
>
> 	- clobber_head_ok allows the currently checked out (hence
>            existing) branch to be overwritten; without force, it has
>            no effect.
>
> perhaps?

Sounds better. Will use it.

> ...  As the underlying helper calls it clobber_head_ok, and
> that name is more clearly expresses that this is a permission than
> the current name, I chose to add _ok to the above example, but if
> you are to take the suggestion, you'd need to also update the names
> in the declaration, too.

Yes.

One thing I haven't done suspecting it wouldn't be encouraged is,
rearranging the order of parameters to group the related ones
together i.e., something like,

diff --git a/branch.c b/branch.c
index 703ded69c..0ea105b55 100644
--- a/branch.c
+++ b/branch.c
@@ -229,7 +229,7 @@ N_("\n"
  "\"git push -u\" to set the upstream config as you push.");
  
  void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head,
+		   int force, int clobber_head_ok, int reflog,
  		   int quiet, enum branch_track track)
  {
  	struct commit *commit;
@@ -245,7 +245,7 @@ void create_branch(const char *name, const char *start_name,
  
  	if (validate_new_branchname(name, &ref, force,
  				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head)) {
+				    clobber_head_ok)) {
  		if (!force)
  			dont_change_ref = 1;
  		else
diff --git a/branch.h b/branch.h
index 33b7f5d88..c62763ac9 100644
--- a/branch.h
+++ b/branch.h
@@ -13,10 +13,10 @@
   *
   *   - force enables overwriting an existing (non-head) branch
   *
- *   - reflog creates a reflog for the branch
+ *   - clobber_head_ok allows the currently checked out (hence existing)
+ *     branch to be overwritten; without 'force', it has no effect.
   *
- *   - if 'force' is true, clobber_head indicates whether the branch could be
- *     the current branch; else it has no effect
+ *   - reflog creates a reflog for the branch
   *
   *   - quiet suppresses tracking information
   *
@@ -24,8 +24,8 @@
   *     that start_name is a tracking branch for (if any).
   */
  void create_branch(const char *name, const char *start_name,
-		   int force, int reflog,
-		   int clobber_head, int quiet, enum branch_track track);
+		   int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track);
  
  /*
   * Validates that the requested branch may be created, returning the
diff --git a/builtin/branch.c b/builtin/branch.c
index 355f9ef5d..62c311478 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
  			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
  
  		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-			      force, reflog, 0, quiet, track);
+			      force, 0, reflog, quiet, track);
  
  	} else
  		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 76859da9d..116d4709d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -641,8 +641,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
  		else
  			create_branch(opts->new_branch, new->name,
  				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_log,
  				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_log,
  				      opts->quiet,
  				      opts->track);
  		new->name = opts->new_branch;


Can I do this or should I keep the patch focused around the
documentation part alone?

---
Kaartic
