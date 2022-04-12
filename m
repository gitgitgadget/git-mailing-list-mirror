Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99FC433FE
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbiDLKBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377706AbiDLJ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:19 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B11FCF0
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 02:03:14 -0700 (PDT)
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 63D195FFA5;
        Tue, 12 Apr 2022 11:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1649754191;
        bh=GaO+zS+6Rzq0lMk6u2Jb74bdh3bfJZSavyvGjd/PMDk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NdIh8edXc7CE3AMzqR5IT/t6nobyq+z3tNjdOI7lu969ehcx4oLqcMHF/2qLieFfu
         RuNG8l7wVpGE1VVLRvOl2heROIMNngb8S/c8O6YqUo80LUc8xeyL1w5O+UAa42hhCQ
         p56oWALPJ6rNutng3MmKfpr60VpIQG01ZR/7jZmomZMh3P5gI/sZ3BXNhF0i9MARoe
         aPMBBMUCL9TbLmpuFmI/MDLXig0JM1ej4kmCDWRp5KsMTzEpoYj6IJ1BimyZQGx4v8
         lQjwMtP4rl89+odwaNRQdm0zeWWagPRmCpe6fv7PSUNSvpeSfvonjGcLACK4GaC1O7
         GH8v2pjWc1gDg==
Message-ID: <44b46614-9e3d-3f6e-5e65-e1d246ce78c3@free.fr>
Date:   Tue, 12 Apr 2022 11:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] i18n: fix some badly formatted i18n strings
Content-Language: fr
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
 <220412.86y20ahgpu.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
In-Reply-To: <220412.86y20ahgpu.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12/04/2022 à 09:59, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Mon, Apr 11 2022, Jean-Noël Avila via GitGitGadget wrote:
> 
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> String in submodule--helper is not correctly formatting
>> placeholders. The string in git-send-email is partial.
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>      V2.36 i18n fixes
>>      
>>      While translating the latest version of the messages, I encountered a
>>      few errors of formatting or management.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1212%2Fjnavila%2Fv2.36_i18n_fixes-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1212/jnavila/v2.36_i18n_fixes-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1212
>>
>>   builtin/submodule--helper.c | 2 +-
>>   git-send-email.perl         | 7 +++----
>>   2 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 0b8b226c8ff..2c87ef9364f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -3082,7 +3082,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
>>   		OPT_END()
>>   	};
>>   	const char *const usage[] = {
>> -		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start_oid> <start_name>"),
>> +		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
> 
> Okey, so s/_/-/g here.
> 
>>   		NULL
>>   	};
>>   
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index a98460bdb96..5861e99a6eb 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -2096,10 +2096,9 @@ sub validate_patch {
>>   			chdir($cwd_save) or die("chdir: $!");
>>   		}
>>   		if ($hook_error) {
>> -			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
>> -						 $hook_error . "\n" .
>> -						 "warning: no patches were sent\n"),
>> -					      $fn, $hook_name);
>> +			$hook_error = sprintf(
>> +			    __("fatal: %s: rejected by %s hook\n%s\nwarning: no patches were sent\n"),
>> +			    $fn, $hook_name, $hook_error);
> 
> Isn't this much narrower change going to do the same thing?:
> 	
> 	diff --git a/git-send-email.perl b/git-send-email.perl
> 	index a98460bdb96..5adb7593ce3 100755
> 	--- a/git-send-email.perl
> 	+++ b/git-send-email.perl
> 	@@ -2097,9 +2097,9 @@ sub validate_patch {
> 	 		}
> 	 		if ($hook_error) {
> 	 			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
> 	-						 $hook_error . "\n" .
> 	+						 "%s\n" .
> 	 						 "warning: no patches were sent\n"),
> 	-					      $fn, $hook_name);
> 	+					      $fn, $hook_name, $hook_error);
> 	 			die $hook_error;
> 	 		}
> 	 	}

I wasn't sure that msgmerge would correctly handle this, but it seems 
so. So, yes, your version is much less invasive. Mine has an additional 
property of repelling developpers from trying to concatenate strings.
