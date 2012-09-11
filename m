From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Tue, 11 Sep 2012 21:24:12 +0200
Message-ID: <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Sep 11 21:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBW51-0007AI-Ao
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 21:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759995Ab2IKTYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 15:24:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34290 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab2IKTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 15:24:54 -0400
Received: by ieje11 with SMTP id e11so1530222iej.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=EEvbusdd1zKXDa0UyL1HxwA6r/ymyiHaj3kQtkCmLfA=;
        b=tdYv2oMtNNrUQS/d8CkQaOcRWTuWNBlowAvGNebzcs3h3Jg9+KJIFTf44qgits87kC
         oHPv9tV7n8Go+h9ODrNTpuP/B37Zm7KdZi8Kr+WeLvtmEttvTw9tq+6jir/iL1WEcchx
         ykxEEk5Ds8fwEXaIUHpoHDbyGL6DMyFEn8cmK12DV2BzYV9O9Nw5TAVioBBKXe5fWOK5
         lueYxBs2zX0govSd+WKhlAeisFKXGnsgz0fXMd8LSDqpqx3JQnRwVZQgDsaBOHMPUlGM
         KgyB39D4o+yzdk9wWfU3n+NtNJse6UMafzbBChS05p+bkUS77Cuzo2Moanyn1KRgx7ZH
         WTLA==
Received: by 10.50.180.129 with SMTP id do1mr18249730igc.28.1347391493181;
 Tue, 11 Sep 2012 12:24:53 -0700 (PDT)
Received: by 10.43.103.4 with HTTP; Tue, 11 Sep 2012 12:24:12 -0700 (PDT)
In-Reply-To: <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
X-Google-Sender-Auth: 6B-hBZqVDWRaIu2k7J1_Rk_QbhI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205259>

2012/9/7 Jonas Fonseca <fonseca@diku.dk>:
> On Fri, Sep 7, 2012 at 9:41 AM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
>> Hi Jonas,
>
> Hello Jean-Baptiste
>
>> With tig 1.0 how to feed specific revisions to the main view?
>>
>> The following hack worked until tig 0.17:
>>
>> [alias]
>>         tignowalk-helper = !git rev-list --pretty=raw --no-walk --stdin<
>>
>> TIG_MAIN_CMD="git tignowalk-helper $tmp" tig </dev/tty
>
> The possibility to specify commands was removed in favor of improving
> options given on the command line. In this spirit, I suggest to
> support something like the following:
>
>     tig --no-walk --stdin < tmp-file
>
> Would that cover your use case?

That would be great!  I would then feed tig with all commits I want to
see in the main view.

Cheers,
-- 
Jean-Baptiste Quenot
