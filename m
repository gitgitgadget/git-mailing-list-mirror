From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
Date: Wed, 18 May 2016 09:12:04 +0300
Message-ID: <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
	<xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 08:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2uiN-00066V-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 08:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbcERGMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 02:12:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33752 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbcERGMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 02:12:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so10041255wme.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 23:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UiQ8KtfEJtf/EEBEm6Mw0wYx3BlCWd50trSnyFuB5CI=;
        b=asDS23FGOsPPAWfkRAk0Uk89/WGmxmjhFagzU4LPmU7MlKwMeGWk8XFXKlkFtQRCoJ
         qnar5c0R9E2KtRCC7cz7DepCtKVjy4EzNGRPCriBG2BSdEaGg99MxqR++dC4ZcKkSMCU
         ZgOSTYoQegXWZq+cQfuV4nHeYGXoZxd9wKGAPQULvaSVaVp4Wykj7OBo+I/JKXpCLQkG
         jOCdrU/46yiB8GVLlBpwvl9/NkzC074rH5mKIhc4tR+o9PvAxFpQdHwnxOrWv5VHv73Z
         4p9VEQzl5QuXKO/HFL3nF1x4noH0DrTxLcSLTmJnc8IlRYPTXGGhQLlIRmXfsbgZycw8
         ykRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UiQ8KtfEJtf/EEBEm6Mw0wYx3BlCWd50trSnyFuB5CI=;
        b=dsDoGU+8mlH0+NHuDjgd0ZzpeojvsRjSgQaHjVzq9D9dkOFRsy+J1nujKPMM/JQvSw
         p/YdPhvBaQYko4rzVVOu2DoIf3UWrUiHE/10w7bHU+2UJWW191a/mibVftixkREhsvf5
         X2VwxfHPheeEJPxihu8SmeQqhR36vilMyNjAvq/hy7WGpIHMgSPX6eV3RJhnXs7v3GxX
         XLW5TVAusTtb77AGDtwrezIf6zwQnZb0WY1hHxH0zRX5LT20B3YH+bnRjL4fFIJQ/87X
         hR7L/jEjhtszjAYkU+/030axg6st6BwS1zaCUqAtVSQPIs/56kvbPGrRu6u7i7WJZJma
         Ou8Q==
X-Gm-Message-State: AOPr4FWCbiG/sDAccpjdKvcZTsnHB9T7h44wrKIZs4IJKSYFGyK0hv5Q+mov0FUqFJzzTUxNg33ZKk3vQ65UJA==
X-Received: by 10.194.205.105 with SMTP id lf9mr5046057wjc.25.1463551924198;
 Tue, 17 May 2016 23:12:04 -0700 (PDT)
Received: by 10.28.170.10 with HTTP; Tue, 17 May 2016 23:12:04 -0700 (PDT)
In-Reply-To: <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294935>

ping?

On Thu, May 5, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pat, we haven't heard from you for a long time.  Are you still
> around and interested in helping us by maintaining git-gui?
>
> Otherwise we may have to start recruiting a volunteer or two to take
> this over.
>
> Thanks.
>
> Orgad Shaneh <orgads@gmail.com> writes:
>
>> git commit --amend preserves the author details unless --reset-author is
>> given.
>>
>> git-gui discards the author details on amend.
>>
>> Fix by reading the author details along with the commit message, and
>> setting the appropriate environment variables required for preserving
>> them.
>>
>> Reported long ago in the mailing list[1].
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/243921
>>
>> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>> ---
>>  git-gui/lib/commit.tcl | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
>> index 864b687..60edf99 100644
>> --- a/git-gui/lib/commit.tcl
>> +++ b/git-gui/lib/commit.tcl
>> @@ -1,8 +1,13 @@
>>  # git-gui misc. commit reading/writing support
>>  # Copyright (C) 2006, 2007 Shawn Pearce
>>
>> +set author_name ""
>> +set author_email ""
>> +set author_date ""
>> +
>>  proc load_last_commit {} {
>>       global HEAD PARENT MERGE_HEAD commit_type ui_comm
>> +     global author_name author_email author_date
>>       global repo_config
>>
>>       if {[llength $PARENT] == 0} {
>> @@ -34,6 +39,10 @@ You are currently in the middle of a merge that has not been fully completed.  Y
>>                                       lappend parents [string range $line 7 end]
>>                               } elseif {[string match {encoding *} $line]} {
>>                                       set enc [string tolower [string range $line 9 end]]
>> +                             } elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
>> +                                     set author_name $name
>> +                                     set author_email $email
>> +                                     set author_date $time
>>                               }
>>                       }
>>                       set msg [read $fd]
>> @@ -107,8 +116,12 @@ proc do_signoff {} {
>>
>>  proc create_new_commit {} {
>>       global commit_type ui_comm
>> +     global author_name author_email author_date
>>
>>       set commit_type normal
>> +     set author_name ""
>> +     set author_email ""
>> +     set author_date ""
>>       $ui_comm delete 0.0 end
>>       $ui_comm edit reset
>>       $ui_comm edit modified false
>> @@ -327,6 +340,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>>       global ui_comm selected_commit_type
>>       global file_states selected_paths rescan_active
>>       global repo_config
>> +     global env author_name author_email author_date
>>
>>       gets $fd_wt tree_id
>>       if {[catch {close $fd_wt} err]} {
>> @@ -366,6 +380,11 @@ A rescan will be automatically started now.
>>               }
>>       }
>>
>> +     if {$author_name ne ""} {
>> +             set env(GIT_AUTHOR_NAME) $author_name
>> +             set env(GIT_AUTHOR_EMAIL) $author_email
>> +             set env(GIT_AUTHOR_DATE) $author_date
>> +     }
>>       # -- Create the commit.
>>       #
>>       set cmd [list commit-tree $tree_id]
