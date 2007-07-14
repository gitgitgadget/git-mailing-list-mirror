From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: Confusing language in man page
Date: Sun, 15 Jul 2007 01:57:52 +0530
Message-ID: <a781481a0707141327k5b6f8f43sc6330ff8cc504dd1@mail.gmail.com>
References: <a781481a0707141108g4664a627w94e0d21c3629cb49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 22:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9oDc-0000qS-Oe
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760989AbXGNU1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762325AbXGNU1y
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:27:54 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:33129 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760989AbXGNU1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:27:53 -0400
Received: by py-out-1112.google.com with SMTP id d32so1504372pye
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 13:27:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AzUq2awgTH3uRXwD/kpRwN0jtSrDMte2P19pDWH/0OLJly5IRHXo80ccQ9RmH9LEPX4stYA0m448b6EhFZel8Z/Tij/JPZuXSxIsDgDxEsujnj7AoxNVC3wfCHYSvFJ7Cl+1ib5YNKmhcZru5i1k0sOblqKIDFcVxA8mBCP0KE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BKqQLeKnq1aC5orw1tsFvcu4TXQoO4bEZOqiU9iFnrubJaVsaMdQ0mLKGAs0fWKi7lAywIw4aX1ltC31cMGz22HEVwHhXaQNBKX/L2l22LcZtQ0Jm+C1SfvNcx0Bg1kRVboxv0OvJCELr+IdYkFGBgfXvOG3RrqTqxhu4WqbkYM=
Received: by 10.142.187.2 with SMTP id k2mr214534wff.1184444872172;
        Sat, 14 Jul 2007 13:27:52 -0700 (PDT)
Received: by 10.142.83.19 with HTTP; Sat, 14 Jul 2007 13:27:52 -0700 (PDT)
In-Reply-To: <a781481a0707141108g4664a627w94e0d21c3629cb49@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52505>

On 7/14/07, Satyam Sharma <satyam.sharma@gmail.com> wrote:
> Hi,
>
> [ I'm using Fedora's latest package. ]

I should probably clarify:

$ git --version
git version 1.5.0.6

Perhaps man pages / functionality have been updated significantly
since that, so let me know if that's the case.

> From git-checkout(1) and git-branch(1):
>
> -l     Create the new branch's ref log. This activates recording of
> all changes to made the
>        branch ref, enabling use of date
>
> I'd be glad if someone could explain that a bit more verbosely
> in the man page
> (or just here in a reply), or at least make that grammatically
> correct/readable :-)

Ok, another confusion I hit (as I learn more about git) tonight:

* What exactly is the use of git-diff's "-p" option?

$ git diff

and

$ git diff -p

produce the same output / do the same thing -- the man page mentions
"Generate patch (see section on generating patches)" but I couldn't find
said section (is that referring to some other man page?)

* On my system, doing:

$ git diff

with no outstanding changes in my current working tree produces some
bogus newlines, throwing the prompt to the bottom of the xterm window.
This sounds like weird / undesirable behaviour and I have a feeling must
already be fixed in latest git (?)

Thanks,
Satyam
