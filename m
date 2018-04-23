Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36971F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeDWRdG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:33:06 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeDWRdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:33:04 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue007
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lxqhk-1eNOc31b1g-015Ge1; Mon, 23
 Apr 2018 19:32:59 +0200
Date:   Mon, 23 Apr 2018 19:32:58 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180423173258.GA11114@furore>
Mail-Followup-To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmJBzBFDAi1FQAgytb82-Q7JhO+aOfKi=YBZ3YtNxwPTQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:tgRBrd8ETdzj5HlHZaKdJXMWhDhlbewnZWX1Ksd+jR6LrIRR/th
 mENbLCOZd5rjxrOW0+25v10AlNlK7ZnxCK42k/u1NRlm32njc4N7K2KKIBrMvUkiBK12VBu
 52UCbQxnlBjxmQKn0hEOXhyTqgmQt0ZKSEXvOdsatu6DU2Z5Q5bCm+4v8B5UXgVsE+IGb7X
 Zlj6reynbfoIkOk1UdbjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qrwutNjbF4A=:TKDH+U7KifCtbzZLMIEWeu
 gCd1BtE5VLJNl5vz64cXy7nV54Ai0KcYhVAamTmQt9VcNqk5OSs1DNDj3O8Kd+lLj5zskQGoN
 fTfxvTkFOkPPl8q4jlmxbaauON4lFn4LrjD5jANtZDnMynHxKEJjgQT0DSMhnJFMBO2O2E9V1
 caUFBenHSM58hBYDzRcPgAy8qgZWn7L6FLAXNe89Fc8aOLMX8+wmeQ2696PwArxICIqFYrKEz
 I+wFwy44xmfbozM+gUMobsIaHZjHa+bJW7PIUiKHHMja+Hy6iUD4jP3/npzF177XoHAsDDpTM
 uI3Ic3wp637ek7Ar5sIN42Z/a9fEmi0jvdqpFJj7ddk/xrGJNUPoy8tOCgENRvSPANubVuFup
 QxBsk6HS26yTNFr2Nu4jDnCcWFcb8HRrIE9ie+VsSyHPR/5EGVrLuLOHnQVYxIvRDa/QEfGwL
 oS8RCckJMmkTPbm0vsJWxF7C76kt7U6K/L9rEVf7Lb+vnNZJnkiERNGmwgw4kkMF0fsgDBju8
 pGoOy+ysln4TValFK7pjN3RVthQRQnb+rc5fzaJGJ0Co3/fy7ZE8uWJpiO0G+3imw5Io8F/N5
 cGmFht31eTAkL1nUu07GGIA9KsxkO9/EuEWP237PvUdQTwzIL3o2fe4UbUP3nde4hRR8QM6km
 vQ3hzkt7XV7JUgxT3xEUuiy52VTfj5qsFIJpPwxARYa04BexhtUYklWMjHivdWUYX/spciZk9
 WVhcY4TFpWx+3SZd6P/tOq4+Qb2S2hssuZZ+oQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-23 17:12, SZEDER Gábor wrote:
> On Thu, Apr 19, 2018 at 9:07 PM, Florian Gamböck <mail@floga.de> 
> wrote:
>> On 2018-04-18 21:51, SZEDER Gábor wrote:
>>> Would it be possible to use _xfunc() instead to plug that hole?  It 
>>> seems the be tricky, because that function not only sources but also 
>>> _calls_ the completion function.
>>
>> But isn't this exactly what we want?
>
> No, that's definitely not what we want.
>
> The bash-completion project can get away with it, because they only 
> use their _xfunc() to source a file they themselves ship and to call a 
> completion function they know that that file contains.
>
> We, however, would like to load a file that might not exist and to 
> call a function that might not be defined.  Git has a lot of plumbing 
> commands with neither a corresponding _git_plumbing_cmd() completion 
> function in our completion script nor a corresponding 
> 'git-plumbing-cmd' file that could be sourced dynamically to provide 
> that function.  The same applies to any 'git-foo' command in the 
> user's $PATH (the user's own scripts or various git-related tools, 
> e.g. Git LFS).
>
> So if someone tries e.g. 'git diff-index <TAB>' to complete files in 
> the current directory, then it would result in an error message like
>
>  _git_diff_index: command not found
>
> Furthermore, earlier versions of _xfunc(), I think until the 
> introduction  of __load_completion(), tried to source the file given 
> as parameter without checking its existence beforehand, so on whatever 
> LTS I happen to be currently using I would also get an error like
>
>  bash: /usr/share/bash-completion/completions/git-diff-index: No such 
>  file or directory
>
> Finally, since all this is running in the user's interactive shell, 
> Bash will even run the 'command_not_found_handle', if it's set (and 
> most Linux distros do set it in their default configuration (OK, maybe 
> not most, but at least some of the more popular do)), which may or may 
> not have any suggestions, but at the very least it takes quite a while 
> to scan through its database.

You're right, this could be a problem.

Then how about the following patch? This is one of my very first 
iterations of this patch, before even sending it to the mailing list. 
Actually this is similar to what the original _xfunc did, plus existence 
checking and minus premature function calling. In the directory of the 
git completion script, if there is an appropriate script for the current 
subcommand, if it is a regular file (or a valid symlink) and if it is 
readable, then source it and test the existence of the completion 
function again. Likewise for a possible alias.

-- >8 --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2615,10 +2615,21 @@ __git_main ()
 	local completion_func="_git_${command//-/_}"
 	declare -f $completion_func >/dev/null && $completion_func && return
 
+	local completion_dir="$(dirname ${BASH_SOURCE[0]})"
+	local completion_file="$completion_dir/git-$command"
+	[ -f "$completion_file" -a -r "$completion_file" ] && . "$completion_file"
+	declare -f $completion_func >/dev/null && $completion_func && return
+
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
+
 		completion_func="_git_${expansion//-/_}"
+		declare -f $completion_func >/dev/null && $completion_func && return
+
+		completion_file="$completion_dir/git-$expansion"
+		[ -f "$completion_file" -a -r "$completion_file" ] &&
+			. "$completion_file"
 		declare -f $completion_func >/dev/null && $completion_func
 	fi
 }
