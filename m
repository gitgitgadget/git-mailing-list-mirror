From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 05:25:06 -0500
Message-ID: <CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 12:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPoD-0001bK-PO
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 12:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab3IXKZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 06:25:09 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:47691 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab3IXKZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 06:25:08 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so3464924lab.35
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AyuNEmovWyhwW7O6eh4aeCfbmLNKibHK/kyNpuycXt4=;
        b=R6NCzH+DAdVACvS4vmo3nPtTkwJtwX5LCfM+4UcJXY872XSfwxmIFl8EvxXCD711F/
         FtCgAoF4nGKR8NO/6qPA8OdWRJY0wScZxlyttzfo36pry1iPDg2HyzqRD0BIntSR+dre
         i9jQhdAp/CylkVoXom4PjCNsUv1bQbPrlm8r4m5u0ulwFAAEGH6O/1T7CycJkZJTGIHS
         OT0XT9th5Gf6xPR1ro2gU3ZvRqJXecpsndGCkv6Zfqu27yjnnr2aMZX3FooAs0/PPFTI
         b2j71fqAmCp5+s0aNp+3gEo1+nNCehGPtgptBSF1agp5203TgiGSBQ7oloSmCyU1Tmwz
         5rUQ==
X-Received: by 10.112.53.130 with SMTP id b2mr23908582lbp.6.1380018306712;
 Tue, 24 Sep 2013 03:25:06 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Tue, 24 Sep 2013 03:25:06 -0700 (PDT)
In-Reply-To: <CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235299>

On Tue, Sep 24, 2013 at 4:19 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Sat, Sep 21, 2013 at 3:20 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> For now simply add a few common aliases.
>>
>>   co = checkout
>>   ci = commit
>>   rb = rebase
>>   st = status
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> I still think we should ship a default /etc/gitconfig, but the project needs to
>> agree it's a good change, and nobody every agrees changes are good. So this is
>> the minimal change that achieves the desired result.
>
> I wish you would stop attacking the project every time you send a
> patch--it's simply not productive and it's certainly not getting you
> any closer to a resolution.

I'm not attacking the project, I'm making an objective claim, and I
can back it up with several instances of evidence where 99% of the
users would benefit from a change, yet it does not move forward.

If you don't agree my comment is accurate, that's one thing, but
labeling it as an attack is another.

I would admit I was wrong if an /etc/gitconfig is indeed shipped by
default, and agree that the Git project is indeed welcome to change,
but that's not going to happen.

-- 
Felipe Contreras
