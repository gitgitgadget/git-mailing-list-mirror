From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: support mixing --sort=<spec> and -n
Date: Sat, 05 Sep 2015 21:38:50 -0700
Message-ID: <xmqqoahgb1r9.fsf@gitster.mtv.corp.google.com>
References: <20150905175202.GC7050@zero.home>
	<CA+P7+xo=4mC0fKkbtL+fkMXGxdUNcdUGUYHdaJ58MF9jVUUziw@mail.gmail.com>
	<CAOLa=ZTiG8aMdURDYTHALGfhkg_YWe6bXEmPUySgGBrrQXD+Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Rudy Matela <rudy@matela.com.br>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 06:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYRjF-0005cW-7R
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 06:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbbIFEix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 00:38:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33431 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbIFEiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 00:38:52 -0400
Received: by pacex6 with SMTP id ex6so62673934pac.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kWxbovYUwwW8MWXSuK6VH0SVgc0Jo/juwokvFFwt6+Q=;
        b=s3Ckm71mvhej7oz+RJXWe4xB8osO6Qo18ka9NXTilaEq7oZHeJOhNWqKMaB3auWY1G
         K03YsCOo/gSm1vJSpttVsI+Tl+FLM/EzaScq3MrIRevm2Ni8qeajJ/FsfdckgBgSS0ow
         IepJjTyt6r2FjFVS0XOh4BtT8cVY1SQqK7xYOiVaJ4NjKRxOp80mzp2JndPEbEXn90Hh
         T2iNMS43hfT5dWe3mt0hCydk6ssZ6XD4ftHCFmG/z2RdGiQfgK3VFumdnVhjIOVvx3nK
         pgNWyu6a3I+r5RJQGVVVAJcZTSWLVswwMMUz5kVxUx5l0p0mS30jXIwoUEe+iS+qG8xF
         HeiA==
X-Received: by 10.68.231.5 with SMTP id tc5mr29260708pbc.54.1441514331900;
        Sat, 05 Sep 2015 21:38:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id s6sm7443902pdj.62.2015.09.05.21.38.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 21:38:51 -0700 (PDT)
In-Reply-To: <CAOLa=ZTiG8aMdURDYTHALGfhkg_YWe6bXEmPUySgGBrrQXD+Nw@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 6 Sep 2015 09:22:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277414>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Sun, Sep 6, 2015 at 3:55 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Sat, Sep 5, 2015 at 10:52 AM, Rudy Matela <rudy@matela.com.br> wrote:
>>>
>>> Allow -n and --sort=version:refname to be used together
>>> instead of failing with:
>>>
>>>   fatal: --sort and -n are incompatible
>>>
>>> Signed-off-by: Rudy Matela <rudy@matela.com.br>
>>
>> Nice! I've been wondering about this one for a while. Especially since
>> implementing tag.sort configuration which made -n not work at all.
>>
>> Note that it may be worth rebasing this on top of Karthik's part tag
>> to use ref-filter series, since I think there will be plenty of merge
>> conflicts there...
>
> Its already resolved in my series. We use ref-filter's sorting APIs
> there :)

I guess Jacob needs to rebase that tag.sort thing on top of yours,
then ;-)?
