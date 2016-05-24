From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Tue, 24 May 2016 10:24:30 +0200
Message-ID: <CAP8UFD0FrK2tL49SLUxX5Zq4PHsmOP3aih9M9VAxw31P9eRH2Q@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
	<xmqq37pndn2x.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD05JuxG21MAV0wSYz+Vzqb8-unjW-rOSJ_c9YWWOoTTSQ@mail.gmail.com>
	<xmqqy47c7awg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 10:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57dm-0004rq-N4
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbcEXIYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:24:34 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36344 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcEXIYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:24:32 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so116460797wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TvCM4hKBg86dGlhBNeeNpD6PGDBz9z0IG8cncTBKVJw=;
        b=MuJycvvva86Gus6HmMM/jNs64v38eu+XG1+h0vXyX5i6XktYk0qNqelEDcHWASKCwk
         5tGY61b35emO1TokY2QImijyLyMftXuxz4rThlgqP4EWTPREC7Gppc1oeyH63Jloxybq
         qvpCMNJg+dpM5xay/D7iTFCBtt9+W0o+P6IncrlmcYD0Lvjo6JvQBdIbEyc3417T88IL
         72NHcOUwoBeQ027fJ2hEgeFvDfakR1gD4qtCgas38bIj4F03YEDBfC3gwGF9dt9MmX9p
         rVk/PXTV4LXrwPZLMuFBvnpdbaaWdv36L5EORG2A2yXDYQC1Uu8+1NmEew+RC4oiNkWb
         3M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TvCM4hKBg86dGlhBNeeNpD6PGDBz9z0IG8cncTBKVJw=;
        b=Iek/+0N8UkP9oMeId96AaiPvBwWE9CxQeC56oBFSvtICdrhWHUsLf90vX8DDWPNwP+
         tJIpRgtDszoRhBzTv3MoOI9Wfnoe0TJ69LbcTSzQR0Cm8xZ0ly5sUL3nVq/6TZb3TaTd
         44dNwH1Z4MYOkKsy7HdUbQbF2r4ga/fPXXl26hn7sVuXsNlY1egBVoE2QEumR4PgJP5M
         ECYTEYLs1hlqjhgUtqNcJvQ3DjZ1RHD4fOIvnXLmN2rOebtwluiyxni8c52vvylStrTh
         YIqeoscDie21BBZdAFfMQapd8GQv1GPi0v272bmUDABmv9vtgcezeAG3kpv+yfRBgzP1
         +TZw==
X-Gm-Message-State: ALyK8tLxO2zcaxK+NxLZsGyd6POao2TILm0e1cZR8v6GX4VF2v0XzA6rJm2XY+93O/g9KCAnmhzzmPhQ0Okv7A==
X-Received: by 10.194.109.4 with SMTP id ho4mr2823336wjb.78.1464078270729;
 Tue, 24 May 2016 01:24:30 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 24 May 2016 01:24:30 -0700 (PDT)
In-Reply-To: <xmqqy47c7awg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295478>

On Sat, May 14, 2016 at 8:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Thu, May 12, 2016 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Up to this point, the conversion looks quite sensible, even though I
>>>> think the organization of fields in apply_state do not look logical.
>>>
>>> I'd stop here for now, as everything before this step looks
>>> uncontroversial.  Anybody whose tasked to move the global state for
>>> these variables into a structure would reach the samestate after
>>> applying these 48 patches, modulo minor differences in the way the
>>> comments would say things, how the patches are split and how the
>>> fields in apply_state() are organized.
>>>
>>> One thing that is missing is a counterpart of init_apply_state().
>>> In the early part of patches where it added only "const char *"
>>> borrowed from the caller and fields of intregral type, the lack of
>>> clear_apply_state() did not mattter, but with a few fields with
>>> "string_list" type, anybody who want to make repeated call into the
>>> apply machinery would want a way to release the resource the
>>> structure holds.
>>>
>>> Because 49/94 is a step to add an unfreeable resource, this is a
>>> good place to stop and then add the clean_apply_state() before that
>>> happens, I would think.  After that, I think both the contributor
>>> and the reviewers would benefit if these early patches are merged
>>> early without waiting for the review of the remainder.
>>
>> Ok, I will add add the clean_apply_state() and resend the patches up
>> to that point soon, so that they can be merged early.
>
> Two more comments:
>
>  - Just like the change between v1 and v2, if we were to introduce
>    clear_apply_state(), it would be nicer if it were done early in
>    the series, ideally at the same time as init_apply_state() gets
>    introduced,

Yeah, I have done that in v3.

> or at least no later than the first field that holds
>    resource that needs releasing is added.
>
>  - I didn't double check if 50 and later still had changes that
>    belong to this "early batch that moves things into a struct" (aka
>    cc/apply-introduce-state) topic, as I stopped at 49 and saw the
>    need for clear_apply_state().  So 48 may not be the ideal place
>    to stop.  From a cursory read of their titles, perhaps 49, 50, 56
>    and possibly 60 should be in this early series?  While 60 does
>    sound like an immediate follow-up to 09/94, it depends on a few
>    "die elimination" changes, so I do NOT think it must be in the
>    early batch.

For v3 I stopped at patch 50 from v2.

Patch 56 moves 'struct apply_state' into apply.h and it can logically
belong to another patch series, as anyway 'struct apply_state' is not
usable by other code as long as the related functions
(init_apply_state(), clear_apply_state(), check_apply_state(), ...)
are not also moved to apply.{c,h}.
