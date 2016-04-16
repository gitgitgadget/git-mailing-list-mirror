From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Sat, 16 Apr 2016 07:16:12 +0700
Message-ID: <CACsJy8BruDfmGvA=q+BW61ZKKsTjrF96VzpujEJidm=OtC0_Rg@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
 <20160415095139.GA3985@lanh> <CAGZ79kZP_TUUk3vWHe=c301n66FtQpnwPfPmJ6oD8n-Zz-SVyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:16:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDur-0003e3-J4
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbcDPAQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:16:45 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33526 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcDPAQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:16:44 -0400
Received: by mail-lf0-f45.google.com with SMTP id e190so162935711lfe.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tVJCJ7BVMXjg9cqKhkkMYLhZD3PuFHyL+2yybRs9o+M=;
        b=PlDV4ei+xrFo5EqsAerek2vfOwAUX57J6xUoqzcwP3ZOW82OHt/44Oe/bXaNXcEbc1
         8TDT0oqHyMl7yOmrHX8MtzY8cn8HYtBpbSGDGyW0ea8lsJg2JMKwe0Kpr9+sSxjf4Lkt
         e/ESx00dgtQLuhu/WVw6NofJSi37asP0aKb4Isr6diPc+Can+8wrsxGoBRcTHO4+pMAj
         3kdAhZo7K+3kOMV4mNmKrJ7SrIXcnzJYlvWkcw5fxaYAHJyCpDGrT0ybOoIWm7mLgdfC
         uhrkkPvKUBCs9g3+TZGElOWm6JlCD7mac2okMlJlNJKzM1q+dYRinkymhO9ua5yuyi8q
         SCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tVJCJ7BVMXjg9cqKhkkMYLhZD3PuFHyL+2yybRs9o+M=;
        b=LXGKixK6VpS25kkDxvIWU4dkMPjEVSI6TT0YaH40oUooJym16rhpcxq6JWLKUkXD1g
         s80OoD/SpHeKN3e2TEAv2Q53R8hLijfOlKjk+x/Ba1QKzaPi/ksqrQA+z2D6a3YipxK/
         fuq7P/MwedCDyuSOTPFIFuKd0KwsCPg2a2A/8mBFL/nas8FmEu6mGs9rwxSA/2UBfikb
         ZR2ZM2xKFS2QFCb1aLuBzmu9i9ELnG7AQ5dX/QcxFXPA/Tw/04xd3VyWJat0KHAdqQeD
         pcN5zThSLR7LY7u+0TlEe98XtoCqQSKcm63gOuzXpEgEpsyfP8p/f0Tfv417OQHTmc/R
         boUA==
X-Gm-Message-State: AOPr4FWOiOTt+bGBzI6bFGmnD0O+VyHDI9pZdpVdT4W50GUIsWVzhKSBb3PTjPe3YHrt3NDCl8KRUWLVs2qZZQ==
X-Received: by 10.25.17.67 with SMTP id g64mr10737954lfi.112.1460765802822;
 Fri, 15 Apr 2016 17:16:42 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 17:16:12 -0700 (PDT)
In-Reply-To: <CAGZ79kZP_TUUk3vWHe=c301n66FtQpnwPfPmJ6oD8n-Zz-SVyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291704>

On Fri, Apr 15, 2016 at 10:08 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 15, 2016 at 2:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
>> The idea is simple, you offload some work to process workers. In this
>> patch, only entry.c:write_entry() is moved to workers. We still do
>> directory creation and all sort of checks and stat refresh in the main
>> process. Some more work may be moved away, for example, the entire
>> builtin/checkout.c:checkout_merged().
>>
>> Multi process is less efficient than multi thread model. But I doubt
>> we could make object db access thread-safe soon. The last discussion
>> was 2 years ago [1] and nothing much has happened.
>>
>> Numbers are encouraging though. On linux-2.6 repo running on linux and
>> ext4 filesystem, checkout_paths() would dominate "git checkout :/".
>> Unmodified git takes about 31s.
>
> Please also benchmark "make build" or another read heavy operation
> with these 2 different checkouts. IIRC that was the problem. (checkout
> improved, but due to file ordering on the fs, the operation afterwards
> slowed down, such that it became a net negative)

That's way too close to fs internals. Don't filesystems these days
have b-tree and indexes to speed up pathname lookup (which makes file
creation order meaningless, I guess)? If it only happens to a fs or
two, I'm leaning to say "your problem, fix your file system". A
mitigation may be let worker handle whole directory (non-recursively)
so file creation order within a directory is almost the same.

> Would it make sense to use the parallel processing infrastructure from
> run-command.h
> instead of doing all setup and teardown yourself?
> (As you call it for-fun patch, I'd assume the answer is: Writing code
> is more fun than
> using other peoples code ;)

I did look at run-command.h. Your run_process_parallel() looked almost
fit, but I needed control over stdout for coordination, not to be
printed. At that point, yes writing new code was more fun than
tweaking run_process_parallel :-D
-- 
Duy
