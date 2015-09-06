From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] tag: support mixing --sort=<spec> and -n
Date: Sat, 5 Sep 2015 23:25:05 -0700
Message-ID: <CA+P7+xqTT2soejXEmpaqfLTF3twWERTLZY6OpW2KdJHS3jxKyQ@mail.gmail.com>
References: <20150905175202.GC7050@zero.home> <CA+P7+xo=4mC0fKkbtL+fkMXGxdUNcdUGUYHdaJ58MF9jVUUziw@mail.gmail.com>
 <CAOLa=ZTiG8aMdURDYTHALGfhkg_YWe6bXEmPUySgGBrrQXD+Nw@mail.gmail.com> <xmqqoahgb1r9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Rudy Matela <rudy@matela.com.br>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYTOL-0000BI-V0
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 08:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbbIFGZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 02:25:27 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38530 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbIFGZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 02:25:25 -0400
Received: by igbut12 with SMTP id ut12so39518924igb.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nJsrOhmouAtvCmUZG/pwupDttxa9IBvvKmn1Ob5PPmo=;
        b=y98PrLhE2SduhJlgWfC8z4OLXOC99j2vMCjKVJMJUw0de8aFeUh7qXS6IdBGeB7ATE
         nerv/UQ15CGsd2A3zX/LP7YgxEfYowqSIs8kNM05BYnF/IuB3hqB4VZZ956dDKxxZk6o
         Y4Zv7D23AjBxtCgeTSX3yKnh3/UbCJobcJBrqLyuN7ackP/PMZF2TcuSK+sH6fqO3315
         d0Awk9vWlvi88XVaYcCqf2Al37AgRybBV/x0hmLanhUQeb01u2+Pa21db/WzIbIz7iA2
         /BxfLhaI9ZrYxM9+Oxnwf00sf6hE9CoNfV/9DhrslmvVE8HAlrooM6kIFiPhI/Wg54E+
         0a1Q==
X-Received: by 10.50.78.161 with SMTP id c1mr20973591igx.35.1441520724782;
 Sat, 05 Sep 2015 23:25:24 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 5 Sep 2015 23:25:05 -0700 (PDT)
In-Reply-To: <xmqqoahgb1r9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277416>

On Sat, Sep 5, 2015 at 9:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Sun, Sep 6, 2015 at 3:55 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> On Sat, Sep 5, 2015 at 10:52 AM, Rudy Matela <rudy@matela.com.br> wrote:
>>>>
>>>> Allow -n and --sort=version:refname to be used together
>>>> instead of failing with:
>>>>
>>>>   fatal: --sort and -n are incompatible
>>>>
>>>> Signed-off-by: Rudy Matela <rudy@matela.com.br>
>>>
>>> Nice! I've been wondering about this one for a while. Especially since
>>> implementing tag.sort configuration which made -n not work at all.
>>>
>>> Note that it may be worth rebasing this on top of Karthik's part tag
>>> to use ref-filter series, since I think there will be plenty of merge
>>> conflicts there...
>>
>> Its already resolved in my series. We use ref-filter's sorting APIs
>> there :)
>
> I guess Jacob needs to rebase that tag.sort thing on top of yours,
> then ;-)?

Ya.. I wasn't sure if this was resolved, and I ended up deciding to
wait until after the tag re-write landed to look at that again.

Regards,
Jake
