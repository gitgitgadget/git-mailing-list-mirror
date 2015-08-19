From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2 2/9] Documentation/git-send-pack.txt: Flow long
 synopsis line
Date: Wed, 19 Aug 2015 15:59:45 -0400
Message-ID: <CAD0k6qRtXX3OqeQF_USwiNYA-y+92X65MSJqPKjhNjGka9QXBw@mail.gmail.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
 <1439998007-28719-3-git-send-email-dborowitz@google.com> <xmqqtwrv8328.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:00:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9Ww-0007nd-7k
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 22:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbbHSUAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 16:00:08 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37634 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbHSUAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 16:00:06 -0400
Received: by igui7 with SMTP id i7so14805575igu.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xwV1FtMdPGVN0DSSUrO8lXmFIzuZmgfn8ZAdg4zJVYI=;
        b=VVJhsLWyCpQ+RsoroaPKAY1jv8dC0HYjz65avGSsZ8szEVMT/gaXnX5OYvZbX4tO8d
         DFID8rtMpobIa0l7qT/0GNt4wbziV6+WVWYZGrt4LvJj1u25xsAt4k5+GmdU3gXrr255
         xwdABQNMkuBJoiS8n6onC+hp60xm1uE97kGGaWMDVDyxe1JlivTNhTkNXY0kDh2XJkjk
         P64NKfYitRLvKcM9uiMXfPE/manzlNlscwAyPirREalUt1bUFDXF3JBW8Umvdz9usBWq
         xOdWCwogpk6ir1SK/5xSZh3rkWlpQJQykg2p5smjZZ/AAXWuLpLhOuYoaLzDD3A7gpWC
         08sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xwV1FtMdPGVN0DSSUrO8lXmFIzuZmgfn8ZAdg4zJVYI=;
        b=YTz0ZSnJFIUfFRGAE2KINfeDKuDW5vV6SmpgFbb2CX/PNCO4G9hM7+dh93bM/GonX+
         2VtceBecWHIYEwq8WqXZX2E4FDbRZLBASjIwJKU58piwfBh6jH2HXsGhugEezrD/3DYi
         yjKBdm7WTk4uvebAS4YDC7WtcwFUUCHxhkY+22xdubloVfWC1RQIGEkgogGCHxsm1hd7
         /it49b3XctkK7Fl4pzOh1w3wtseM5LLkIcpt6m1kYLiaPl5VvcKfFzb0hQwi0q6TEBLr
         SXaU7LQr93Xzl9x1ydtdWyABtAm6J1ANTra6Efo5gBnXlSYyXmVntGH0N5H/+445nvhr
         FWwg==
X-Gm-Message-State: ALoCoQnQw4fyMMr2bta213if5RTsNoVpkoZ3joLLg3mN0ECBkSxxijOKV+G2AIApfKfUq1woTEvo
X-Received: by 10.50.110.72 with SMTP id hy8mr28337188igb.36.1440014405348;
 Wed, 19 Aug 2015 13:00:05 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Wed, 19 Aug 2015 12:59:45 -0700 (PDT)
In-Reply-To: <xmqqtwrv8328.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276221>

On Wed, Aug 19, 2015 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>>  Documentation/git-send-pack.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
>> index b5d09f7..6affff6 100644
>> --- a/Documentation/git-send-pack.txt
>> +++ b/Documentation/git-send-pack.txt
>> @@ -9,7 +9,8 @@ git-send-pack - Push objects over Git protocol to another repository
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git send-pack' [--all] [--dry-run] [--force]
>> [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic]
>> [<host>:]<directory> [<ref>...]
>> +'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
>> +             [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]
>>
>>  DESCRIPTION
>>  -----------
>
> As can be expected from the Subject: line, this patch is
> line-wrapped and does not apply ;-)

I produced the patch with "git format-patch --subject-prefix='PATCH
v2' --cover-letter @{u}.." and mailed with "git send-email
--to=git@vger.kernel.org,gitster@pobox.com 0*.patch"; is there a way
that would have preserved whitespace better?

> I've done a trivial fix-up and took the liberty of making the result
> of this step into three lines, not two.  That would make 3/9 look
> more trivial.

Ok by me.

> Thanks.
