Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9C91F453
	for <e@80x24.org>; Fri, 18 Jan 2019 14:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfAROZH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 09:25:07 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:34652 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfAROZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 09:25:07 -0500
Received: from [192.168.2.240] ([89.242.180.111])
        by smtp.talktalk.net with SMTP
        id kV4ygMmZldJAekV4yg0IuZ; Fri, 18 Jan 2019 14:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547821505;
        bh=i3Q8STtZ8FNiJdfxPW4I+OzcW9ocN8FvXzdpO2Nk39s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mfZeTbLOuR1TcCuaBVVFtD4yxdudb6tNkzV5pI1MZ82ZvetiBUpGskb9YLTrhXrCt
         erMpL5UxlFt4ofh0YoDZ7jIIsZwPPTmb6uzphCKX0NHKgohD93Ombiq1bfZBBK+dE5
         IcCZWrzvGNDAY4ksUkl81LgDvSNspOEBn3qMxt0E=
X-Originating-IP: [89.242.180.111]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yUcx3x9LIBXmIswB4ICbEw==:117
 a=yUcx3x9LIBXmIswB4ICbEw==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=iOsvqyYFUslmJ183oq4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/7] add-interactive.c: implement show-help command
To:     =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.103.git.gitgitgadget@gmail.com>
 <pull.103.v2.git.gitgitgadget@gmail.com>
 <cf4e913a5a01cfb9e9b8b83b222cd4647fbc0bf2.1547797620.git.gitgitgadget@gmail.com>
 <01255e61-a3b1-e509-9f33-36ad07640b4f@talktalk.net>
 <VI1PR05MB577331CCE110D2EAE325927CA69C0@VI1PR05MB5773.eurprd05.prod.outlook.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f58a3664-db5e-b081-a1e6-8869ce3ed392@talktalk.net>
Date:   Fri, 18 Jan 2019 14:25:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB577331CCE110D2EAE325927CA69C0@VI1PR05MB5773.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCWqXijs2bREttnsZ9JAXMdzhQobKfrz4ojeDqvmXm1PiN9wxyzfmYilnxSYf6TEJv2tXeN57T7gbrbRhNygKfKwF6xnvWzm0/nGRuarp2Zo7VUrQwvW
 uwABbIJ5zLT41AaoNKBAVd5Qtrz2tP6LguLpRCVHzjxbvG8qBhygr6tKSaimXwZBcwtbmcYOmiS08UZMcD+YClPFlV5S3ApTMHrJN++Q5aITS9Kx3auODLk9
 1ZUFZcnT/PRhY/1E5bX/WoNKIWD2Bv/aX9QZKtRqie9bvUdDrfeOjGY8nZscsEr3WNvH6liCzohF5bLCMLiVIQELUbgzFv086KlTP68cEeW110Re4r1d6vtg
 oP9M33EI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

On 18/01/2019 12:19, Slavica Đukić wrote:
> Hi Phillip,
> 
> On 18-Jan-19 12:20 PM, Phillip Wood wrote:
>> Hi Slavica
>>
>> I think this round is looking good I've got a couple of comments about
>> the translation of the help text but everything else looks fine to me
>> now. In future when you're posting a new version it's helpful CC the
>> people who commented on the previous version(s).
> 
> 
> Thanks for taking your time to review patches again. I'm sorry for
> omitting you
> 
> in CC, but I've sent re-roll through GitGitGadget, and I guess I thought
> it would pick it up.
> 
> I'll see what happened and keep that in mind.

I'm not sure what GitGitGadget does about CC'ing people but Johannes 
will know

