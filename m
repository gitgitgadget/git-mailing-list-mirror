From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Mon, 24 Sep 2012 16:29:01 +0200
Message-ID: <CAK6bCazQvYP8dgQzF5BY5+UNfGvm_SOcrVZoREdpszyrHOjEuQ@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
 <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
 <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com> <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9fc-0004ak-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab2IXO3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:29:45 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48575 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab2IXO3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:29:42 -0400
Received: by vbbff1 with SMTP id ff1so6159752vbb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=wWGn4aFjsN/8cl4xufqkd7rQfs0dV9gPHwa4ZgMwEKw=;
        b=s13ILfoBgtD4KL2Y602RsZSz8a0ChiuapY58V5TfMtk3+nXkdYY79w62PnUKK07jJx
         UgfAdhMBji9CUghCWW8PaGNMgcYAiaWEVGMCwygGi6u36x0Qc3x4WxPLgWAe+4kaG7Na
         D0nqhKk7hNi5cnL6R7J10qVY/pZTLySNHufpjI/rYc9oB42w/PhhltqC6ldd4kTWse2q
         qUs1J2Jp8bgWNEnE+E35mbMl0zICJRHAQ0wAaAtn8x9g9BFUW/LzDTu0gwgCLbIgcy+X
         /dj/BQ4PwwdnPEFdJhleiznOtNANYaKc6WZmD0lXuylpxN2I8j6AZfSDB5P6/dkBpE0l
         Y1+w==
Received: by 10.220.108.79 with SMTP id e15mr7393844vcp.26.1348496981818; Mon,
 24 Sep 2012 07:29:41 -0700 (PDT)
Received: by 10.58.19.73 with HTTP; Mon, 24 Sep 2012 07:29:01 -0700 (PDT)
In-Reply-To: <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com>
X-Google-Sender-Auth: GkmV2hRzO-o7FiKVMYUOfWZGhBU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206274>

There's a small glitch however: when some git command returns an error
(for example when typing 'M' for merge in main view) the main view
displays the tip of the current branch, instead of the list of
revisions passed in stdin.

2012/9/24 Jean-Baptiste Quenot <jbq@caraldi.com>:
> Yes it works great, thanks!
>
> 2012/9/16 Jonas Fonseca <fonseca@diku.dk>:
>> On Tue, Sep 11, 2012 at 3:24 PM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
>>> 2012/9/7 Jonas Fonseca <fonseca@diku.dk>:
>>>> [snip] I suggest to support something like the following:
>>>>
>>>>     tig --no-walk --stdin < tmp-file
>>>>
>>>> Would that cover your use case?
>>>
>>> That would be great!  I would then feed tig with all commits I want to
>>> see in the main view.
>>
>> When you have time, please test the main-view-with-stdin branch in
>> git://github.com/jonas/tig.git
>>
>> --
>> Jonas Fonseca
>
>
>
> --
> Jean-Baptiste Quenot



-- 
Jean-Baptiste Quenot
