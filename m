From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for
 multiple options
Date: Fri, 8 Apr 2016 11:22:23 -0700
Message-ID: <CA+P7+xqzXt-uKc=K=5UPmaziApNQFL06SQbgYUdOVgZP=My5kA@mail.gmail.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com> <xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git mailing list <git@vger.kernel.org>,
	Kevin Brodsky <corax26@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:22:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aob3S-0007oP-8Z
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbcDHSWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:22:45 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32830 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbcDHSWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:22:44 -0400
Received: by mail-ig0-f180.google.com with SMTP id kb1so41891030igb.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKg4jgvSC2HAYPUAAoiMIzl8WRLkryFJBQRHRw0I/WU=;
        b=0f/NJAEbyMbXwE0BUUc+kpVOvWj3OfhM179KsEQQw0MveMhOaKODJ8rd/3k9aymY82
         B9l8QTMeYJVWIZG2p+UHMD28j+f6hDss8mgRUhKlbjcyAWcwTEm+K+pziD1uycllcJLg
         YHE7UUXaXCldLrRxjx+mAd2Ss7ALTiOIlOiyM2oxhOB2Ir9Kog1JXQtIcxomsrqlC7zi
         y20q51aQkDq3TLa2oxd39dNKyXPpacM2mn+T66IZdt+ENc0L/8lPRx1cE5x2rM7dpp9N
         Xi4vWubyD43QrbZtIbhFZXsF/3TWVivdtqFy/rV6MvAVcSfOhq7hNC1iQJt7LbbZoA+y
         hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKg4jgvSC2HAYPUAAoiMIzl8WRLkryFJBQRHRw0I/WU=;
        b=OsC8BUMg7TOmE/p4trANuURxyfUR99gNo05ulM/33FitGAbhgPZJ7fvLok0G2Fi6co
         /4mRzJ2gXX0GF0ErHWLQBHI5RMI6yzTjSamXUe03vK3f/vSfFBNYVlCgfI8QZVvb2WMu
         j2Ud/QXWnWZUNKoRRSLKY3xsHFEFBH5OK0VyKMvxvbRTNYqNWPU6CJktIQkRmg2GowPj
         zHOTRdu+py+0TeclHL/D/ruMsZAF7/llfcD+oKGCA/fgGUlcVRaS3yf9c+ltpHFOu2ug
         G4WfTo8NhFZrAINcZdUbLKNQbdEUJ4iopIsyjH35T/c5OOaUYBawQcJWN652CRWIMok7
         L20g==
X-Gm-Message-State: AD7BkJKuGD58FfloYhv+7a7q4A5HC/BC6+kUDtjCjOrqBrVWtqK08YPKQfEcRbuAsSTSxV4sFVQVVSIGnNtlqg==
X-Received: by 10.50.47.49 with SMTP id a17mr5384797ign.35.1460139762887; Fri,
 08 Apr 2016 11:22:42 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 8 Apr 2016 11:22:23 -0700 (PDT)
In-Reply-To: <xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291049>

On Mon, Apr 4, 2016 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Documentation/diff-options.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 306b7e3..6eb591f 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
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
>
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
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This patch or another patch should also include a check to ensure that
--no-patch isn't silently accepted, similar to a few other diff option
arguments: (pardon if this copy below gets malformed by GMail
webclient)

---

diff --git i/builtin/log.c w/builtin/log.c
index dff3fbbb437c..a12db191acb1 100644
--- i/builtin/log.c
+++ w/builtin/log.c
@@ -1384,6 +1384,8 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
         die(_("--name-status does not make sense"));
     if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
         die(_("--check does not make sense"));
+    if (rev.diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)
+        die(_("--no-patch does not make sense"));

     if (!use_patch_format &&
         (!rev.diffopt.output_format ||
diff --git i/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index eed2981b96df..fdcd7de7a0f0 100755
--- i/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -691,6 +691,7 @@ test_expect_success 'format-patch --notes --signoff' '

 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
+echo "fatal: --no-patch does not make sense" > expect.no-patch
 echo "fatal: --check does not make sense" > expect.check

 test_expect_success 'options no longer allowed for format-patch' '
@@ -698,6 +699,8 @@ test_expect_success 'options no longer allowed for
format-patch' '
     test_i18ncmp expect.name-only output &&
     test_must_fail git format-patch --name-status 2> output &&
     test_i18ncmp expect.name-status output &&
+    test_must_fail git format-patch --no-patch 2> output &&
+    test_i18ncmp expect.no-patch output &&
     test_must_fail git format-patch --check 2> output &&
     test_i18ncmp expect.check output'
