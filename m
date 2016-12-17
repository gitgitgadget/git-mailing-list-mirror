Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0601FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbcLQOgm (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:36:42 -0500
Received: from mail-yb0-f182.google.com ([209.85.213.182]:34840 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbcLQOgm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:36:42 -0500
Received: by mail-yb0-f182.google.com with SMTP id d128so46559102ybh.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/vnlKvgFsBLt0lhSxK7Jt52jsqFw9k7FHck2+MnqnJw=;
        b=V5IgGH6NqYeywm13XykQ2mBch6NBS6eLsJHZGb6ZCupC6ClksXHLluAxEFsj/H//MQ
         /AWolObHGejJiGbBKPP6OJxmfAvgkpZHkydAK7kumrshMUisjFI7UFLPycBMBJe9sMqo
         6qhuA6+17+qpwrKaZaYPNkvi6ZzbufFOGpPtMUWahEpPtz7MB4MdhueBjCdhzy22sNvd
         QrO8MFpt1xPmT+Wg0X6mzYlllE1jcuZmXt9Jxz4f3RZpoGVgkKIKZkQnKjS6ZuJl0+jT
         qhYE336qn1JoXCO4li58LLPCAF6yKwTv8XaXBaog2v0DEMteUb6a+GRE+Os3SMdzysd/
         Paiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/vnlKvgFsBLt0lhSxK7Jt52jsqFw9k7FHck2+MnqnJw=;
        b=jnMTrXMrAk2n95rmTli7dA99K3pt5RTHp5nO8nmHLGmPAyK/pzMmRfxwwT3BNle/p1
         EAhcJIlLBhAyBvlcNUNkVYL59Kml6Ct3X9l74Vh/Jsja7QKdXEOVC7vlwI+fmoGDvtwQ
         cdiCSKCF8k+0pU03OADRYqU33zAK3MNEiEY9MDM511vc709JYcS4N+d7zmcYy6Z/SlPY
         gzTSQA5QqQuC0IR5KYB1NFXWkoz1S4kmSNtvryDjnHG4nVW5XRmW1fVb3RF5p+YEC4op
         MU6aUwq7vKFGk2uNp7IVwSQvZV+i7FwkEm2K0wBJYW3EySJWMkgowm4VyDswZR4OpKZs
         5Rng==
X-Gm-Message-State: AIkVDXIbbn6bkkpdkJXd+WAHldNElD+pMLtcTbqR4wR3xiA9mOUocI6OzYWgFbL92kpYB83nIfKdjxzELe3ZIQ==
X-Received: by 10.37.99.196 with SMTP id x187mr732024ybb.173.1481985401296;
 Sat, 17 Dec 2016 06:36:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Sat, 17 Dec 2016 06:36:10 -0800 (PST)
In-Reply-To: <10d14d56-c7a0-ac31-ec57-a9ed163e1204@ramsayjones.plus.com>
References: <xmqqbmwbqw25.fsf@gitster.mtv.corp.google.com> <CAOLa=ZREUWqdH_2HNn_JQcf4RW9k1dAN5BtwPN2HnzuDoUdkWw@mail.gmail.com>
 <10d14d56-c7a0-ac31-ec57-a9ed163e1204@ramsayjones.plus.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2016 20:06:10 +0530
Message-ID: <CAOLa=ZTVdWUrrCadfUmEB176RZ9zBUwFtPmUJAnj8nesosojqw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #04; Fri, 16)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 7:13 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 17/12/16 08:38, Karthik Nayak wrote:
>> Hello,
>>
>>>
>>> * kn/ref-filter-branch-list (2016-12-08) 20 commits
>>>  - branch: implement '--format' option
>>>  - branch: use ref-filter printing APIs
>>>  - branch, tag: use porcelain output
>>>  - ref-filter: allow porcelain to translate messages in the output
>>>  - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
>>>  - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
>>>  - ref-filter: rename the 'strip' option to 'lstrip'
>>>  - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
>>>  - ref-filter: introduce refname_atom_parser()
>>>  - ref-filter: introduce refname_atom_parser_internal()
>>>  - ref-filter: make "%(symref)" atom work with the ':short' modifier
>>>  - ref-filter: add support for %(upstream:track,nobracket)
>>>  - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>>>  - ref-filter: introduce format_ref_array_item()
>>>  - ref-filter: move get_head_description() from branch.c
>>>  - ref-filter: modify "%(objectname:short)" to take length
>>>  - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>>>  - ref-filter: include reference to 'used_atom' within 'atom_value'
>>>  - ref-filter: implement %(if), %(then), and %(else) atoms
>>>  - for-each-ref: do not segv with %(HEAD) on an unborn branch
>>>
>>>  The code to list branches in "git branch" has been consolidated
>>>  with the more generic ref-filter API.
>>>
>>>  What's the doneness of the topic?  I recall discussing die vs empty
>>>  and also saw a "squash this in when you reroll", but I lost track.
>>>
>>
>> I was waiting for more reviews, if any.
>> For now we need to come to a conclusion on the die vs empty discussion
>> (http://marc.info/?l=git&m=148112502029302&w=2) I'll start working on returning
>> empty rather than die.
>>
>> Also Jeff suggested some changes, which I've incorporated into my local branch.
>> (http://marc.info/?t=148112503600001&r=1&w=2). I'll reroll if no
>> further changes are
>> suggested soon :)
>
> Not forgetting to make 'quote_literal_for_format()' static. ;-)
>

Of Course, thanks for the reminder :)

-- 
Regards,
Karthik Nayak
