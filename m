From: Li Hong <lihong.hi@gmail.com>
Subject: Re: [RFC] 'git cat-file' needs a better design on its option 
	interface
Date: Fri, 25 Sep 2009 10:33:21 +0800
Message-ID: <3a3680030909241933g5ac48496ic9673030de81898c@mail.gmail.com>
References: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
	 <alpine.LFD.2.01.0909241021120.3303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 04:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr0cv-0001S9-OY
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 04:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbZIYCdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 22:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbZIYCdS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 22:33:18 -0400
Received: from mail-yx0-f173.google.com ([209.85.210.173]:53175 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbZIYCdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 22:33:18 -0400
Received: by yxe3 with SMTP id 3so165883yxe.4
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R1FcI6i2O03b3s9LBsXVj2gBiJbEii0tG8DENZ5QpIw=;
        b=yGGbARarjduPcyEh6opM9K1sy4o/BMRMq1j0njH4n4SdsYcD/O9NAHc2cCwQdRaOw4
         IyTL0GXU6ORi+r0b9YS+Gt/cTpI7cBg1d7qPsK3f1/txM5/21e4HzH1WXPAWxXM0XQZ0
         GyQenvwKE17QS+oqxGz+z+4jfdw2sPX6kEpF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ra1ipTPeO/xLbP0jDNfdI+7tkjwPQ8UJNAN89sId8XfNp6m5nvtoTtozD5bB1ga3AV
         av9Jej+uAYb7Rj9oYamZYM4N90Tsws+SZ1snN2sfWHnUw3PSrxUi3EHIoyzZfhuCXuVk
         53jdyggqnIh+nk7at4NFApjmJaJFqOnpn+KOY=
Received: by 10.101.98.9 with SMTP id a9mr5173500anm.160.1253846001936; Thu, 
	24 Sep 2009 19:33:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0909241021120.3303@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129060>

2009/9/25 Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Thu, 24 Sep 2009, Li Hong wrote:
>>
>> When using 'git cat-file' recently, I find its option interface is s=
omewhat
>> inconvenient or mistakenly-designed.
>
> You likely shouldn't use 'cat-file' at all. Have you looked at 'git s=
how'?
> That's the command meant for human beings.
>
> 'git cat-file' is really really low-level plumbing. Humans should
> generally never use it. It's one of the original git commands (it was
> literally in the original git commit), and it does some really low-le=
vel
> stuff that is good for scripting but not for any normal use.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>

Yes, I know 'git show' and use it mostly. I just think the interface
of 'cat-file'
is not well designed even used by other scripts or porcelains. But from=
 another
respect, it doesn't really annoy normal users much and we should retain
backwards compatibility. So I give up.

Thanks for all your feedbacks.

-Li Hong
