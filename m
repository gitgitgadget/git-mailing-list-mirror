From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/8] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Mon, 11 May 2015 10:23:20 -0700
Message-ID: <CAGZ79kZFC3Qr-S5dxHFf3W6FF6miNcbD8qCD48fP=PqzDhf75Q@mail.gmail.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
	<1431225937-10456-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 19:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrQM-0005R8-NX
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbbEKRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:23:22 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33015 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbEKRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:23:21 -0400
Received: by iepj10 with SMTP id j10so110408046iep.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RJ0H307iYRyqFKYBT9IL12UPd49M+g4nm3UEkVIbHBQ=;
        b=JZU8dEt2zAKK4EOT8XbHnenVlzW1cucR2MQLGct5RB6wEFhOMaRXcVd3kVb+xxBaQ/
         EqVGchOj65O23J9M4AV1yH+WLk38l+lVnkg8uY2c8O/7le7tn3Wsz+cepfZa2wHGHJQn
         SNUceEAOafevdNhCH/FinmaqzjCjBluMz9VQmau22LBPiUM8vVSXYvnGSkL/jY3OT4/S
         vvBVfUxzv1avvitZyn6vWNizRYpufejZflaiO+/AjNXCRTHEmI4ooxu90FRn21jI7Jni
         5Na/CG8ofP8LzwVKKx4ufb4lEEZrMCduS3mj+5K46XixSdudXQakWyDS/7K2cX+PAefk
         TKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RJ0H307iYRyqFKYBT9IL12UPd49M+g4nm3UEkVIbHBQ=;
        b=Fjn3sDx8YMIKLlxbpfyUdBTt2Dhxk75wy941BrTK09vRuCAl8M1dycY/4gYclX4D58
         DCxWC4l0ORgb/nB6u8j/eGinuVik8/BDycAG7TdzJZlWmgSj6hoCP+v4nzVUxuIeVMpM
         ShEkhqgcy8vSiQMPqtVd8hCWEEIVINz7YDUN8Fl4OOF79qC4Z6HvXcvSL3FC+qS+Du8S
         nKwrbu/J/AkkmOfrKIHJak2VpVNQ+r9KgzJUakDoJsMWajTvb5KXeRb6tb5OLGYLRGa4
         cK5S9zxpxTakPnbaCJnv8jQgVJGf+e/yAgjT8EVY6HrUJ6TrvxFGpIzJDrFpMmsLJlZp
         Leow==
X-Gm-Message-State: ALoCoQmD6lxGMNQa1fgFdm9B2Q/QahDkStu0GSLNLSCJ3pSOog440Z9sUX6NkxkjNB2nrunrEtc1
X-Received: by 10.50.143.97 with SMTP id sd1mr15624864igb.25.1431365000521;
 Mon, 11 May 2015 10:23:20 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 10:23:20 -0700 (PDT)
In-Reply-To: <1431225937-10456-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268800>

On Sat, May 9, 2015 at 7:45 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> From: Stefan Beller <sbeller@google.com>
>
> During creation of the patch series our discussion we could have a
> more descriptive name for the prerequisite for the test so it stays
> unique when other limits of ulimit are introduced.

I must have had a bad day when trying to write this. Either words are missing
(just insert a "revealed" after discussion on the first line) or it
doesn't make any
sense. How about:

In this patch series we introduce another test depending on a different ulimit
so we need to have a more descriptive name for this prerequisite such that
it stays unique when other limits of ulimit are introduced.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t7004-tag.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 796e9f7..06b8e0d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1463,10 +1463,10 @@ run_with_limited_stack () {
>         (ulimit -s 128 && "$@")
>  }
>
> -test_lazy_prereq ULIMIT 'run_with_limited_stack true'
> +test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
>
>  # we require ulimit, this excludes Windows
> -test_expect_success ULIMIT '--contains works in a deep repo' '
> +test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
>         >expect &&
>         i=1 &&
>         while test $i -lt 8000
> --
> 2.1.4
>
