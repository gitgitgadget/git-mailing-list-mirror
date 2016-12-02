Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A8F1FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 01:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbcLBBl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 20:41:27 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34313 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbcLBBl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 20:41:26 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so4748581ioe.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 17:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+m9FFnfU0EK+iJy6OHD/olmFuxfIXmRHz1Q0omoqyOU=;
        b=uteKL5McLNuilVX/0qgZ5d308dqc2bLmSba9SK/wPIhQ7vJrEwQslEJLZ2tDKiy7uL
         BzdLukGaxEjrqTzaU4yRPt8RzyVER+RVPOB/LNsAMh/vqJ3W+Ywvm9f803NLePlQsqhl
         pVDEfCAzulgBuSxMiigoP1emSh4vriaFiG1EWTlg7p5r0TkFMxV4QTSAY7YV29WNIL2T
         Z3BH7/Kfp0KwPPVcesqGVdkTTZ4wUbBFkG9tzJnrTvr42UDfOvjIIqPihF1Lgs778ufd
         TXeS/3kXA6Sz/7ymm8XhpDlQk/R666/Ptws2WPcqvpDeQqby9ypFIz/dj9QyW3D/YoD2
         SktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+m9FFnfU0EK+iJy6OHD/olmFuxfIXmRHz1Q0omoqyOU=;
        b=eJL26Gvo0BUuucfLeQJB/1ncuZEoFQigsXbfhuTbPZRzQ9+DSKJX7vEsw4lXgbb7Du
         DWt77JupUWLoBlmeVYB5nEoWv2e8C0vSGV+WNA/QK0AajM0Hw4horWzA2d5ZAw5xJcBx
         FpiEhHagZNTt1PXa8GUsQHHzW+iBlA++GMRDNEcai+W1QopDO3qo9EFPM/Xo+EerLOVv
         twK7sLAUNyWpYA6Cj+p0TQ1g3O89+ftG+Xxq5kyckUk6w3StxlH+jTUN66piiZ2VmVtB
         jhElcwvV6itb6mIDiHJHEn5zJMTazovfXov4LFrfIWTLZLi+yGol2SKIW4gg5Q69f7Yx
         RX6A==
X-Gm-Message-State: AKaTC021Z4aVue8x1oq1u+fFWvIljovHiTQP8EftUrTJONDuz8miYxnN4Kh4kq3Q6Og7/Tjq6YNWNR6eqeWRPw==
X-Received: by 10.107.28.129 with SMTP id c123mr36896083ioc.11.1480642885163;
 Thu, 01 Dec 2016 17:41:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.196 with HTTP; Thu, 1 Dec 2016 17:40:44 -0800 (PST)
In-Reply-To: <xmqqfum78jq0.fsf@gitster.mtv.corp.google.com>
References: <CACC5Q1eFM_G4wKopkbxabLEu8+nbt66wF1jKSoTuL1vnS5Tb4Q@mail.gmail.com>
 <xmqqfum78jq0.fsf@gitster.mtv.corp.google.com>
From:   Austin English <austinenglish@gmail.com>
Date:   Thu, 1 Dec 2016 19:40:44 -0600
Message-ID: <CACC5Q1dfbDcDdFNmbsM63nkLWzbE6WXxLrTLZm5YTRTbVtgoOQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/install-webdoc.sh: quote a potentially
 unsafe shell expansion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2016 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Austin English <austinenglish@gmail.com> writes:
>
>> diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
>> index ed8b4ff..5fb2dc5 100755
>> --- a/Documentation/install-webdoc.sh
>> +++ b/Documentation/install-webdoc.sh
>> @@ -18,7 +18,7 @@ do
>>       else
>>               echo >&2 "# install $h $T/$h"
>>               rm -f "$T/$h"
>> -             mkdir -p $(dirname "$T/$h")
>> +             mkdir -p "$(dirname "$T/$h")"
>>               cp "$h" "$T/$h"
>>       fi
>>  done
>
> We know $h is safe without quoting (see what the for loop iterates
> over a list and binding each element of it to this variable), but T
> is the parameter given to this script, which comes from these
>
> install-html: html
>         '$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
>
> install-webdoc : html
>         '$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
>
> in the Makefile.  So quoting the result of $(dirname "$T/$h") is
> just as necessary as quoting the argument given to this dirname.
>
> But I do not think it is sufficient, if we are truly worried about
> people who specify a path that contains IFS whitespace in DESTDIR,
> WEBDOC_DEST, htmldir and other *dir variables used in the Makefile.
> The references to these variables, when they are mentioned on the
> command lines of Makefile actions, all need to be quoted.  The
> remainder of the Makefile tells me that we decided that we are not
> worried about those people at all.
>
> So while I could take your patch as-is, I am not sure how much value
> it adds to the overall callchain that would reach the location that
> is updated by the patch.  If you run
>
>         make DESTDIR="/tmp/My Temporary Place" install
>
> it would still not do the right thing even with your patch, I would
> suspect.
>
> Thanks.

Hi Junio,

Thanks for reply and reviewing. Your concerns are totally valid.

Some context for the change. I wrote a wrapper script for
checkbashisms/shellcheck that I use in my project. I decided to run it
on other projects I have checked out, out of curiosity, and looked at
some of the results. This was the only one in git, so I thought it was
worth fixing. I did not test the full pipeline.

I'll look again and send a follow up patch soon.

-- 
-Austin
GPG: 14FB D7EA A041 937B
