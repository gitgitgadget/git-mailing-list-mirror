From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] api-parse-options.txt: document OPT_CMDMODE()
Date: Thu, 24 Mar 2016 23:34:32 +0530
Message-ID: <CAFZEwPN=Vo7qR+6zwYhz+rB7Q0a28LRd_zEK-stF_Y4ThYq_4w@mail.gmail.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	<xmqqtwjvamhe.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPPhq0HNpJt3mt=AWZw7S3ikEL2XX-SOM8CcRkFie=9vcQ@mail.gmail.com>
	<xmqqy49794pc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:04:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9cc-0000bd-0y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbcCXSEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:04:34 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34069 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcCXSEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:04:33 -0400
Received: by mail-yw0-f175.google.com with SMTP id h129so69472570ywb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KNJxlwfCY37GF3WWfk+kKNUBfgmoOk75vHrjy6J4UBY=;
        b=wqyGjAbXMugjq4yLTKOy4tezPW5JAiU9XcWnF96FrCWbaKkFa31RicDF6CMGsDURaS
         1CM8N47EZX45KTn/Xvfmf9i2hJYlX77yHxYN4Ke2AQ+iYfMFT6mZTadNp5YhuiZh2XI7
         1HCMS+59R7kHvQFuB8+L5HCuSmVfyRAbkxs087AqbDMhfIzjMN3GwMgapb5Av9OUmKf7
         rQoXDUHj+27YH5RFc4AcaxtJ1z/OXLlOVHwwfCpOZHZkA6QWMgJh7rVF7yx2BfxaGCPj
         Z5I0Gb+p1GcdKiAZGBqWTkxUhrxJfPAVgmvk4RdZhM8HZBlTFskbP7swhPsh8k0+2FuV
         17Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KNJxlwfCY37GF3WWfk+kKNUBfgmoOk75vHrjy6J4UBY=;
        b=SCKgsdgJmqB08+/dgrirbsKTBIB2MsU/ZHOeC4zUyeQ53haLfiqQDnpP07YD8bUKXp
         nBoWjCDOgazoFBGhS6PXqhvAeTofgPvcgsQsEmBZX6Gt6t1i8OovKqXJuZsN+dnzRJGW
         97qT/cvmXN2TsM9dYudiDujMIlBDXkerV6vGv8rdg+ZcJ8XgoaOY1tFAeRUO5520LJ0P
         sxHBvaR7Q5R0hbtR0ss85Q0SWpKsxIRzaYvL8oDh9/hgPI/p1Lo5UShQkLB+cHpuA+Fh
         O2Lr1cAwkonF/lmcLPBtgptt6StPmj1n1Kh/h4N3Sd5+lpqevyZ6FULxcnW7HirY2XCv
         U4rg==
X-Gm-Message-State: AD7BkJLldAJmGXQnuRDKrLHEnmt4gfOET49KrG5czwQbR8c5kMyLa7RJvz1jpRyNxFpOw8NZzEqqpMS0cEkv4A==
X-Received: by 10.13.252.67 with SMTP id m64mr5588368ywf.67.1458842672269;
 Thu, 24 Mar 2016 11:04:32 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 11:04:32 -0700 (PDT)
In-Reply-To: <xmqqy49794pc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289777>

On Thu, Mar 24, 2016 at 10:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>>> +`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
>>>> +     Introduce an option for subcommands. It is useful when you want to use
>>>> +     the command with a particular sub command only and ignore other sub
>>>> +     commands it has. It will set `int_var` to enum_val if the argument is
>>>> +     invoked.
>>>> +
>>>
>>> Sorry, but I do not get what "when you want to... ignore other sub
>>> command it has" wants to say.
>>
>> What I meant by this statement is that (your example), let's say we
>> have "add", "remove" and "edit" sub commands. Now the user has to pick
>> between the three. He cannot choose more than 1 from these.
>
> Then I find the word "ignore others" misleading.  Quite the
> contrary, the user has to be aware of the others and not to give
> them.
>
>         Define an "operating mode" option, only one of which in the
>         same group of "operating mode" options that share the same
>         `int_var` can be given by the user.  `enum_val` is set to
>         `int_var` when the option is used, but an error is reported
>         if other "operating mode" option has already set its value
>         to the same `int_var`.
>
> or something?

Seems a crystal clear explanation to me. Thanks. I was unaware that it
throws an error.
