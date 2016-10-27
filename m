Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C42620193
	for <e@80x24.org>; Thu, 27 Oct 2016 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942758AbcJ0ObM (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:31:12 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34899 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936504AbcJ0ObJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:31:09 -0400
Received: by mail-wm0-f47.google.com with SMTP id e69so38606063wmg.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:references:cc:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=I4DytUOhB96rztS1EY2xtg+QWqvgbCuVD9WjJ7BCbM4=;
        b=Yjo9L/mrvnu24PJ6CpREFLYc3LxBY8XvpZj7hH7p4tO8HSnkdmEHn2h/G/aZ/8i7pn
         izuCXrWYeE31oKCF343k4tPkmqNM2EmavymAKZIFCE8o4shXYAcr8rVcim//44vJGQe3
         zJ36E9LoN4X2OjwpH50Ir/FfWEFedRQO1rLwZmNG9wY0njiZobaybw0H+6vGMcEJAfCE
         rIB6LA/bFRLau9jHxSZS7iVjRSlkGDjd7pMM7uy+tBfYiK05s7KZk+l4ZnkokHnK+qlE
         y35ppzCo+qPwXA9UGOlY2mC3k/PMjF9EDNkB83iWD9pUbr/d1vQWxAzYbnuTJUqIeXVY
         qoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I4DytUOhB96rztS1EY2xtg+QWqvgbCuVD9WjJ7BCbM4=;
        b=mnrXoczXeUUrwAn7ufEC4BRnwXbSxDpjy0COtV7HxsTKjJjBeW5DukzBlmYW53XEAI
         T6zica05LAlicgHQeWNJ8luD1cJAxtMOvyQ60SrvueJz8IkHEOukVcjwUbjQhR7rDWlr
         MuAdhVvD2N+W/qZ39GTiyv9Or6+HvHfYwfW09BlOllZ1Xiyn1ifesweGLpWWb99jeGhe
         J+UA+5Ktq8NP2NQXNI8RhAN6npyNi9mQNwHZOVxg+gSRYwmiN2UBbfM1SaAtF3eismSL
         NhgkkHbnsJQB93niFSVLBiIWFHh6dvObtT8/ym/aT/CigZeNM6JmuFBlFOeRKG/ARCCt
         7ACA==
X-Gm-Message-State: ABUngvf8MB+IEn3yyfT3CuNPjSr0Y2hv0XorCi+9+1VnjAL72qOPGbTXytXSqxMZAznPBw==
X-Received: by 10.28.232.23 with SMTP id f23mr7431700wmh.125.1477564392146;
        Thu, 27 Oct 2016 03:33:12 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id s133sm2458178wmd.19.2016.10.27.03.33.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 03:33:11 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <CALhvvbYqeWw+q=TPxTpve6JKoy0URYeWxj2vVOnzrA_g3Z3esA@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <91d49c7b-2bc7-a872-24c8-25836dea17fb@pelly.co>
Date:   Thu, 27 Oct 2016 23:33:07 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CALhvvbYqeWw+q=TPxTpve6JKoy0URYeWxj2vVOnzrA_g3Z3esA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/16 21:19, Alexei Lozovsky wrote:
>> I'm thinking something like ". path/to/include/file" in an ignore file,
>> and/or creating .gitignore.d and/or allowing $HOME/.config/git/ignore
>> and $GIT_DIR/info/exclude to be directories. Or some sane and consistent
>> mixture of these things.
>
> I think the rc.d-like approach with directories is better as it
> does not add new magical filenames (what if I absolutely do need
> to name my directories ". path", with a space? :)

Yes. Another alternative I thought of was #include path/to/include/file.
That'd be backwards compatible, which is a good thing, but would involve
parsing comments, which obviously could start with #include. Or lines
like ^Include /path/file$ In the case of finding an invalid file,
passing it over and issuing a simple warning should surface any issues
with existing gitignores. Anyway, this conversation is why I bring it up
on the list.

Coming back to this, maybe :(include)/path/file might be more git-like

>> In the case of a directory the plan would be to add links to files
>> stored/sourced elsewhere. This does pose a precedence question which I
>> haven't thought about yet, but probably makes it too hard for the
>> limited value it brings.
>
> Now, if we consider the case of multiple .gitignore files, it
> could be unexpected and possibly annoying for negative patterns
> in one file to affect the patterns added by some other files.

That is a concern. It is non obvious; the worst kind of annoying.

> I would find it more conceptually simple to apply individual
> .gitignores one by one, as opposed to parsing them all and
> creating one giant exclusion rule. (In technical terms, this
> means keeping one struct exclude_list for each .gitignore,
> not merging them all into one single list.)

I agree. I haven't looked, but that sounds like touching significantly
more code though. Actually, thinking about it for 20 seconds more, it
shouldn't be too hard, should it?

> In this case there should be no precendence problems as applied
> gitignores only add new ignored files, without un-ignoring
> anything previously ignored by other files.

Again, I haven't looked yet, but there is still an issue of precedence
with other gitignore files in $HOME and the repo.

> However, if we allow textual inclusion, then it means that we
> can put a gitignore into our gitignore so that we can unignore
> while we ignore, which again brings us the question of whether
> it is actually needed and expected.

Gah! Yes. One way or the other.

>> I would like to know the desirability/practicality/stupidity of such a
>> feature as I believe it is within my skillset to implement it.
>
> However, I do not recall any precendent of git using rc.d-like
> configs.

Many things have adopted this technique recently. Well, the last 15
years. It is common, understood, and fairly simple. I see no issue with it.

> And some can argue that your goal can be achieved by
> generating the .gitignore by some external means and symlinking
> the result into .git/info/exclude, so this is not Git's problem
> and we should not be overcomplicating things with something as
> simple as a list exclude patterns. This line of argument also
> can be used to opposes any textual inclusion as well, because
> it can be expanded into 'why don't we add a Turing-complete
> programming language then to specify the patterns to ignore'.

I know. Another reason to bring the idea to the list. I sort of have
this attitude myself. My main objection to it is that I can't think of a
hook to automate it with.

But: What about some kind of :(exec) that executes a script and returns
a gitignore file? You write the script; you're responsible. And the
behaviour is obvious. I haven't thought that through. It just came to me
then, and might present security issues, but could greatly simplify things.





