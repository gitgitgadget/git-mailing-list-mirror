From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Mon, 28 Mar 2016 00:01:16 +0530
Message-ID: <CAFZEwPOuWGoVj1s4aqoNy6eLAKHEdcH=7=o3gPxQ_eQvpp8N8Q@mail.gmail.com>
References: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
	<1459085245-20658-1-git-send-email-szeder@ira.uka.de>
	<20160327172741.GA4005@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 20:31:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akFTC-00060I-FP
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 20:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbcC0SbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 14:31:17 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33793 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcC0SbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 14:31:17 -0400
Received: by mail-qk0-f196.google.com with SMTP id u128so10123925qkh.1
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=culOdao6RVCiAN5LKaDeQGmfs+48r80IhcDrny5h4gA=;
        b=wtzOZpzno03T1+Czj+AEp62EkJrwMkASgiQWvcMhd3P9wxJ/Kkr/31Wff+IL7SnCyf
         njCS6fWmxF6f0RxYD929dYO7iZmC9v/0qXW53G7ZjveXNV+u4YLnDMDYkwV6dugLPaNO
         3P1yPXGmbUfNJZAQqf04FL/WuY5PgLFcds12sxIJPD8eRsVVe/RpsCxltyPW8hcuSpL5
         cJ1ZfWhuO46Ym9cUsxtJBhRq7zwuKtCLp4pmcXC/s0cjbOV9ydk5em+EUOtmeneFf8Al
         ZN3o3L73vmPjZ7sOMMkT9sKgYBnfqgkjBsPB6q7Iqm+Zvj+Ch3vB5y1FfUJq/3+6nieq
         hf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=culOdao6RVCiAN5LKaDeQGmfs+48r80IhcDrny5h4gA=;
        b=XHYRmEefz9saUmcPbeob7v7GFYAUnTzBUm+jgpec9FaGuESqxjjcYlPD1HzHnnzq9J
         WZDMNKquj/WZfp/ZifeFQTArMnKaREqrm+LGM56KJoz9JFk7A0UMERkcluq5nLTIfk5S
         Ky77yeQaAjfnh0O+EjuTMI2AdEYEtzDozrVoKI5lU/2iXYzVdRH/tK3dN8WgvOQEpDs+
         JbKHnaC4KMLYJHy1EvuNOrxCXY4QfGssV/Xet2ogtJ+HHnVblCB2xMJIU3Bfz5z9D4X9
         W65C/zt0/MluO6WqtaPm9gyA53dt4ee84tBXtLUQr6DyHCxCjojOXt0hiaCBpzOxjBjm
         hffg==
X-Gm-Message-State: AD7BkJLv8r1yjEConuuiXTx/JapY7IJbpgwUhg4D48LeFyXhWzAhehecJnHjNlb/yCx9DUzZe/wTjAsAqpsEDA==
X-Received: by 10.129.37.3 with SMTP id l3mr11392747ywl.128.1459103476207;
 Sun, 27 Mar 2016 11:31:16 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 11:31:16 -0700 (PDT)
In-Reply-To: <20160327172741.GA4005@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290020>

On Sun, Mar 27, 2016 at 10:57 PM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sun, Mar 27, 2016 at 03:27:25PM +0200, SZEDER G=C3=A1bor wrote:
>> > > +! test -s out ||
>> > > +rm out &&
>> >
>> > Why not just "rm -f out"? But, more importantly, why do you need t=
o
>> > remove the file at all? The '>' redirection operator (used below) =
will
>> > overwrite the file, so no need to remove it beforehand.
>> >
>> > > +! grep '^diff --git' "$1" ||
>> > > +grep '^diff --git' "$1" >out
>> >
>> > Um, what? Why two greps? I would have expected you to simply re-us=
e
>> > the existing grep (minus the backslash) while adding the redirecti=
on:
>> >
>> >     -exec grep '^diff --git' "\$1"
>> >     +exec grep '^diff --git' "$1" >out
>> >
>> > Am I missing something obvious?
>>
>> In the non-verbose cases no diff is included in the commit message
>> template, thus the pattern looking for it doesn't match anything, gr=
ep
>> exits with error code, which in turn becomes the editor's exit
>> code, ultimately making 'git commit' fail.  Not good.
>>
>> I suppose both the explicit 'rm out' and the '! grep ... || ...' is
>> there to deal with this situation.
>
> Sure, I understand that, but that's not what I meant. What I wanted
> to know was why Pranit didn't just use the simpler:
>
>     grep '^diff --git' "$1" >out
>     exit 0
>
> and then, in tests:
>
>     test_line_count =3D n out
>
> where 'n' is 0, 1, or 2 as expected by the test.