>> On 18/01/2019 07:47, Slavica Djukic via GitGitGadget wrote:
>>> From: Slavica Djukic <slawica92@hotmail.com>
>>>
>>> Implement show-help command in add-interactive.c and use it in
>>> builtin add--helper.c.
>>>
>>> Use command name "show-help" instead of "help": add--helper is
>>> builtin, hence add--helper --help would be intercepted by
>>> handle_builtin and re-routed to the help command, without ever
>>> calling cmd_add__helper().
>>>
>>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>>> ---
>>>    add-interactive.c     | 23 +++++++++++++++++++++++
>>>    add-interactive.h     |  4 +++-
>>>    builtin/add--helper.c |  7 ++++++-
>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/add-interactive.c b/add-interactive.c
>>> index c55d934186..76c3f4c3eb 100644
>>> --- a/add-interactive.c
>>> +++ b/add-interactive.c
>>> @@ -244,3 +244,26 @@ void add_i_print_modified(void)
>>>    	free(files);
>>>    	hashmap_free(&s.file_map, 1);
>>>    }
>>> +
>>> +void add_i_show_help(void)
>>> +{
>>> +	const char *help_color = get_color(COLOR_HELP);
>>> +	color_fprintf(stdout, help_color, "%s%s", _("status"),
>>> +		N_("        - show paths with changes"));
>>> +	printf("\n");
>> There seems to be a bit of confusion with the translation of these
>> messages. "status" does not want to be translated so it shouldn't be in
>> _() - it can just go in the format string as can the indentation and the
>> "\n" (or we could use color_fprintf_ln() to automatically add a newline
>> at the end. N_() is used to mark static strings for translation so the
>> gettext utilities pick up the text to be translated but (because
>> initializes for static variables must be compile-time constants) does
>> not do anything when the program runs - if you have 'const char *s =
>> N_(hello);' you have to do '_(s)' to get the translated version. Here we
>> can just pass the untranslated string directly to gettext so it should
>> be _("show paths with changes"). Putting all that together we get
>>
>> 	color_fprintf(stdout, help_color, "status        - %s\n",
>> 			_("show paths with changes");
> 
> 
> I thought _() was for strings that were already translated,
> and N_() for strings that weren't. And I now see that I also tried to
> translate command names as well, just the opposite of what you suggested...
 > Thanks for clarifying this.

I hope my explanation made sense, feel free to email if you want to 
check anything.

Having thought about it, I don't think we should add "\n" to the format 
string as it means the color will be reset after the new line, it should 
use color_fprintf_ln() instead which adds a new line after it has reset 
the color.

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
>>> +	color_fprintf(stdout, help_color, "%s%s", _("update"),
>>> +		N_("        - add working tree state to the staged set of changes"));
>>> +	printf("\n");	
>>> +	color_fprintf(stdout, help_color, "%s%s", _("revert"),
>>> +		N_("        - revert staged set of changes back to the HEAD version"));
>>> +	printf("\n");
>>> +	color_fprintf(stdout, help_color, "%s%s", _("patch"),
>>> +		N_("         - pick hunks and update selectively"));
>>> +	printf("\n");
>>> +	color_fprintf(stdout, help_color, "%s%s", _("diff"),
>>> +		N_("          - view diff between HEAD and index"));
>>> +	printf("\n");
>>> +	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
>>> +		N_(" - add contents of untracked files to the staged set of changes"));
>>> +	printf("\n");
>>> +}
>>> diff --git a/add-interactive.h b/add-interactive.h
>>> index 1f4747553c..46e17c5c71 100644
>>> --- a/add-interactive.h
>>> +++ b/add-interactive.h
>>> @@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
>>>    
>>>    void add_i_print_modified(void);
>>>    
>>> -#endif
>>> \ No newline at end of file
>>> +void add_i_show_help(void);
>>> +
>>> +#endif
>>> diff --git a/builtin/add--helper.c b/builtin/add--helper.c
>>> index 43545d9af5..a3b3a68b68 100644
>>> --- a/builtin/add--helper.c
>>> +++ b/builtin/add--helper.c
>>> @@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
>>>    
>>>    enum cmd_mode {
>>>    	DEFAULT = 0,
>>> -	STATUS
>>> +	STATUS,
>>> +	HELP
>>>    };
>>>    
>>>    int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>> @@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>>    	struct option options[] = {
>>>    		OPT_CMDMODE(0, "status", &mode,
>>>    			 N_("print status information with diffstat"), STATUS),
>>> +		OPT_CMDMODE(0, "show-help", &mode,
>>> +			 N_("show help"), HELP),
>>>    		OPT_END()
>>>    	};
>>>    
>>> @@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>>>    
>>>    	if (mode == STATUS)
>>>    		add_i_print_modified();
>>> +	else if (mode == HELP)
>>> +		add_i_show_help();
>>>    	else
>>>    		usage_with_options(builtin_add_helper_usage,
>>>    				   options);
>>>

