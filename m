From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] SQUASH???
Date: Fri, 25 Sep 2015 10:52:07 -0700
Message-ID: <CAGZ79katew0UnG2nMrXpnp3AEW+6JgjX9pKaXf6Jb-FfEgeFkw@mail.gmail.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<1443129187-18572-3-git-send-email-sbeller@google.com>
	<xmqqa8sbuxu0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 19:52:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfXAN-0002rM-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 19:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbbIYRwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 13:52:10 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34238 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbbIYRwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 13:52:08 -0400
Received: by ykdg206 with SMTP id g206so120412609ykd.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pGh5og7+XYHM4LSU0ETwFaDgioJ8FD0fUZ7rVjip1WY=;
        b=gji5EK4ltp6/8KE6Fi4hibdfVmfmF7dmPLpBXfGSuP6GwdzTUJY2hgeUhDTNxu82PX
         lcHXXO2HfkdfNUWaTdXW1QJBBkadsN0J3cDwzgsr8u6KK4Y5g4li1NtV9LI7sJRdrQAC
         WEYBX5l58E/no1BfLhjddOvoyBfMJx9c2UC6D6ZSHXE7aPgIrvogi9M4j2/Qcr/72o0s
         Qmp9oRlc4c1S3a3pdspPp8Gj+qI9GgvnavLGrTOLgbxI7bs7KmHb0Wq/vfOB9ZmmLyaX
         XcFG6REAarGtzBj0i+1u5JnBb63mXF05oy3J6WJFskdGtos2AHYRm1F3Xyhb97tRdgTM
         ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pGh5og7+XYHM4LSU0ETwFaDgioJ8FD0fUZ7rVjip1WY=;
        b=P0jScUr1jMNewVVeSvVFbHk7DNHWk1klRXfWIpyJdCKbfpW4yczTAeBqYapGZ/hus6
         +0gvsBMZjLVgX/gMpJ3AGAxn1JvvLpOPMbbqD9YbbHfcYqNmyM+UXQatTWHqLZwOF7BX
         2azI05/GRs/NWbp/xIQ47gXZkpvXuzb3o3MFHDiIsHrt02/+zNT4xKwbHapoEUC01Bc9
         oRPHknfu/AFubxjXzMi0fTqmpvc8UeWQmfuGrbn0l00vLkVlirxOKuxA4dq17TF8E/1Z
         4ogQMhaNjgvmDIP5FRc2yVrOKoN/pi5LMNtcZV/e9KH85PAzxMpn8bMkvE5TKwMBHJtn
         AzEQ==
X-Gm-Message-State: ALoCoQkASGaZmliMnASqiCMQXgSgXlwOrKqvDBICtHRbnNw+dfHTZyw+12PhbxjYhDAFxUFtfwI3
X-Received: by 10.129.31.69 with SMTP id f66mr6051900ywf.174.1443203527926;
 Fri, 25 Sep 2015 10:52:07 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 25 Sep 2015 10:52:07 -0700 (PDT)
In-Reply-To: <xmqqa8sbuxu0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278670>

On Thu, Sep 24, 2015 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  * If you do not die() in start_failure_fn or return_value_fn, you
>>    don't want to write to stderr directly as you would destroy the fine
>>    ordering of the processes output. So make the err strbuf available in
>>    both these functions, and make sure the strbuf is appended to the
>>    buffered output in both cases
>
> I think that is a sensible change.  Don't we want the same for the
> other failure handler, though.  Capture any message from it and
> append it to the output of the process that just finished, or
> something?
>
> By the way, I understand that these two are solely for early review
> and I'll be getting them as either new patches or part of updated
> patches in the next reroll (i.e. you are not expecting me to split
> these apart and do "rebase -i" for you to the last-posted version).
> Asking only to make sure we are on the same wavelength.

Sure. I just wanted to point out the details instead of resending the series.
I'll do a resend later today, hoping to get all issues addressed.

Thanks,
Stefan