Sorry to create extra noise. This works perfectly fine. I had put an
'exec' locally. But now I have tested this and it works fine..

>
> Unfortunately, you missed the rest of the discussion since Pranit
> (presumably) accidentally dropped the mailing list when he replied,
> and I didn't notice the omission when replying to him with the above
> suggestion, which would have saved you the bother of going through
> this, as well.

Sorry for this. I might have just started typing and forgot to click re=
ply all.
>> I think we could:
>>
>>   - either revive the idea of two editor scripts: one for the
>>     non-verbose case checking with '! grep ...' that there are no
>>     diffs in the commit message template, and one for all verbose
>>     cases storing those diff lines in a file to be counted later.
>>
>>   - or use a fake editor that merely copies the whole commit message
>>     template to a separate file, and we do the greping in the tests
>>     themselves as well.
>>
>>   - or simply stick a 'true' at the end of the editor script ensurin=
g
>>     that it returns success even when grep can't find the pattern, b=
ut
>>     I kind of feel ashamed of myself for even mentioning this
>>     possibility ;)
>>
>> I would go for the second possibility, but don't feel strong about i=
t.
>
> Your #3 is effectively what I had suggested, as well (which is
> reproduced above). I had already made this change locally along with
> some other changes I suggested in other responses, and those changes
> look like this (atop Pranit's two patches), which isn't too bad:
>
> --- 8< ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 569fd8b..ea26b57 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -4,12 +4,9 @@ test_description=3D'verbose commit template'
>  . ./test-lib.sh
>
>  write_script "check-for-diff" <<'EOF' &&
> -! test -s out ||
> -rm out &&
> -! grep '^diff --git' "$1" ||
>  grep '^diff --git' "$1" >out
> +exit 0
>  EOF
> -chmod +x check-for-diff
>  test_set_editor "$PWD/check-for-diff"
>
>  cat >message <<'EOF'
> @@ -101,11 +98,12 @@ test_expect_success 'verbose diff is stripped ou=
t with set core.commentChar' '
>         test_i18ngrep "Aborting commit due to empty commit message." =
err
>  '
>
> +test_expect_success 'setup -v -v' '
> +       echo dirty >file
> +'
> +
>  test_expect_success 'commit.verbose true and --verbose omitted' '
> -       echo content >file2 &&
> -       echo content >>file &&
> -       git add file2 &&
> -       git -c commit.verbose=3Dtrue commit -F message &&
> +       git -c commit.verbose=3Dtrue commit --amend &&
>         test_line_count =3D 1 out
>  '
>
> @@ -121,7 +119,7 @@ test_expect_success 'commit.verbose true and -v -=
v' '
>
>  test_expect_success 'commit.verbose true and --no-verbose' '
>         git -c commit.verbose=3Dtrue commit --amend --no-verbose &&
> -       ! test -s out
> +       test_line_count =3D 0 out
>  '
>
>  test_expect_success 'commit.verbose false and --verbose' '
> @@ -136,12 +134,12 @@ test_expect_success 'commit.verbose false and -=
v -v' '
>
>  test_expect_success 'commit.verbose false and --verbose omitted' '
>         git -c commit.verbose=3Dfalse commit --amend &&
> -       ! test -s out
> +       test_line_count =3D 0 out
>  '
>
>  test_expect_success 'commit.verbose false and --no-verbose' '
>         git -c commit.verbose=3Dfalse commit --amend --no-verbose &&
> -       ! test -s out
> +       test_line_count =3D 0 out
>  '
>
>  test_expect_success 'status ignores commit.verbose=3Dtrue' '
> --
