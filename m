From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Fri, 26 Feb 2016 14:49:42 -0500
Message-ID: <CAPig+cRTz_VYt-2q9y0+COhVCezMs-7Sm-v=jvhUxUSRhiN93g@mail.gmail.com>
References: <20160223102559.GA18668@iki.fi>
	<CAPig+cSwQmbvZYbk3T-XYDfMYaMdJ=bFbDwEUtaR121pBrYJOQ@mail.gmail.com>
	<20160226082828.GA5960@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Mathias Nyman <m.nyman@iki.fi>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOOa-0007nt-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbcBZTto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:49:44 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35126 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbcBZTtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:49:43 -0500
Received: by mail-vk0-f47.google.com with SMTP id e6so86792991vkh.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=9m2tUqUswFIgFsBRpmqPMuXYMgR+XznjTz9C0GvpKZg=;
        b=Bs+iQfVHoP0cnOq2xMUhvVQ3Rou/CyJkHyYVHszzFWfj9RfUOEXEgC4hZ7rWpQx248
         3kEkET7pfOgKCFMf7xkt+lc9hRYf7hsh57Z9qu4Pqf3h2dEmTekO2+qcrZHbbs4EnONz
         e/J6qQ7QWz5lMBLgkjGZnMOWj3EGChWIS+VFzztuQGA1RCvWa4gzLLP6Bae+MX0CB6q1
         v6uEzxRUvieX7F4UmKAVcwtgeCZDotneR3WgHcJ1IbYguFTsJ4ANbtogrphMjj3n9LjS
         mcd4kGlsxQz00JkSLfsTpjtSixmvCM30w7POEY9fUGHDgnTfdZtx4+fgKOHNUYfvgVUH
         PFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9m2tUqUswFIgFsBRpmqPMuXYMgR+XznjTz9C0GvpKZg=;
        b=P+Jc7MMdSi96iMm6o850rQyq4RQMFLGQKqt8JUUSqR3xc7U4SGTj12tSMSvfVXLM9E
         5eV5C7oxj+1cjJbGlDOdtmKY3G19wHPeF+FDEtzNlwb2uWz2dTjMZvQFgfCNcTz7YMx2
         FUgr76hKIzEaS8zGx+QkWOjz5P8giOwz+cQOlBBOnxmAxSpgvCFNP7m6xSQ0jFVsB3eN
         t3KAr3k6MzGOvVBR0L16ySDZ4oNXxgjpzd8EGdpvKE+rqBHwPQeZ+/G7fYZTf+Yv2ZAW
         xGRXRFuqArLoRND3Gd9s/ybN8GEBeRPdouGRTwXkaeWN/j0ma2d393oMy9sFA09MzW0c
         bnTg==
X-Gm-Message-State: AD7BkJJ+FpN6sutb30Pna2OE382T/P6khc81UHXQR9GmQA/ixWi3LYwBBGdl9cFAKnV/OZrQnMJ0g/w3nsOGCg==
X-Received: by 10.31.146.2 with SMTP id u2mr2274765vkd.19.1456516182710; Fri,
 26 Feb 2016 11:49:42 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 26 Feb 2016 11:49:42 -0800 (PST)
In-Reply-To: <20160226082828.GA5960@iki.fi>
X-Google-Sender-Auth: oCQ9jzeMIxZygVu2r-XcOOHx2VI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287614>

On Fri, Feb 26, 2016 at 3:28 AM, Mathias Nyman <m.nyman@iki.fi> wrote:
> On 2016-02-25 17:23-0500, Eric Sunshine wrote:
>> On Tue, Feb 23, 2016 at 5:25 AM, Mathias Nyman <mathias.nyman@iki.fi>
>> wrote:
>>> -       cat <<-EOF
>>> -               $commit_message
>>> -
>>> -               git-subtree-dir: $dir
>>> -               git-subtree-mainline: $latest_old
>>> -               git-subtree-split: $latest_new
>>> -       EOF
>>> +       echo $commit_message
>>> +       echo
>>> +       echo git-subtree-dir: $dir
>>> +       echo git-subtree-mainline: $latest_old
>>> +       echo git-subtree-split: $latest_new
>>
>> It's not clear why this code was changed to use a series of echo's in
>> place of the single cat. Although the net result is the same, this
>> appears to be mere code churn. If your intention was to make it
>> similar to how squash_msg() uses a series of echo's, then that might
>> make sense, however, rejoin_msg() uses the same single 'cat' as
>> add_msg(), so inconsistency remains. Thus, it's not clear what the
>> intention is.
>
> Using a mixutre of heredoc and echo felt messy. But I'll change it
> back to heredoc here, and through out the commit aim for near-zero
> refactoring.

An alternative would be to have a preparatory patch which unifies the
heredoc vs. echo issue across add_msg(), squash_msg(), rejoin_msg(),
but I wouldn't insist upon it (that's just more work for you). Leaving
this bit alone is a reasonable choice.

>>> +       repo="$4" # optional
>>>         newsub_short=$(git rev-parse --short "$newsub")
>>> -
>>> +
>>
>>
>> Okay, this change is removing an unnecessary tab. Perhaps the commit
>> message can say that the patch fixes a few whitespace inconsistencies
>> while touching nearby code.
>
> Will undo the whitespace fixing.

Oh, I wasn't insisting that you should undo the whitespace fix.
Typically, you'd make such fixes in a preparatory cleanup patch, but
since there are only two cases here that you've fixed, it probably
wouldn't hurt to retain them (if that's all there are in the file).
The reason I suggested mentioning the whitespace fixes in the commit
message is to let the reviewer know that they weren't cases of you
accidentally making unwanted whitespace changes (like inserting tabs
rather than removing them). As it was, as a reviewer, I had to go
through extra effort to determine whether you had made a fix or had
accidentally botched something.

>>>  cmd_merge()
>>>  {
>>> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
>>> +       revs=$(git rev-parse $default --revs-only "$1") || exit $?
>>
>> Why is this variable still named 'revs' (plural) since you're only
>> passing in $1 now rather than $@?
>
> Because technically the result can still be more then one rev I guess.
> Consider 'git rev-parse HEAD~1..HEAD', which would return two hashes.

Okay, so I was missing something obvious.
