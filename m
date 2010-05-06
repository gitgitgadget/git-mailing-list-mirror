From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 16:14:10 -0600
Message-ID: <w2h600158c31005061514m1fc1e75ay9096eb27d9a1a4ba@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com> <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com> 
	<o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com> 
	<i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com> 
	<alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org> 
	<h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com> 
	<x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri May 07 00:14:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9L4-0007Nk-9w
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab0EFWOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:14:32 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47264 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab0EFWOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:14:31 -0400
Received: by yxe29 with SMTP id 29so297531yxe.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bnzKCqdfOwjKgMjWW1s74lauahMvfDIlq1FTtDLI6S4=;
        b=NjSJtWnjJhfCZjqL+NWFSDACxq4eKsSBDE+Vx124e8rcOwEBvvSjhyBw2NRSVtOa0o
         M82FS6Z0xwFSh2D6HtyyjKTJzKzNNZRmdsnjGXFP4W9q4GNRjBqg0V562+0rT8arM0ZV
         WL8xkuYMNSimGApXmr8/Y27SU2R0sU/B//bSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RYtit24EA2s7fPrDAOTwTuGxaRCEnIkbYhBm1bzQrUVL0R8HVrKSUUWc/DIulUDDod
         Rx8RE6wCEmExNVyAydx6JUdHXxNLtwe2jxlw9aKd8St0l/q4KeYiLDHMuVhbKYWcnuJP
         8yPqopSQWB3OczmyJnHmjYCHe7pB0etEq2nUM=
Received: by 10.91.50.40 with SMTP id c40mr222034agk.23.1273184070155; Thu, 06 
	May 2010 15:14:30 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Thu, 6 May 2010 15:14:10 -0700 (PDT)
In-Reply-To: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146501>

>>
>> When I'm on windows, I prefer LF (unless the project already uses
>> CRLF, or it's outside my control).
>>
>
> "When I'm on windows" leads me to believe Windows is not your primary
> operating system. If not, please excuse me.

I used to be, I only moved to linux about a year ago, but I use
windows at work, and I started using git when I was on windows.

> Open source isn't the only model for developing software.

But it's probably the most common scenario where people run into line
ending issues.

If the project is a VS project, then it's probably not multi-platform,
plus everyone at the company would be using windows anyway, so there's
no line-ending issue.

> And again... even if it were, working well together with
> visual studio support would be very beneficial for quite a bit of
> projects. Visual Studio is probably the most used code-editor among
> Windows-developers (with a good margin too, I suspect), so ignoring it
> is would just be sticking your head in the sand - or worse, asking for
> less contributions from Windows-users (which can often be a problem in
> the first place).

The problem can be avoided with a little bit of education. VS is not a
multiplatform IDE anyway
Sure, it can't work with LF endings as well as notepad++, but it's not
git's responsibility to try to fix that.

I just don't think it's a big enough issue to be built into git.

IMHO it's much better to work around the problem (if and when it
arises) by using clean and smudge filters in .gitattributes, than
having it built in and enabled by default in the msysgit installer.
