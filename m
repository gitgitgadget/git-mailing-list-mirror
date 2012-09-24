From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Mon, 24 Sep 2012 16:57:00 +0200
Message-ID: <CAK6bCazoVPSmyGtU_7qWTZpfnmVikkZa1zAz9S02OwFN0qh1dg@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
 <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
 <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
 <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com> <CAK6bCazQvYP8dgQzF5BY5+UNfGvm_SOcrVZoREdpszyrHOjEuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGA6Z-0001Y0-NK
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab2IXO5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:57:43 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56041 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab2IXO5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:57:42 -0400
Received: by vbbff1 with SMTP id ff1so6200113vbb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=LdoZXVNkMt1UtA8PMYrsyS/I9kjMIIHbjcIQk0ZhZpg=;
        b=jhvB/vJ4vK8/GoxwP70Phd8y1byJgAcXGXBSASkuTlhbeqH2iDGwlUFH2+VNnPt6nT
         J4qswpvu6BhqeZJrMkfm6agl18bMqc1eJafqoU6yjWa5CrT1zcLYUKLh/UpA1d98ss1o
         PZ5Y1rNfIaolN2qiMcuw7jdY50j8drvA30VcfR9QcsSNFY2Oo8rygt5OS9+je099x8s5
         ZlWDOme37YZBgxb7Ibwnti9V3liatC7ZoYCc9FjBOZfD68q24g0RS9qDVTv2ffPITnf4
         qV6FmQKRoSQGpptizDSslzNebOkYRyVYCGPVEsSxxrnGhiEHGCncZ77g3fMX2Y6DZZS5
         o28g==
Received: by 10.221.10.81 with SMTP id oz17mr7457996vcb.67.1348498661659; Mon,
 24 Sep 2012 07:57:41 -0700 (PDT)
Received: by 10.58.19.73 with HTTP; Mon, 24 Sep 2012 07:57:00 -0700 (PDT)
In-Reply-To: <CAK6bCazQvYP8dgQzF5BY5+UNfGvm_SOcrVZoREdpszyrHOjEuQ@mail.gmail.com>
X-Google-Sender-Auth: r7UtJ78T9WZQXKtIupSoM3PPYog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206281>

This actually happens everytime I run a git command with a key
binding, be it successful or not.  The main view is restored to the
tip of the current branch.

2012/9/24 Jean-Baptiste Quenot <jbq@caraldi.com>:
> There's a small glitch however: when some git command returns an error
> (for example when typing 'M' for merge in main view) the main view
> displays the tip of the current branch, instead of the list of
> revisions passed in stdin.
>
> 2012/9/24 Jean-Baptiste Quenot <jbq@caraldi.com>:
>> Yes it works great, thanks!
>>
>> 2012/9/16 Jonas Fonseca <fonseca@diku.dk>:
>>> On Tue, Sep 11, 2012 at 3:24 PM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
>>>> 2012/9/7 Jonas Fonseca <fonseca@diku.dk>:
>>>>> [snip] I suggest to support something like the following:
>>>>>
>>>>>     tig --no-walk --stdin < tmp-file
>>>>>
>>>>> Would that cover your use case?
>>>>
>>>> That would be great!  I would then feed tig with all commits I want to
>>>> see in the main view.
>>>
>>> When you have time, please test the main-view-with-stdin branch in
>>> git://github.com/jonas/tig.git
>>>
>>> --
>>> Jonas Fonseca
>>
>>
>>
>> --
>> Jean-Baptiste Quenot
>
>
>
> --
> Jean-Baptiste Quenot



-- 
Jean-Baptiste Quenot
