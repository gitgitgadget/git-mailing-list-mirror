From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Mon, 24 Sep 2012 12:06:15 +0200
Message-ID: <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
 <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com> <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 24 12:07:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG5ZD-0006eq-7J
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 12:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab2IXKG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 06:06:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36150 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab2IXKG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 06:06:57 -0400
Received: by ieak13 with SMTP id k13so10362339iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=u3lgNAgZr9lxfkOBtmB52vQFPdyzODHVF8C7/Q+7AqU=;
        b=EjMRRo9dF+LpCbIxycRSY7CFBPUJ+/RUvY2E8VrR7Oiwi5rUEJq43Xb/4O22SGVwNi
         5cX/TY8L7tJuWYfIrE3pbl7jevNnjFZqjfU36zlbkggThDbAWDi0/prhnMPJJKVyGCjt
         BUkv2sg+ChmBJV+f3NhoJgl1ySlyB8CTF6+8TRrQdE9rgR7eGVmRe979G3KY6B9saORS
         HBPx1ddT/D3Yg2xwusi8HA2RORbhTeo6ywhrgmRu5vUEll8r+WwAQUMPSiQq2Aoi/E5J
         fJaJ0hWVo3R37lMbkHch41ctp6gJR5kWaR6Tfv6YfKox/97mpqJJ+Kr0m5Y6fNWi6TTl
         Q7ww==
Received: by 10.50.160.202 with SMTP id xm10mr4786916igb.10.1348481216395;
 Mon, 24 Sep 2012 03:06:56 -0700 (PDT)
Received: by 10.43.103.4 with HTTP; Mon, 24 Sep 2012 03:06:15 -0700 (PDT)
In-Reply-To: <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
X-Google-Sender-Auth: XCvBjzKkTzrTlQoU31SRtwL6r9o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206260>

Yes it works great, thanks!

2012/9/16 Jonas Fonseca <fonseca@diku.dk>:
> On Tue, Sep 11, 2012 at 3:24 PM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
>> 2012/9/7 Jonas Fonseca <fonseca@diku.dk>:
>>> [snip] I suggest to support something like the following:
>>>
>>>     tig --no-walk --stdin < tmp-file
>>>
>>> Would that cover your use case?
>>
>> That would be great!  I would then feed tig with all commits I want to
>> see in the main view.
>
> When you have time, please test the main-view-with-stdin branch in
> git://github.com/jonas/tig.git
>
> --
> Jonas Fonseca



-- 
Jean-Baptiste Quenot
