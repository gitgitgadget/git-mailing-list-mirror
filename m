From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 13:18:46 +0200
Message-ID: <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
	<CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
	<CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
	<20160415095139.GA3985@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 13:18:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar1m3-0003bs-3q
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 13:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbcDOLSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 07:18:49 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38317 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbcDOLSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 07:18:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id u206so27447983wme.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=msx91igPHcn9xiVlzvsIvMDYeA5Hw2BiRkhF2iWWXDw=;
        b=Gxv1nZIwL2R6V9M0N10ehXc+5TMj5gAWjuGj1tDFoP5VwjoOuCtqsNYpW3GvKUSLcn
         Kugs5rhaA4QSjfBDekLrVYbqPSZ/NIntZM9oZn8oiyJNo754tVU1fJCNIZy6F94yrmyx
         OMiQv8/vdezjnqS3n/l5t+GkHmoi2AbRaUdACM4z6FyIUPBiRQLRc1nXfl0bpnad1tUz
         2Iqs04mkvqITN7zzdwvJf5wql52PbMQKOhANO/xERWFNlFSnArp4ElP+Hdzw2+1VcU9h
         YvEsm42NnlzANGD1CH+73AFPLg1UHQqDDX0Vuyh8pIuJOEwh/bROGAN96rsUzXqh87My
         Rwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=msx91igPHcn9xiVlzvsIvMDYeA5Hw2BiRkhF2iWWXDw=;
        b=HymAxqriim2zB3boAUQ8VWeReK+3H02morprXrgVeeJfyTiDb4w8m6CHylq4HwBPNM
         A5En5VFSAVBvaCcGRpKHw7uKqEMdYLRMUX4Al2E/yJJ0nowIVotDK/QTNtvPEl5eMNkO
         CXi9mYxYFp4iqb5ABUO+6ZBBioo/Nx7w5KeL1KINliS1gOJw5tU5LGl2OvkmjecQCYYL
         z/yoToYl9BLxk/iEbhjMyUthQAp6fnJ3RMjBrTT6vMzgnZdPBiqOURAFeKC0ksNCh/+z
         EDw8X6OYZiMK/0HZbC+3hcuivBkNXOOQvmZs2TmSUk6KgdbKe8aoLcZ8Tv0NTJMlbWSU
         Nzaw==
X-Gm-Message-State: AOPr4FXo0v7odTxhX3fZD2SBKDFpX++d8SfxNmk3EWsYzDww/h04x7VuF2HMvIIGQ4U3pTLoBQFwWdw5h/H4Ag==
X-Received: by 10.28.32.199 with SMTP id g190mr4021940wmg.62.1460719126112;
 Fri, 15 Apr 2016 04:18:46 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Fri, 15 Apr 2016 04:18:46 -0700 (PDT)
In-Reply-To: <20160415095139.GA3985@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291601>

On Fri, Apr 15, 2016 at 11:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
>>
>> There is a draft of an article about the first part of the Contributor
>> Summit in the draft of the next Git Rev News edition:
>>
>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md
>
> Thanks. I read the sentence "This made people mention potential
> problems with parallelizing git checkout" and wondered what these
> problems were.

It may have been Michael or Peff (CC'ed) saying that it could break
some builds as the timestamps on the files might not always be ordered
in the same way.

Now perhaps parallel checkout could be activated only if a config
option was set. (Yeah, I know it looks like I am very often asking for
config options.)

> And because it's easier to think while you test
> something, to flesh out your thoughts, I wrote the below patch, which
> does parallel checkout with multiple worker processes.

Thanks for your work on this. It is very interesting indeed.
