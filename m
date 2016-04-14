From: Christian Couder <christian.couder@gmail.com>
Subject: Re: 0 bot for Git
Date: Fri, 15 Apr 2016 00:04:49 +0200
Message-ID: <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
	<CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpNg-00046Y-1z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbcDNWEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:04:52 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37695 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcDNWEv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:04:51 -0400
Received: by mail-wm0-f53.google.com with SMTP id n3so7428196wmn.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xeQ3XtVbgZmzjNMtKwNLpxdpFHCoLeD5TYXY+5D/2EI=;
        b=ZAqiZFIeykHir4T2PcxXDUjVfF0gRQcSCc6B4aTkvT6XuBkQzj2+J04R2FGBA+tezM
         ehvstAfCbxTEGefJByWizvD9HqeaaTAwj6gJVJx3KGaLdjRvInpiOmqdaILzBnVqBb9G
         R0MLu2Qnwv3JlMPu5kb+iw/Unrq4POhkCghDM8J414aDlF7AX3PsjE+EzCHF7JERsQ1M
         +BlVv0HFMVgnVe2+F56WwWFvz609tm8hkmUjto3RvmRQz1zYtZl8vhFudARK3kjePJym
         0UwBTvEv0sMwfNiK6wAHIVMMK9gsAKIUv32oEkQFpo0VeGFN6l0L9lm+N/D5BRExG68g
         V0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xeQ3XtVbgZmzjNMtKwNLpxdpFHCoLeD5TYXY+5D/2EI=;
        b=FWnIPtu74kLlpz8NrflbnbbkETkkW6C8tQCOvQAVgwel34m5JXxEiWqnQ7XztLrkP+
         XuW6dDcwS5/6DdLomNINFIrXZsWe885fMO9fwsVFMklplw4c0AHWfEwIrGAG7Tpb11DE
         j5S7jA5U0rFwK5mLyMY6qEmSeERMj4zobejO33PY63A5QMcl0Ggq9ODlpRmrp9l1YL4/
         kREHY19qWpi2hLYJP2RM8sFAfNyhT9lO1YDDpmSubqqAGPUG990jSzgCa64f9BJHKzi4
         pPiNJAIOzL4ckNPKjGQXoghy/yAI1mQQZ/nMx9Z184AdQFn/rA5DNlQ+1t0XLOvHTTzC
         Vy3A==
X-Gm-Message-State: AOPr4FV5de/TbTogDUbIsDV8KGqbOkH8x2v+aAD7XkK+SoslLOfgY2dTUl9DFbbkAE184C2GhGhDCJXXVFhKYw==
X-Received: by 10.194.117.70 with SMTP id kc6mr19543408wjb.94.1460671489621;
 Thu, 14 Apr 2016 15:04:49 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Thu, 14 Apr 2016 15:04:49 -0700 (PDT)
In-Reply-To: <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291568>

On Tue, Apr 12, 2016 at 4:59 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Apr 12, 2016 at 2:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
>>>> Hi Greg,
>>>>
>>>> Thanks for your talk at the Git Merge 2016!
>>
>> Huh? It already happened?? Any interesting summary to share with us?
>
> Summary from the contributors summit:
> * encoding was a huge discussion point:
>   If you use Git on a case sensitive file system, you may have
>   branches "foo" and "FOO" and it just works. Once you switch over
>   to another file system this may break horribly.
>
>   The discussion revealed lots more of these points in Git and then a
>   discussion on fundamentals sparked, on whether we want to go by the lowest
>   common denominator or treat any system special or have it as is, but less
>   broken.
>
> * We still don't know how to handle large repositories
>   (I am working on submodules but that is too vague and not solving
>   the actual problem, people really want there
>     * large files
>     * large trees
>    [* lots of commits (i.e. lots of objects)]
>    in one repo and it should work just as fast.)
>
> That was my main take away.

There is a draft of an article about the first part of the Contributor
Summit in the draft of the next Git Rev News edition:

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md

Everyone is welcome to contribute about things that are missing or not accurate.
