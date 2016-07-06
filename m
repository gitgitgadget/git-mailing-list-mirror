Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0531A2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 17:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbcGFRpZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 13:45:25 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33625 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcGFRpY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 13:45:24 -0400
Received: by mail-io0-f175.google.com with SMTP id t74so1805222ioi.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 10:45:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mcPwTh2RZBAsIKYfCa9hHdZh0Km1kDFOcMU0H1R1uK8=;
        b=L1788zGlozt2ZdYDVn3uWrqunaC/cd61l5kkrNKIGBLzWxPpY/5ycyjqunxd8cmn8W
         7kcgdOJgzTlkiklRRimmmQGHbB5SSPyEFwVxab3lxzVcffbXSpdCgaL9YqafuoeKLa7q
         93CXRYvqhcGMcN0edz5cWpnoP+NyXxL18rP/eI5O9Nn6lTP9wZ2Xdmjjy1mjzhGREGZj
         OShAyDzjTeMZWyal8PKQPxWa0IsD1oEj2if5WphDxXXHirFJwUaDaMDv8nvHGWR7YsQ4
         tj9jBs0DYjZAGKRAebWUSGGAHTLoTN4XwEl5aXOSBT28RtF84bbvaLTkqQnhgroB1EBi
         Ppew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mcPwTh2RZBAsIKYfCa9hHdZh0Km1kDFOcMU0H1R1uK8=;
        b=GkT0faIdZQYeVY57qBTScZkrkBi3uWIfP+m7UCN8/rPZ3KCePW9UMVQ4Hm9NO+nscM
         jQ3zecUqIXa3pM9yv/gQh29k1BJ/vni82+LJVV3gjCdqp0jNfeytHsuN0R1gpDLImt+T
         VQYjV9Xqe6QNAgw51ePGW6sf4AcnoN27w5tYah59q4GJMb8iaLRVYVF4GmMA1YIXhmIT
         bCcVihHSVptPsWEUfzfkGBXlo/AtBGK5cgrAJd2x7XwTjl3eT+D41a/fRc2N6XF+Hf1p
         En5lY1CCLIsrfhTj6EEkeBQfZCH35fAfuBUaaKN+d3PIP2jQZHn0zM0IlKh/OfjZUnrs
         G0mA==
X-Gm-Message-State: ALyK8tLQr5ngPRK++tya1hFkAxWbDVGnY5JsTg0zIgW+KakAOdQW2fhSZAUVgP3B7mNk/RvURhs8253Q+F4K+ODY
X-Received: by 10.107.178.4 with SMTP id b4mr20236085iof.83.1467827123343;
 Wed, 06 Jul 2016 10:45:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Wed, 6 Jul 2016 10:45:22 -0700 (PDT)
In-Reply-To: <F58A6A72-4AE5-42FA-843D-66FF809FF1A8@jetbrains.com>
References: <F58A6A72-4AE5-42FA-843D-66FF809FF1A8@jetbrains.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 6 Jul 2016 10:45:22 -0700
Message-ID: <CAGZ79kaA1208Z7kMYJR42NRvYnh4T36M6Rz5W3jok0=ZfvmyHg@mail.gmail.com>
Subject: Re: git patch format for rename
To:	"Nadya.Zabrodina@jetbrains.com" <Nadya.Zabrodina@jetbrains.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 6, 2016 at 9:00 AM, Nadya.Zabrodina@jetbrains.com
<Nadya.Zabrodina@jetbrains.com> wrote:
> Hi,
>
> could you please explain to me why  ‘rename from & rename to’ information is added to git patch?
> Is there any reason why git can’t recognize and apply rename-change which looks like this:
>
>     diff --git a/before.txt b/after.txt
>     --- a/before.txt
>     +++ b/after.txt

See https://github.com/git/git/blob/master/Documentation/diff-generate-patch.txt
for the status quo. I think most of it grew over time and made sense
at the time of implementation,
so the alternatives were maybe considered, you'd need to look for the
old discussions around
the diff format.

>
> I’m implementing a program (with an IDE) to create patches compatible with Git and want to have better understanding of the format and possible issues with it.
>
> Thanks a lot in advance.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
