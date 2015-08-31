From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] read-cache: fix indentation in read_index_from
Date: Mon, 31 Aug 2015 12:34:57 -0700
Message-ID: <CAGZ79kbQmmcJMW=07A1pyHdbViJTfseG4L-kspKEvyugTO7R4g@mail.gmail.com>
References: <1441046609-24181-1-git-send-email-sbeller@google.com>
	<xmqqpp23uuhk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:35:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUr9-0000DA-5E
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbbHaTe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:34:59 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34972 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbHaTe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:34:58 -0400
Received: by qkcj187 with SMTP id j187so13439729qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s9ej7BRNZ7jRv8ALeKK60rh+9PQ4lOTVFQsMzocE31k=;
        b=UECIywHaBALPrSDAnc1vG2rGxs6irdbk+ou9994I4K1R8wWnxd95bW2f67AOtvNBhC
         EpR2R3k7sgAKu1PjxteEz7XctMqhBYD8474K+A0M4HDrOiFZQHH6U0EHlYq3xYODhWkF
         qKH1QLukBphmDLClqq7ElRtre9EWpxvnUhupRAWXJW4Gk4hkq2KwlFKGDEutmHPY8HHa
         c/lk/77BqZRjc0ADEg4veSlYJ3zoJilG1TzBz+xLuahv+YHxeaamp6HxIPTTvr0NRkJa
         IstlL53e09j2hOOD9/UCXBSqj7Ex3ImOtO9KZMZ9B8+Y46006u47W4+3CQOm+10JSBDm
         Zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=s9ej7BRNZ7jRv8ALeKK60rh+9PQ4lOTVFQsMzocE31k=;
        b=XD/rpXFfd9unIgX3VMv1U/Xw3Lv5ALwult9Odr/IaAbwVPV+v/zcC4FC3OUOuhQaQd
         MtEVdblk4EfzIiQyNmSsdvFX0j/UU345LhOYvrDBHX1zvHRvsIb2R1cNONmMJoyHniRr
         kJfqkWe5BQdgWGdjj8Gka0hcbumbPCwAtkgHn5t0QFS0NHvKBEcGwytSOJKOTuVu7ELB
         nUy5BhS/huBiDuw2mhpt7Uma7JaQUBIeKFwwBi4IV0znT14ZYVroB61u4xNYeD983SxY
         oHLhvL1jmVXPIEdfVomoHFCJMF4cPvVLCDVt4Z8YZhip7qTwov3uDF1rmAAIZT2JqGen
         eeMQ==
X-Gm-Message-State: ALoCoQnPIe7P8SfOLzog0qWh213VQyImw56N0SBAtVYZDfpiy1fPWoYwcDOJi9/DUaXsTpxIfSvC
X-Received: by 10.13.254.4 with SMTP id o4mr15853215ywf.88.1441049697398; Mon,
 31 Aug 2015 12:34:57 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Mon, 31 Aug 2015 12:34:57 -0700 (PDT)
In-Reply-To: <xmqqpp23uuhk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276924>

On Mon, Aug 31, 2015 at 12:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  read-cache.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 89dbc08..a3df665 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1653,7 +1653,7 @@ int read_index_from(struct index_state *istate, const char *path)
>>               die("broken index, expect %s in %s, got %s",
>>                   sha1_to_hex(split_index->base_sha1),
>>                   git_path("sharedindex.%s",
>> -                                  sha1_to_hex(split_index->base_sha1)),
>> +                          sha1_to_hex(split_index->base_sha1)),
>
> We allow two styles in our codebase, (1) indent to align with
> opening parenthesis, or (2) indent sufficiently deeper than the
> first line with HT.  The original is neither, so in that sense
> it is a good thing to do in the long run.
>
> I'll queue it for this time, but in general, I'd prefer if people
> refrained from touching code only for style fixes in an area that is
> touched actively in topics, unless it is done inside a topic that
> has to touch that area of the code in order to do something more
> than style fixes.

Right. :(

The problem here is that I was looking to use read_index_from
in the submodule code to implement recursive actions, but as I
could not find documentation on how to use it, I read the code.
And whenever I see obvious things to fix (such as style),
I cannot stop myself from shooting from the hip, sending a patch.
I'll stop doing that.

>
> Thanks.
>
>>                   sha1_to_hex(split_index->base->sha1));
>>       merge_base_index(istate);
>>       check_ce_order(istate);
