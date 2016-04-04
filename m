From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for
 multiple options
Date: Mon, 4 Apr 2016 15:48:57 -0400
Message-ID: <CAPig+cRMti0ayBMS2TTUc-Og=X-Pu2yeHxHOS74fw=X8BTsjhQ@mail.gmail.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
	<xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Brodsky <corax26@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anAUh-0003Oz-T5
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbcDDTs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 15:48:59 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:32830 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbcDDTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 15:48:58 -0400
Received: by mail-ig0-f178.google.com with SMTP id kb1so287283igb.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=V9mrJSnbyS6VqvG6aRfAEfG0EunMSgNGAgKSk2+SI/E=;
        b=bPv4WzzwibH7qIWa+8vIdvbrTSswF59NGMY9SbLIOnVONfWfShbY9fDJsDGr/rcHqa
         9yIfjwGY+Wecgq0dvZAUmRB4ZyGZlkAYF1oj5BSxXjTaC5y7qWpwD7cgGCPk8SmIhMpD
         LT9ooBCpFiSNzcx/A0U8iT8MY6igZfTA46uskgWs+Yd6Xctpt1SRZjmo56MvKn+F9fQD
         qv1+wzNCGWy+DFsQEFdSSSZH5pw0bHA8sUFoeaau+YRLw070gYw+GjplCTFiIgQ6C2k+
         ym3iBvX7Dp+chTLkOb2CoXCNs8SZe834at9zruTWIx999asEAPkZBFEQtIEjxVwHenao
         RjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=V9mrJSnbyS6VqvG6aRfAEfG0EunMSgNGAgKSk2+SI/E=;
        b=Jpp796JpQThY3bNjP66yPq0iUDAnslKfZ8RS2IYmo9s5bud5saEAL8Gk28mVxXCQlb
         hZ+wQ0A9/kFt0SLbMoJukm4HNOtrcv6mpJi4tV+qO07GE0eG4XMfb7jpiEHge7F0Kd4k
         wlBVyjpSwvlLIt1LNI+h9L706EZVihLWpMoDPJJDwfUhVDwd6/bI54Oln5ytNEOuK6eo
         atwv5+c6p0bqPHJAK+tTjiEBBsBVR/ZJ3Pkx/uJCuxvUpwplSkXKfupzJ4QLL1i9VKTc
         C0gF+uehxujg1Eb8QuupVSv19qOb36OC22poTyaPlI3XWxGoQ8Jl29wkvOGtb1PZKKXi
         GzGQ==
X-Gm-Message-State: AD7BkJILTEkn7i/C1AO6vKv7MJU91PfEAGr/pC2WLQ049P3q6RstAWdu4z8BExG57HntrJd5YBM7aPGPjvgO2Q==
X-Received: by 10.107.130.138 with SMTP id m10mr12295213ioi.34.1459799337158;
 Mon, 04 Apr 2016 12:48:57 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 12:48:57 -0700 (PDT)
In-Reply-To: <xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: g6cbbe1zq_dGmxuuSesUXt67S4o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290718>

On Mon, Apr 4, 2016 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> @@ -28,10 +28,12 @@ ifdef::git-diff[]
>>  endif::git-diff[]
>>  endif::git-format-patch[]
>>
>> +ifndef::git-format-patch[]
>>  -s::
>>  --no-patch::
>>       Suppress diff output. Useful for commands like `git show` that
>>       show the patch by default, or to cancel the effect of `--patch`.
>> +endif::git-format-patch[]
>
> Given that the ifndef/endif block immediately before this part is
> also about excluding -p/-u/--patch when formatting the documentation
> for format-patch, perhaps the attached may be a smaller equivalent?

Perhaps. I kept self-contained to make it easier to add new options
between the two if need be, but I don't feel strongly about it.

>  Documentation/diff-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 306b7e3..42e6620 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -26,12 +26,12 @@ ifndef::git-format-patch[]
>  ifdef::git-diff[]
>         This is the default.
>  endif::git-diff[]
> -endif::git-format-patch[]
>
>  -s::
>  --no-patch::
>         Suppress diff output. Useful for commands like `git show` that
>         show the patch by default, or to cancel the effect of `--patch`.
> +endif::git-format-patch[]
>
>  -U<n>::
>  --unified=<n>::
