From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Fri, 8 Apr 2016 18:33:10 +0700
Message-ID: <CACsJy8Bru3ZW_g2HA3yNt_yc6fV9DfWLY1BHWzVWWxxrtLp-9A@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
 <01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
 <CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com> <CAFZEwPORAer3=WmUqqhztv4kAOHdv+yB12tRyUYh_YTSmtcQsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:33:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUfb-0004js-DY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbcDHLdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:33:43 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36245 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbcDHLdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:33:42 -0400
Received: by mail-lb0-f175.google.com with SMTP id bk9so40349991lbc.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iWLg3Elo7JnfL2BTrGwjdrfrBWL2Nk7mSDXQ8uyZUzE=;
        b=dRYR72i01gYCZSBselgHlvgsrr+c2G6klEH42V4tBePxThWrvCydwID5+m7rqbwc9x
         aD/YXp1rawMCb1J01DH5k1p3mpymJ/nGsmiHFoHkvwkVdiuR/JBAYFDWOkRPHHLvrrb6
         +fOZFn8mU2Kmb9GhQUhUCmHHnNL0xWTBs2A+eJfGdPH4yQUcBaKqZlguLPvfRq2xZRn2
         +FJXqtgKbnF9q1aRCmTK+oqNvPkNboCHE4LnVuPjVmL4HzqHzQ08bDfNLhoCX6CT3TY6
         /rqTa5+/+yXVaSTAqo04rainoW/RCpJu0xA9v1mLnTLx96l06imYF0h3AWA02VC75uAQ
         1l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iWLg3Elo7JnfL2BTrGwjdrfrBWL2Nk7mSDXQ8uyZUzE=;
        b=kDBXVEgk1EqpnI8Nt1toRb8ttZ915Wka5W4kOjMaL1LvBg7INh11kXkdGSLyLYkjSb
         wuGNYoqtdmyfHow6H/j9VIEiQX3+1mrqsuqtXYbo5RBj/Mu1A03/K8FsN1qOZB3fZNhj
         rWnHGztOLtKxlCiPUwgM44O7+bwguQgRLlKV2LJj13kDNIBLyNjgnwTLekiyuEHxp0dC
         u9SAfHZsYJXFLzi/KG9OF+BgjtiUq0IjkKxASZOAztT9er7hNLaJIXaJ/Adn+o5CvLnf
         3n3SFwYJXEuDmaPZAVQrxLOmorgz3nFuOr9lS1IGuQIFOsfjl9934i3wM6AFdTJDeZh2
         50JQ==
X-Gm-Message-State: AD7BkJK9QteZTU0kbTP1Qa4PQe8eBfR4064YDEpHc4mGREp1eyZXo5sD15K1+RgSmIlpQ9qjw9ax7HlwnKTwBQ==
X-Received: by 10.112.209.99 with SMTP id ml3mr3349294lbc.26.1460115220139;
 Fri, 08 Apr 2016 04:33:40 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 8 Apr 2016 04:33:10 -0700 (PDT)
In-Reply-To: <CAFZEwPORAer3=WmUqqhztv4kAOHdv+yB12tRyUYh_YTSmtcQsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291024>

On Tue, Apr 5, 2016 at 10:39 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> [+cc:Duy Nguyen, Jonathan Nieder]
>
> On Mon, Apr 4, 2016 at 3:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>>> and not boolean and thus it is more appropriate to print it as integer
>>> to avoid confusion.
>>
>> I can buy this line of reasoning, however, it would be even easier to
>> sell the change if you cited an existing client (a git command) which
>> actually respects multiple quiet levels. Are there any?
>
> I investigated into this. But I was unable to find any git commit
> which actually respects mulitple quiet levels. I first did a 'git grep
> OPT__QUIET' to find the commands which use this. Then I went through
> the documentation which covers it. None of them have any such mention
> of multiple quiet levels. But still I dug further and and went through
> all the individual source files. I followed the corresponding C source
> code for the header file included and also searched there for any
> trace of quiet. But I still didn't find any such use of multiple quiet
> levels. I have found that the commit id 212c0a6f (Duy Ngyuyen; 7 Dec,
> 2013; parse-options: remove OPT__BOOLEAN). Maybe he has something to
> say as to why this was introduced and OPT__QUIET which previously used
> OPT__BOOLEAN, now uses OPT_COUNTUP rather than OPT_BOOL.

I don't have much to say because my commit is a harmless conversion :)
OPT_BOOLEAN _is_ OPT_COUNTUP with a misleading name, see b04ba2b
(parse-options: deprecate OPT_BOOLEAN - 2011-09-27). If you dig
further back, both OPT_VERBOSE and OPT_QUIET are introduced at the
same time in 0ce865b (Add shortcuts for very often used options. -
2007-10-14) and they both are defined with OPT_BOOLEAN. I guess it was
just an oversight that OPT_QUIET is defined as OPT_BOOLEAN instead of
OPT_BOOL.
-- 
Duy
