From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Fri, 28 Mar 2014 18:52:02 -0700
Message-ID: <CAMuNMfruJ14Yso-2BvV4C-3DA5J5AcXm6hX9Ydm8f88MWeb8gw@mail.gmail.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
 <1395353785-23611-4-git-send-email-jlebar@google.com> <CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
 <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com> <CAEjxke-Qe=CYwR9akZ9anjjbO3Tf83f-Y0J4qOJ+i4pKZ=-vAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Sat Mar 29 02:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTiS1-0000ez-Bz
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 02:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbaC2BwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 21:52:25 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:47788 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaC2BwY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 21:52:24 -0400
Received: by mail-qg0-f41.google.com with SMTP id e89so1471967qgf.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Vkp6o56MGYbyVbDV9lTrzLgdZ3OsCkXm7t35uel9gkQ=;
        b=FJw8DB17k6sIQz5pIz/EDEUCo4/IsK+NKvr49Q002sIhnRBhrtKWOHbv1na6v7pSZp
         kmQzMYqUviFa9l9vwgmZVUCjiEFUvlF4zNgfZBsCxgMPbNQgGCvMT9cKrL5uP9nMbJzO
         9IrZz9FzLT/o9+//BSnFz0chPDT2N4QuHyjUf0dkmXBZwQrlXtFKbRQ5NsDm9fNsWNNn
         WfTC4Az+rFZNaI7VAxmx5zHOyZUzaQKmyslDI85M4N0+7qrl4O6eUzx6gWWwCBaYGhBj
         hemygj33kVoe/XX386h6274HN/9tyrbgHmJWSaBn6x3KUrArwkMt80aRMD8ZimLGvVzu
         LajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Vkp6o56MGYbyVbDV9lTrzLgdZ3OsCkXm7t35uel9gkQ=;
        b=Zk9xhHRyJcEbteyFhEquFqNUiZddaajK/XnPVS5mF4Iv7+k/l7P4oJghnqVd76voQb
         BDF4MLaIlEmTjUa96iQG12LQQj+aMYp/eyGmGkorRuaXPbRLQjjs5Y3vbSnkmSmyZ05E
         woI5s/SR+WWk4ouJJkKAemdVOnJM5F6NtGpMIgkZDsYPLE6bDsWOu6K0IwsMfaf6zNBz
         FisNxZxC3ccGDuskAPqafP05lQInyONq8Bkogz+aCdf84qFoCaDltKaWfw/mr4+TyKL4
         tURFtB0sRzDh9Toqp6JMUKQnRTl/twwwxG/ISt7ZS1tnyVDSV3OJkQr8Cd1pDm6xXAxz
         IG2A==
X-Gm-Message-State: ALoCoQl9vn7nhpPb7+ci82FNp/vaJNqycAdyht5xQurI9lOaH+6O8LuMYzVnAA9KI5zoQO6J/tR2pP0jSNm27VXZfnOWkwTMyuPj+zHxQMUCyIPN+ERDaYGxnpiH5IL7oiu53BmPZgRxSp86/AsIOx311FAnHWQn/re7fkBFLEdUOBIkXIUk3lBvwdm8vyhp++nswFXSZ6e/
X-Received: by 10.224.127.129 with SMTP id g1mr13065171qas.22.1396057943728;
 Fri, 28 Mar 2014 18:52:23 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Fri, 28 Mar 2014 18:52:02 -0700 (PDT)
In-Reply-To: <CAEjxke-Qe=CYwR9akZ9anjjbO3Tf83f-Y0J4qOJ+i4pKZ=-vAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245431>

> I feel like I'm splitting hairs, but I think there's a change in
> meaning if you use that phrasing. The difference being "not expecting"
> vs. "should not". I don't know which is correct, so I'll defer that to
> someone else.

Okay, changed to

+ * This shouldn't be be set by the Makefile or by the user (e.g. via
+ * CFLAGS).

My intent is not to get hung up on any of these points, so I'm also
happy to punt on this or any hunk.

I'll send out new versions of the patches which apply to maint,
master, next, and pu in a bit.

-Justin

On Sat, Mar 22, 2014 at 4:47 PM, Jason St. John <jstjohn@purdue.edu> wrote:
> On Thu, Mar 20, 2014 at 7:13 PM, Justin Lebar <jlebar@google.com> wrote:
>> Thanks for the quick reply.
>>
>> When I send a new patch, should I fold these changes into the original
>> commit, or should I send them as a separate commit?
>>
>>>> diff --git a/builtin/apply.c b/builtin/apply.c
>>>> index b0d0986..6013e19 100644
>>>> --- a/builtin/apply.c
>>>> +++ b/builtin/apply.c
>>>> @@ -4061,7 +4061,7 @@ static int write_out_one_reject(struct patch *patch)
>>>>                 return error(_("cannot open %s: %s"), namebuf, strerror(errno));
>>>>
>>>>         /* Normal git tools never deal with .rej, so do not pretend
>>>> -        * this is a git patch by saying --git nor give extended
>>>> +        * this is a git patch by saying --git or giving extended
>>>>          * headers.  While at it, maybe please "kompare" that wants
>>>>          * the trailing TAB and some garbage at the end of line ;-).
>>>>          */
>>>
>>> I don't think the change from "give" to "giving" here is grammatically correct.
>>
>> Is it?  I might be misunderstanding the sentence, then.  I parse the
>> new sentence as
>>
>>   Do not pretend this is a git patch by
>>   - saying --git, or
>>   - giving extended headers.
>>
>> "Giving" is definitely awkward, but I'm not sure of a better word.
>>
>> I'm happy to rephrase this, but I'm not sure how.  I don't think the
>> original makes much sense, but I'm also happy to leave it.
>>
>
> You're right; that makes sense. Disregard my comment about that chunk.
>
>>> How about ``If none of "always", "never", or "auto" is specified, then setting layout
>>> implies "always".``?
>>
>> Sure.
>>
>>> To leave "nor" here, I think you need to replace "not" with "neither".
>>
>> I think it actually works after the change, but unfortunately Garner's
>> doesn't give me a lot of ammunition to back up that feeling.  :)
>>
>> How about "We don't expect this to be set by the Makefile or by the
>> user (via CFLAGS)."
>>
>
> I feel like I'm splitting hairs, but I think there's a change in
> meaning if you use that phrasing. The difference being "not expecting"
> vs. "should not". I don't know which is correct, so I'll defer that to
> someone else.
>
>>> This would be better worded as "If src_buffer and *src_buffer are not NULL, it should ..."
>>
>> Done.
>>
>> -Justin
>
> Jason