>
> Thanks.
>
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  run-command.c | 43 ++++++++++++++++++++++++++++++-------------
>>  run-command.h |  1 +
>>  2 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 494e1f8..0d22291 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -907,6 +907,7 @@ void default_start_failure(void *data,
>>
>>  void default_return_value(void *data,
>>                         struct child_process *cp,
>> +                       struct strbuf *err,
>>                         int result)
>>  {
>>       int i;
>> @@ -977,7 +978,7 @@ static void set_nonblocking(int fd)
>>                       "output will be degraded");
>>  }
>>
>> -/* returns 1 if a process was started, 0 otherwise */
>> +/* return 0 if get_next_task() ran out of things to do, non-zero otherwise */
>>  static int pp_start_one(struct parallel_processes *pp)
>>  {
>>       int i;
>> @@ -991,26 +992,30 @@ static int pp_start_one(struct parallel_processes *pp)
>>       if (!pp->get_next_task(pp->data,
>>                              &pp->children[i].process,
>>                              &pp->children[i].err))
>> -             return 1;
>> +             return 0;
>>
>> -     if (start_command(&pp->children[i].process))
>> +     if (start_command(&pp->children[i].process)) {
>>               pp->start_failure(pp->data,
>>                                 &pp->children[i].process,
>>                                 &pp->children[i].err);
>> +             strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>> +             strbuf_reset(&pp->children[i].err);
>> +             return -1;
>> +     }
>>
>>       set_nonblocking(pp->children[i].process.err);
>>
>>       pp->nr_processes++;
>>       pp->children[i].in_use = 1;
>>       pp->pfd[i].fd = pp->children[i].process.err;
>> -     return 0;
>> +     return 1;
>>  }
>>
>> -static void pp_buffer_stderr(struct parallel_processes *pp)
>> +static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>>  {
>>       int i;
>>
>> -     while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
>> +     while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>>               if (errno == EINTR)
>>                       continue;
>>               pp_cleanup(pp);
>> @@ -1069,7 +1074,8 @@ static void pp_collect_finished(struct parallel_processes *pp)
>>                       error("waitpid is confused (%s)",
>>                             pp->children[i].process.argv[0]);
>>
>> -             pp->return_value(pp->data, &pp->children[i].process, code);
>> +             pp->return_value(pp->data, &pp->children[i].process,
>> +                              &pp->children[i].err, code);
>>
>>               argv_array_clear(&pp->children[i].process.args);
>>               argv_array_clear(&pp->children[i].process.env_array);
>> @@ -1111,15 +1117,26 @@ int run_processes_parallel(int n, void *data,
>>                          return_value_fn return_value)
>>  {
>>       struct parallel_processes pp;
>> -     pp_init(&pp, n, data, get_next_task, start_failure, return_value);
>>
>> +     pp_init(&pp, n, data, get_next_task, start_failure, return_value);
>>       while (1) {
>> -             while (pp.nr_processes < pp.max_processes &&
>> -                    !pp_start_one(&pp))
>> -                     ; /* nothing */
>> -             if (!pp.nr_processes)
>> +             int no_more_task, cnt;
>> +             int output_timeout = 100;
>> +             int spawn_cap = 4;
>> +
>> +             for (cnt = spawn_cap, no_more_task = 0;
>> +                  cnt && pp.nr_processes < pp.max_processes;
>> +                  cnt--) {
>> +                     if (!pp_start_one(&pp)) {
>> +                             no_more_task = 1;
>> +                             break;
>> +                     }
>> +             }
>> +
>> +             if (no_more_task && !pp.nr_processes)
>>                       break;
>> -             pp_buffer_stderr(&pp);
>> +             pp_buffer_stderr(&pp, output_timeout);
>> +
>>               pp_output(&pp);
>>               pp_collect_finished(&pp);
>>       }
>> diff --git a/run-command.h b/run-command.h
>> index 3807fd1..f7035cb 100644
>> --- a/run-command.h
>> +++ b/run-command.h
>> @@ -138,6 +138,7 @@ typedef void (*start_failure_fn)(void *data,
>>
>>  typedef void (*return_value_fn)(void *data,
>>                               struct child_process *cp,
>> +                             struct strbuf *err,
>>                               int result);
>>
>>  /**
