Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360C32018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcGANSK (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:18:10 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38568 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcGANSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:18:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id r201so28978665wme.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 06:17:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=S3RjXj4kc6gpPCjgk1IQSXn0ZrbcwPbJPqTmeY7ddkA=;
        b=DnMBjQS4MZjnudOWUPcB8UqP5suquMPTV0ewaGH9dKhulsC/pvx5FsZ8kN4L8rDqon
         4N8XL2KKb6uQIhMfibW01G5KUI3lN6BfhrbLdzuGEwFIVrtQzm2Z5oxS+6UWLi3q09/n
         wzchhGNh8OEepPZdt853EXfbQpEhIwShKcbDdEPVDgakJ5cmY9Mtp6Tzfaf8/uB/KNxZ
         6g41xcWrfwE9vHPMscRb90DpZtT8OJNEYu5FZ2lceKPKqIwdTfZViAqAWrGlpcdxwMPT
         6LxAvSEexhuprZeS0eSHgnLi5kgEnIsOUPgpvIwDrtEbOiS7mxz1Fi++wiY/ReqYl3Ej
         yFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=S3RjXj4kc6gpPCjgk1IQSXn0ZrbcwPbJPqTmeY7ddkA=;
        b=hZ1e19eC2+2cCdTiWxlYTW96QAv11AZ1Wo1ySTTu5uI06UYpGTbvrr/5TtDFUQN7y/
         v2IbBmEDGr/BKylJXj2sFd3wEdKx4xZg0dyT34dNsNMi1bo8Q7AxDa0dx9Oe0sh/D5g2
         3a6fbCcScL9L9C98I4SbVooavWE+5u6xyu6CF1bRnl9Mdnywve50BZoXijdPrznBx8fQ
         8QAR+kCMbL8P03odXEuAulRB4sVpEQXcQMxvHglt+k+YrBdE8RA1fZOfPFlsNL1LdLNq
         lAjchumb+xlDeOpdv82hpJcPmb5h3Ge/zuBdtyLPn8AZvcqabJgiWrKnZ+Qpy4qKUG2g
         1QsQ==
X-Gm-Message-State: ALyK8tJaFVDx+FqwxKghy2LZ79HW8KR5pqfZkKNon6RgY4WkZP1a1UXKEoU5sWUPFmzaMQ==
X-Received: by 10.194.115.130 with SMTP id jo2mr4121582wjb.82.1467379056256;
        Fri, 01 Jul 2016 06:17:36 -0700 (PDT)
Received: from [192.168.1.34] (enw201.neoplus.adsl.tpnet.pl. [83.20.12.201])
        by smtp.googlemail.com with ESMTPSA id x10sm258797wjj.14.2016.07.01.06.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jul 2016 06:17:34 -0700 (PDT)
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec
 handling
To:	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <577425EF.6030900@gmail.com>
 <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
 <57743BFB.9040709@gmail.com> <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com>
 <5774E992.7070905@gmail.com>
 <CACsJy8AES0iu341DU6FDYZq6fmssbD3QSZaiwi9BntTnMQS5Gw@mail.gmail.com>
 <20160701064224.GD5358@sigill.intra.peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57766D5C.3040200@gmail.com>
Date:	Fri, 1 Jul 2016 15:17:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160701064224.GD5358@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-01 o 08:42, Jeff King pisze:
> On Thu, Jun 30, 2016 at 05:14:15PM +0200, Duy Nguyen wrote:
> 
>>> So we could describe how Git handles pathspecs and pathspec magic
>>> in the new manual page named gitpathspec(7), or gitpaths(7). The
>>> former has the advantage of the name being identical to the entry
>>> in gitglossary(7). The latter has the probable advantage of being
>>> easier for the Git novice to find,
>>
>> git-pathspec(7) is a great idea. It bugs me that all the pathspec
>> details are hidden in that glossary file (though I didn't know it was
>> also available via "git help glossary", which probably just reinforces
>> its invisibility). The closet place I could think of was git(1) but
>> that page is already very long.
>>
>>> and that it could be used to
>>> gather various ways to generate list of files in Git (files in
>>> the working area, files in the staging area aka the index, files
>>> in the revision / tree object, changed files, etc.);
>>
>> You mean the list of commands in this man page? OK. Another thing we
>> could do is the reverse direction, add gitpathspec(7) as a reference
>> to all commands that may need it.
> 
> I'll second (third?) this. Some of our manpages are quite unwieldy, and
> I don't think we are doing any favors to users when we auto-include the
> same content in multiple places. I think we should instead be splitting
> concepts into their own pages and referring to them. That helps users
> build the mental model ("aha, pathspecs; I read that concept page and
> know how those work!" instead of "here's 3 pages of description on how
> git-diff handles paths. Is it identical to the 3 pages in git-log?").
> 
> I suspect some things like diff options could benefit from a similar
> split.

I'd rather we keep manpages self-contained; one reason is as you said
below easier searching.  I also prefer not to have to follow from one
page to another.

On the contrary, I think it would be good idea to include full list
of a configuration variables affecting specific command in its manpage.
Currently almost all configuration variables are in git-config(1)
manpage, but some are in individual manpages, and only linked there.

Redundancy in reference documentation is not bad, provided that it
doesn't require duplication in documentation sources, and that the
documentation itself is not too long, and not too unwieldy.

>>>  Sidenote: I wonder if people (especially novices) have problem
>>>  finding relevant documentation, and if adding something like
>>>  "git apropos <topic>" command ("apropos", or "man -k"), or
>>>  add the '--apropos' option to "git help" would be useful...
>>>  and if it would be easy to create.
>>
>> I have that problem sometimes and I don't think I can call myself a
>> noob anymore. I usually need to do some grepping. So yeah "git
>> apropos" would be great.
> 
> I think better searching would help a lot if we split things into more
> pages (right now, a legitimate technique is "man git-foo", using search
> in the pager, and wading through all of the false positives. That sucks,
> but at least you can find what you want _eventually_).
> 
> I'm not sure if "man -k" is all that great, though, for two reasons:
> 
>   1. AFAIK there isn't an easy way to restrict it only to git manpages
>      (try "man -k git"; oh, hello "isxdigit(3posix)").

One solution would be to use "apropos" / "man -k" and then filter it
(e.g. with /^git/) to filter out non-git manpages. 

Another would be to search whatis database ourselves. Yet another 
to create whatis-like database, and put it in /usr/share/doc/*.
In both of those cases Git would search the 'database' itself.

>   2. It only searches the title lines. So it's great for finding the
>      pathspec page, but you could probably already do that by guessing
>      it's called "git help pathspecs". But if you're looking for
>      discussion of a particular diff option, say, it would be nice to be
>      able to search for all mentions of "--word-diff-regex", or
>      something.

Well, for apropos-like command to work well we would need better
description of manpages, isn't it?. It is getting better, but we still
have a bit to go...

If Git was to create a whatis-like database (for future "--apropos" and
"--whatis" options to "git help"), it could add extra information, for
example keywords (which would have to be added to manpages sources,
and embedded in whatis-like database when creating man, html, etc.
documentaion formats, i.e. when building documentation).
 
>      There is "man -K", but it kind of sucks (it seems to just dump you
>      in any manpage that matches, in a list).

By default Git installs into /usr/share/doc/git-x.y.z the *.txt and *.html
documentation formats. We could follow "man -K" / "man --global-apropos"
example and search sources... but then we would need to follow inclusions
at least for it to be useful. We could search HTML version of manpages...
but then we would have to strip formatting codes before performing a search.
 
> I don't think those are problems that _git_ should necessarily be
> solving, though. It's a general problem for manpages. And there may be
> better "man" implementations than I'm used to (or even options or
> configuration I don't know about).

I wonder what other version control systems do, like Mercurial, or
Subversion, or Veracity with providing access to their reference docs...

-- 
Jakub Narębski


