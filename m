From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: support mixing --sort=<spec> and -n
Date: Sun, 6 Sep 2015 09:22:36 +0530
Message-ID: <CAOLa=ZTiG8aMdURDYTHALGfhkg_YWe6bXEmPUySgGBrrQXD+Nw@mail.gmail.com>
References: <20150905175202.GC7050@zero.home> <CA+P7+xo=4mC0fKkbtL+fkMXGxdUNcdUGUYHdaJ58MF9jVUUziw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rudy Matela <rudy@matela.com.br>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 05:53:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYR0z-0003ax-Tw
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 05:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbbIFDxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 23:53:10 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36341 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbIFDxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 23:53:07 -0400
Received: by obqa2 with SMTP id a2so42381606obq.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Hia3rWjbBxUal2pun8F6RVPslt/BxSTt6biszRnSFU=;
        b=FyCSDT5npc01SRPJbObHf/oI5tmNeXAq71VX3T86pkKiNo9aW2kLznQkBHOWtsBhxw
         Kt/G0QEAMaQDq2x/GV9fPACXztKZqaF0SpIdbUfx2F9yYqtolURX47wM18x4RiCWi6VJ
         +fNrrUYlpNz63AClr5UAfiD1kparJyIgWrxbgKg1mmCM6DZNYqClGb7IayZpujOX1NIv
         XtGddMAt0cgC9e6Q+5ly7nP2dqmCFGiHGadxPxwofGowbBDNqxgqgmwiLa6MDDMeV4DT
         tVxkqi1UFEM7eu408z2p1f462MEUQG68o/GBrO3tSgAk0MZoEFGOcjBdZOaUoj5IvKkU
         FnAA==
X-Received: by 10.60.92.199 with SMTP id co7mr9599331oeb.37.1441511585772;
 Sat, 05 Sep 2015 20:53:05 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 5 Sep 2015 20:52:36 -0700 (PDT)
In-Reply-To: <CA+P7+xo=4mC0fKkbtL+fkMXGxdUNcdUGUYHdaJ58MF9jVUUziw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277413>

On Sun, Sep 6, 2015 at 3:55 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Sep 5, 2015 at 10:52 AM, Rudy Matela <rudy@matela.com.br> wrote:
>>
>> Allow -n and --sort=version:refname to be used together
>> instead of failing with:
>>
>>   fatal: --sort and -n are incompatible
>>
>> Signed-off-by: Rudy Matela <rudy@matela.com.br>
>
> Nice! I've been wondering about this one for a while. Especially since
> implementing tag.sort configuration which made -n not work at all.
>
> Note that it may be worth rebasing this on top of Karthik's part tag
> to use ref-filter series, since I think there will be plenty of merge
> conflicts there...
>

Its already resolved in my series. We use ref-filter's sorting APIs
there :)

-- 
Regards,
Karthik Nayak
