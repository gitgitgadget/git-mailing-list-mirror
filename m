From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 3/3] commit: add a commit.verbose config variable
Date: Fri, 25 Mar 2016 11:45:51 +0530
Message-ID: <CAFZEwPNXPDWA2R4p_pUWYEa+CeQDEpQiHz_b+UknfuA4+5KB5g@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
	<CAPig+cQ3TnKV1GcViq9Qwtq8bkp19jqvQRzBT_v5-MSfSfXgZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:16:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajL2N-0004WM-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbcCYGPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:15:52 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34942 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcCYGPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:15:51 -0400
Received: by mail-yw0-f194.google.com with SMTP id u8so441348ywa.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xl1mwRHSBlpWNuZr3WNmXoE8hF0UNYK3hIwMyz/LW3c=;
        b=VnFNMa+3YrXubO5ohx0af8FvBLwtOG6SVO6x3ERlVntfJxq/rgoJ9TndB9sCg94E1F
         YosIOQUHkqF8oTQxtX4Y+lE0EYUovbWjvJvz8FuBBD/64GlnVo1E8vKRoSbc5UdgMAiq
         p/XbPtx/YIAyqkY949X1aHG/n37f7HLVfu1uB6uKgIVfoZ6xDsZzU1s2uIkl9lJBK6Ve
         kK2hAlEjTL0SrjrXehn60Ip9Q6sUs655/PbGDRotUP+C1v49sAxo6FiZK89wrw17P/xi
         HCRagP9JRAV+nVDS76NSP9E05WQH28r2e+aWPo1EivFC6zBl9Fir8mwbQfog0nkFYXah
         yhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xl1mwRHSBlpWNuZr3WNmXoE8hF0UNYK3hIwMyz/LW3c=;
        b=j4Ul6dfAN1U8Z6ike+Zg8d/1fEPWo7owSHian7P4pjUr7M3RavOtKsvwSY/GNBGt1q
         DS9j0GhXAGU5X59MxmRGudNmVrXzYJ9oxpYPq0Bb0SiNhL4nMDJfLMxJpf96uYjMxAP5
         0iVORG5NxOe4UHC0WJugfI8efHVLm1gg7ZJLvkWC+cNzhY9FgTcAggr+yo1iMd+r7srJ
         r6Q/s6eJ6my6bMv3wofpXhHK3y2NrkFaP7jwUlTRTx+5ay1oSe/7lGVR/CUrqJyWlx8A
         N3+CK/Xe2HpYPHrBOtJe1QnEFmSyjmDIQKEvrza2X+F1O4Aiajzyp5ZKUnxIuLIoUI4g
         Aj5A==
X-Gm-Message-State: AD7BkJJc6/JJM2xnaf+rvDhU+iAnbON5B2gG+kjdhrqlaCI1xuuLc0Ng3EmDKXQmMhw7zpL4WykcjKGQz0AIZA==
X-Received: by 10.129.91.6 with SMTP id p6mr6390448ywb.325.1458886551049; Thu,
 24 Mar 2016 23:15:51 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 23:15:51 -0700 (PDT)
In-Reply-To: <CAPig+cQ3TnKV1GcViq9Qwtq8bkp19jqvQRzBT_v5-MSfSfXgZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289850>

On Fri, Mar 25, 2016 at 5:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 24, 2016 at 4:25 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Add commit.verbose configuration variable as a convenience for those
>> who always prefer --verbose.
>
> The implementation looks better in this version. A couple comments
> below about the test script...
>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> @@ -9,6 +9,12 @@ test $(wc -l <out) = 1
>>  EOF
>>  chmod +x check-for-diff
>
> Mentioned in patch 2/3 review, this patch (3/3) is where you should
> update 'check-for-diff' to also check the line count, and the commit
> message should explain the reason for doing so (and don't forget to
> mention that it won't harm existing clients of 'check-for-diff').

Agree that check the line count should belong to this patch. And will
add more details in the commit message.

>> +write_script "check-for-double-diff" <<-\EOF &&
>> +grep '# Changes not staged for commit' "$1" >out &&
>> +test $(wc -l <out) = 2
>> +EOF
>> +chmod +x check-for-double-diff
>
> Also mentioned in patch 2/3 review: drop 'chmod'; write_script() does
> it for you.
