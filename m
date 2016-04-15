From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Parallel checkout (Was Re: 0 bot for Git)
Date: Fri, 15 Apr 2016 18:32:49 +0700
Message-ID: <CACsJy8D-VzOY7UWjM5dNmXkog2L3NN3h3cJSizxC2Rbn-g8RiA@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
 <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
 <CAP8UFD3xWUkCFZMN1N6t36KKwcfnkLsFznAc7j7yF89PbYaqfg@mail.gmail.com>
 <20160415095139.GA3985@lanh> <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 13:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar20L-0002yd-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 13:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcDOLdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 07:33:38 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34875 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcDOLdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 07:33:25 -0400
Received: by mail-lf0-f42.google.com with SMTP id c126so141870494lfb.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8eiUt/6y7NKmN4eQ07N4jPkd9JJGEP9k2tD5IVIlXFI=;
        b=uZ1iphx1lwSZRYZ9pliOn1eF5SHhluKbo/bkCK+0IKGtQuePV5lqMCCpWojN+xxCcl
         q9DGTwqx641BYDYcJG9x8aXj5Rb5MiwRpCWAFGnf2IBtrsbZmEwD8r1HUObwXmrC0Qam
         VBn32xS/RtusgvS2llHvNYFUgQMPOV8o2VakXjRNtE/x6QkkJh2mb1Mg/Ugy+zHwVedX
         +QysYHTIGg8+X/FXF6PTrmOrnv5R83JEXZpNcO/kAzalTZaDrkoqx1roq2HOjK21J2DG
         qmtPF5Gzhsg1lYTZQSGSQpOx2c1kYMTNmjxWLppe3r+0GzqkK0FUOYeuPKe2ZHm3Vaqk
         GkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8eiUt/6y7NKmN4eQ07N4jPkd9JJGEP9k2tD5IVIlXFI=;
        b=BG+ykNzIwS7pN24M5gS/t2iK5rH2rj1Jm98MF98rUrRG5m+14D49937bIIiwChWheD
         zjXO3T7axkuGHBQtLrQu9t3WKA2DVM3J0k42heeIzDQM1NAH8fgDai+usPSP9hSu9XkS
         o1dzJpL0rbVQaprQQbkKuL4SNpFY9ycGV4QAF4UanZrD62GGQ+jN4rdhDyVtlLqc+b0K
         a7sKQh7BU4kyd/D83GEtCdnsk7c1lfVT8qq9E0Mky3K2Qtp6gnKdDkaV9HL6QHh9s5C7
         aGv/x6ynDpHD+Ckz8r9R+xG7qKU4E4zNnYRGFYVFCDs4u5CMFZfS40jdn8SaFtK3tB87
         FXBQ==
X-Gm-Message-State: AOPr4FXAfi1AAbBb85jGZKuc+ZC9aCQFcOhnJtSxySdRJHUsfrQsFUELzcb4qUiVGCRwfN58RTkF3v2QVnUdMQ==
X-Received: by 10.25.17.67 with SMTP id g64mr9315842lfi.112.1460719998958;
 Fri, 15 Apr 2016 04:33:18 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 04:32:49 -0700 (PDT)
In-Reply-To: <CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+N2x9UBYxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291603>

On Fri, Apr 15, 2016 at 6:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Apr 15, 2016 at 11:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Apr 15, 2016 at 12:04:49AM +0200, Christian Couder wrote:
>>>
>>> There is a draft of an article about the first part of the Contributor
>>> Summit in the draft of the next Git Rev News edition:
>>>
>>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md
>>
>> Thanks. I read the sentence "This made people mention potential
>> problems with parallelizing git checkout" and wondered what these
>> problems were.
>
> It may have been Michael or Peff (CC'ed) saying that it could break
> some builds as the timestamps on the files might not always be ordered
> in the same way.

Very subtle. I suppose if we dumb down the distribution algorithm, we
could make it stable (even though it won't be the same as serial
checkout). Performance will degrade, not sure if it's still worth
parallelizing at that point

> Now perhaps parallel checkout could be activated only if a config
> option was set. (Yeah, I know it looks like I am very often asking for
> config options.)

And I think it could be unconditionally activated at clone time (I
can't imagine different timestamp order can affect anything at that
point), where the number of files to checkout is biggest.
-- 
Duy
