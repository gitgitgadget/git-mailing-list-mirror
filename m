From: Stefan Beller <sbeller@google.com>
Subject: Re: Developing- Where to Start
Date: Mon, 14 Sep 2015 15:15:59 -0700
Message-ID: <CAGZ79kbiFvm-C3MdED5Jja3b_S+WY1CR3iNQJ7MYcKjnZG4Nxg@mail.gmail.com>
References: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
	<CAP8UFD1NSAKsJDrav6dBF=92Ba9KY-MVtEydQPqfpSNrReSArw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Breanna Devore-McDonald <Breanna.S.Devore-McDonald.1@nd.edu>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 00:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbc2k-0004jI-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 00:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbINWQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 18:16:01 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36847 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbINWQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 18:16:00 -0400
Received: by ykdt18 with SMTP id t18so147237492ykd.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wl35CnbzNsQQi9aRd0I099z7K9iuleDA3gH8vKl4BIc=;
        b=Zvr1SOXbwxs1iuVIk+xCzHDqYG4ZwG5LEadBMt+bUQ0DTKdVql9UUX6lNDHlw+luoT
         oGVnrvnQFWpKF8zF01UPROGW9hxjfbY9WOM4Fy5p7XhPo0zLdmFPMUTQXooqJuX2j06F
         78Hhyu8ZoAINOF9dYYJm26CnSKzeC+Iz11hbCxiPmK1Ef3Zd23b3Gahag+worWtEUvgS
         mO8h2DCEUvpXuEg8QeG8J1Uq3D4b7CI9JmGJdnKnSkVh6BhzaCl5wVGlA56JhWofKT68
         RvneFEV8hrMTczLqeCnbqO5G2k12SVXkL7Yf6Ih6jA3D+WFJDN/ZM3jahdm4cGUz79mQ
         jq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Wl35CnbzNsQQi9aRd0I099z7K9iuleDA3gH8vKl4BIc=;
        b=LLRiRCPOjkqy3FS+mccfN6nWJQQm2PQ6+e5H+aGZWvI5gnpWEv2T/RRc6W07CU2Neo
         GjD1ipZfKJm3T91fPzKGD0NgSYm4U47tQcL4/nZII3jtJ5xitGBh3qGcWuvv3tovjLOl
         xfy7hsrJlQ/m396iXih/Clwbig4+e6GL1zOBpmXGqRNL5hDPrJ4Epm92MCZ+PV6SzKf/
         zERNhyffV6WlQHKRuAcCCUYNLBvF/n/ncykd2hCEAmgOIMPD6u6GDZRkiMHW6Rf9rw8V
         ZS4rk06KOtiXW53Mqo5SHlfQyf9dOFe3akUlLFeLtE7iRFfQoekP8Cq0NGopKeEfqI1K
         eAfA==
X-Gm-Message-State: ALoCoQmGueTfF0g/6AtAsZz0KPqKMOtBLRFowZ1h+NdmNDhCXMP0RN0nF5UZ2Iuv41iPqBAsLwMS
X-Received: by 10.170.210.65 with SMTP id b62mr16080612ykf.10.1442268959390;
 Mon, 14 Sep 2015 15:15:59 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 14 Sep 2015 15:15:59 -0700 (PDT)
In-Reply-To: <CAP8UFD1NSAKsJDrav6dBF=92Ba9KY-MVtEydQPqfpSNrReSArw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277869>

On Mon, Sep 14, 2015 at 2:30 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> On Mon, Sep 14, 2015 at 10:42 PM, Breanna Devore-McDonald
> <Breanna.S.Devore-McDonald.1@nd.edu> wrote:
>> Hello all,
>>
>> I'm a third year Computer Science student at the University of Notre
>> Dame, and for the final project of my Data Structures class, my group
>> and I have to find a way to contribute our (hopefully) newly-found
>> data structures and optimization knowledge to a well-known open source
>> project. We thought Git would be a great project to work on, but we
>> have no idea where to start. Can anyone offer ideas or parts of the
>> code that we could possibly help with? (a problem that is data
>> structures-related would be extremely helpful!)

One problem focused around data structures may be rewriting
the git bisect internal algorithm. Currently git bisect uses an O(n^2),
but there are better algorithms available such as [1]

[1] https://docs.google.com/document/d/1hzF8fZbsQtKwUPH60dsEwVZM2wmESFq713SeAsg_hkc/edit?usp=sharing
  The algorithm presented in that doc came up in a discussion
  between some Git developers, I just wrote it down. Maybe it's
  understandable.

That said, usually the tests in git bisect take the most time,
so it is an internal optimization related to data structures, whose
impact is estimated to matter only a bit.
Also I would estimate the project to rewrite git bisect to be quite a
lot of effort.

>
> The Git project often participate in the Google Summer of Code.
>
> This year we used the following resources to help potential GSoC
> students get involved in developing Git and find a project to work on:
>
> http://git.github.io/SoC-2015-Microprojects.html
> http://git.github.io/SoC-2015-Ideas.html

Yeah the microprojects are awesome to get into Git development!
Also look at http://git-blame.blogspot.com/p/leftover-bits.html
for smaller projects.

>
> A GSoC wrap up has been written recently in Git Rev News edition 7:
>
> http://git.github.io/rev_news/2015/09/09/edition-7/
>
> Earlier this year students from Ensimag (Grenoble, France) also
> contributed to Git and a small wrap up is available in Git Rev News
> edition 5:
>
> http://git.github.io/rev_news/2015/07/08/edition-5/
>
> I hope this will help you get started in your Git development journey.
>
> Best,
> Christian.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
