From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] api-parse-options.txt: document OPT_CMDMODE()
Date: Thu, 24 Mar 2016 22:25:29 +0530
Message-ID: <CAFZEwPPhq0HNpJt3mt=AWZw7S3ikEL2XX-SOM8CcRkFie=9vcQ@mail.gmail.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	<xmqqtwjvamhe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8Xt-00056m-48
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683AbcCXQzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:55:36 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33084 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152AbcCXQza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:55:30 -0400
Received: by mail-yw0-f169.google.com with SMTP id h65so67079386ywe.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RInsAbEYWd7iVHy4ovoCgOtOUL4CIH0/mzPrY8zzuZ4=;
        b=al1I2k0dVaiuWZ0CN6rGvF82SrwuqQoI4+85xB/z9XrojzfDZl819PEp2QILrUp0Nv
         ap/ORKBWDgesO/7eBs0PeZ15cwrALXqidnDQRWBoPpzuBiTNqKgF9bz1Zw88P/Znzgus
         RT5wma1PR83mMuL131MdnKXxs3d4Vv3B5xIq408V9KXmP8tq13k9gcFnkp6hs+75qkzR
         oAhm8HuQl7FCzGS3bsIUyJIPUha6ka6Yp8BvN6t3/JR9T5eMgXTlAnVYcbzlXPezLnlv
         WYRV52ZUJEhPdyMAhCPgwi9LVN3oSUIqBiR7XHobFpX46qI1xwG1go4bY71lVdvf1s/2
         KveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RInsAbEYWd7iVHy4ovoCgOtOUL4CIH0/mzPrY8zzuZ4=;
        b=fksyusTxFSwgVJrCXGhDBTCrNRITZZmu3p051gwYSwszXQ64r7R8rLw1EAngG1gmes
         goxWzoQlBvzCToo/wzvoNLviihiKfY6KA2zvz1mO+V8DicfF/kzQe7vICqDODGaLI9c9
         Rqq4MYwTtLHZTKx7X4ixJbwmpRVkNUyXa1C355NFnkI1jf2OatkiBs0EiwLPXoSIonkf
         XW1itaFDgVdoOqnFCfdL3je8YaDePcQVuJwSw6MI3s4XzeNNl6FAet3/AEH/T+7WRJIW
         bvNlJrzTUR3WQRqIOm+4+Pcv8tr/LQlysGZi6Q1Aseu0HilrPiCOOeGoJ7oh16AKB4j4
         wvjA==
X-Gm-Message-State: AD7BkJLkxusADPY0ArcXqtCIu64dfnW9vwuwHEYx8SErCqHTvJtI0rcsmuomQhdt+JxbSWi4uFaSu7uTM03n1Q==
X-Received: by 10.129.94.7 with SMTP id s7mr5387684ywb.93.1458838529581; Thu,
 24 Mar 2016 09:55:29 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 09:55:29 -0700 (PDT)
In-Reply-To: <xmqqtwjvamhe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289761>

On Thu, Mar 24, 2016 at 9:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> OPT_CMDMODE() was introduced in the release of 1.8.5 which makes the use
>> of subcommands in the form of arguments a lot cleaner and easier.
>> ---
>
> Sign-off?

Will include this.

>>  Documentation/technical/api-parse-options.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
>> index 5f0757d..8130d26 100644
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -231,6 +231,12 @@ There are some macros to easily define options:
>>       pass the command-line option, which can be specified multiple times,
>>       to another command.
>>
>> +`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
>> +     Introduce an option for subcommands. It is useful when you want to use
>> +     the command with a particular sub command only and ignore other sub
>> +     commands it has. It will set `int_var` to enum_val if the argument is
>> +     invoked.
>> +
>
> Sorry, but I do not get what "when you want to... ignore other sub
> command it has" wants to say.

What I meant by this statement is that (your example), let's say we
have "add", "remove" and "edit" sub commands. Now the user has to pick
between the three. He cannot choose more than 1 from these.

> CMDMODE is a mechanism to actively notice when multiple "operation
> mode" options that specify mutually incompatible operation modes are
> given and error out without the user of parse_options() to implement
> that mutual exclusion herself.  That is, if you have 'add', 'remove'
> and 'edit' operation modes, with OPT_BOOL(), you would have to say:
>
>         options[] = {
>                 OPT_BOOL('a', "add", &add, ...),
>                 OPT_BOOL('r', "remove", &remove, ...),
>                 OPT_BOOL('e', "edit", &edit, ...),
>                 ...
>         };
>         parse_options(ac, av, prefix, options, ...);
>
>         if (!!add + !!remove + !!edit > 1)
>                 die("at most one add/remove/edit can be used at a time");
>
>         if (add)
>                 do_add();
>         if (remove)
>                 do_remove();
>         if (edit)
>                 do_edit();
>
> but with CMDMODE, you can do:
>
>         options[] = {
>                 OPT_BOOL('a', "add", &mode, ...),
>                 OPT_BOOL('r', "remove", &mode, ...),
>                 OPT_BOOL('e', "edit", &mode, ...),
>                 ...
>         };
>         parse_options(ac, av, prefix, options, ...);
>
>         switch (mode) {
>         case 'a': do_add(); break;
>         case 'r': do_remove(); break;
>         case 'e': do_edit(); break;
>                 ...
>         }
>
> and parse_options notices that "mode" is shared across these three
> options, and implements the mutual-exclusion itself.

Thanks for taking time to explain all the details behind it. I can
include these bits in the documentation. :)
