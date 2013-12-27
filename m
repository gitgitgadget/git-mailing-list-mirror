From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 20:25:16 +0600
Message-ID: <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
	<vpqwqiqpe80.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYLs-0003Pz-E0
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab3L0OZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:25:17 -0500
Received: from mail-vb0-f41.google.com ([209.85.212.41]:45315 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3L0OZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:25:16 -0500
Received: by mail-vb0-f41.google.com with SMTP id p14so4882445vbm.28
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d7DfBb7+kA3CvUbCImPyTde/HoETpkZQcyxgf1iwuJY=;
        b=HKdJhECrqY6e2l30sXakMEHE9XnGXZ91mPyrVkalbP7TcnksXSz6DH2TiSdbzbDZ5i
         voqlWBwTQrpcdw8i7q7ldBLHwxijzOwrKFpRjvKja8aHqms3OjsLcDm3vy7BRiPCAg/q
         KPh48omodP0XaQ+DCecQ/3GBwMw0Hg2zV/JqoPcdMu2r1xHUl915HUlkWlEaPABFxmZB
         vu77dtCMwXWOZZMwumFI5Z5z4toM90M7HZk7VW0PfCIc6Pdy/9iRU1PdllQSTC/0+RCu
         kQrWM5dHVtXk4h9XtgbmL0/56EoS1/jKRuRSYj8WzjS/27XWSUru1un1J3EcDohQo+Ky
         K91w==
X-Received: by 10.52.229.39 with SMTP id sn7mr21672017vdc.2.1388154316160;
 Fri, 27 Dec 2013 06:25:16 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 27 Dec 2013 06:25:16 -0800 (PST)
In-Reply-To: <vpqwqiqpe80.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239737>

Security in this case is about being sure everyone gets exactly the
same repository as stored on the server, without any modifications to
the sources cased by MITM.

As for "smart" http, this seems pretty much cool.However, we're
currently using lighthttpd, so it might be an issue. We'll check on
whether "smart" http is used there, and if not guess it wouldn't be a
big deal to switch to apache.

On Fri, Dec 27, 2013 at 8:20 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Sergey Sharybin <sergey.vfx@gmail.com> writes:
>>
>>> So guess we just need to recommend using https:// protocol instead of
>>> git:// for our users?
>>
>> Given how easy it is to verify the integrity of a git repository out of
>> band there isn't really much of added security by using TLS for
>> transport.
>
> You can verify integrity after the fact, but not guarantee
> confidentiality ... so it again depends on the definition of "security".
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
With best regards, Sergey Sharybin
