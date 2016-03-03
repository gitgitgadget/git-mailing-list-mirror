From: Martine Lenders <mlenders@riot-os.org>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 3 Mar 2016 17:48:18 +0100
Message-ID: <CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan>
	<CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
	<vpq1t7rlfi1.fsf@anie.imag.fr>
Reply-To: authmillenon@riot-os.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, authmillenon@riot-os.org,
	John Keeping <john@keeping.me.uk>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 17:48:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWQO-0003DR-HU
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 17:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbcCCQsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 11:48:24 -0500
Received: from aquarius.uberspace.de ([95.143.172.114]:59785 "EHLO
	aquarius.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbcCCQsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 11:48:23 -0500
Received: (qmail 10077 invoked from network); 3 Mar 2016 16:48:20 -0000
Received: from localhost (HELO mail-wm0-f45.google.com) (127.0.0.1)
  by aquarius.uberspace.de with SMTP; 3 Mar 2016 16:48:20 -0000
Received: by mail-wm0-f45.google.com with SMTP id l68so43473010wml.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 08:48:20 -0800 (PST)
X-Gm-Message-State: AD7BkJLisZ7Cd2XBZjT0bg//yrJvP+n6xJVel8zYqvZTogFmBNeLxAvrjdoPTCRmZTpJEKaC+1Kw7DNCLw1dYQ==
X-Received: by 10.28.130.67 with SMTP id e64mr79061wmd.6.1457023698752; Thu,
 03 Mar 2016 08:48:18 -0800 (PST)
Received: by 10.194.103.228 with HTTP; Thu, 3 Mar 2016 08:48:18 -0800 (PST)
In-Reply-To: <vpq1t7rlfi1.fsf@anie.imag.fr>
X-Gmail-Original-Message-ID: <CALHmdRwZCb7LnQcKkdy-wNx5Ree+FcMPz2ykqVnTTq_SPDR_HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288189>

> [ Please, don't top-post on this list ]

Sorry (*^.^*)

> It won't match if you put it in the subject line, but John's proposal is
to put it at the bottom (i.e. in the body). This won't disturb "git
rebase --autosquash".

For some reason I did not even consider the bottom. Tried and it
works! Thanks! I will integrate this into my workflow (and try to get
other contributors to our project to do the same).

>> Maybe another approach could be to allow for a configuration of a
>> string that is ignored when matching the commit messages in `git
>> rebase`.
>
> I wish I could write commit messages like
>
> fixup! deadbeef: fix typo (foo -> bar)
>
> So that the commit message contains both the instruction for "rebase
> --autosquash" and a quick explanation of what the commit is doing (as
> usual commit messages).
>
> AFAIK, it's not possible currently but shouldn't be hard to implement.

I would love that, too :-). This differs however from the original
intent of my feature request. So maybe we finish this thread (since my
John's proposal is 100% sufficient for me in that regard) and open a
new one? How are the procedures for this on this list?

Regards,
Martine
