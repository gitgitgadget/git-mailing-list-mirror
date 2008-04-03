From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: "make test" fails if /path/to/git.git contains spaces
Date: Wed, 2 Apr 2008 22:26:18 -0400
Message-ID: <3e8340490804021926pa0dc516r85c41c068aea01a8@mail.gmail.com>
References: <47F15CDB.60109@apple.com>
	 <3e8340490803311604v52ab9e03nd101ccadd4973760@mail.gmail.com>
	 <47F1D666.9060402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Adam Roben" <aroben@apple.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 04:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhFAQ-0006vJ-2D
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 04:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758800AbYDCC0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 22:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758661AbYDCC0W
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 22:26:22 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:8041 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618AbYDCC0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 22:26:21 -0400
Received: by mu-out-0910.google.com with SMTP id i10so4442646mue.5
        for <git@vger.kernel.org>; Wed, 02 Apr 2008 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wq7SB8LIXwwxFSjZhoRGUy5Z3/4YKwY98PrJbS6axdg=;
        b=tALcDZYGY+MftTT2GDeP0fF1O+XfE9vHAGLbUw0I/vnEeQNBKSLoI9A7Q/u0+10Zbqcv+BoxWTGgySsS6flYr3Xg3/u+2DVu/m+RPWsXKslDchpQQJxjMXku2FTaQAJVfvv/bN1DhRdS2FB9d56lh0Nr/fSKw+H2Ks2A5azMxsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZpBQyJQgSkDmE7Sj5K4iwrxi6BqJwQoAKB6/la5B39/75P4EXY5VJIwOFHrZZa5Ns4XsCfS4oz2FMkf52r1YLHvHpPfMN9VIX3x9kwBzgPC4U5eCwuBeRWIa1aL/ItmeCY7gzeITU8B2b7PJ+t76LPHXMpppMWN9zoAcdvCkUbk=
Received: by 10.65.225.7 with SMTP id c7mr4007264qbr.1.1207189578568;
        Wed, 02 Apr 2008 19:26:18 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Wed, 2 Apr 2008 19:26:18 -0700 (PDT)
In-Reply-To: <47F1D666.9060402@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78723>

On Tue, Apr 1, 2008 at 2:29 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Bryan Donlan schrieb:
>
> > On Mon, Mar 31, 2008 at 5:51 PM, Adam Roben <aroben@apple.com> wrote:
>
> >>  Do we want to support having spaces in your path? It doesn't seem hard
>  >>  to fix, but it does seem like the kind of problem that will come up over
>  >>  and over again if only a very small set of people have this configuration.
>  >
>  > Turns out that while trying to fix the tests, I've found that
>  > git-rebase doesn't like a $VISUAL having spaces, so perhaps this
>  > should be tested more often :) Or should we just require $VISUAL have
>  > no spaces?
>  >
>  > I'll send a patch once I've got everything passing.
>
>  There was an attempt in the past to make this working. Please look at this
>  (rather lengthy) thread, in particular, my critique on the patches that
>  were submitted:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/60544
>
>  I really would not like to see the same issues that I took the time to
>  comment on to show up again.

Thanks for the advice, I'll try not to make the same mistakes :)
I've found a few legitimate bugs as I've been updating the tests, so
I'd call this a worthwhile endeavour. I'll send the fixes in question
as broken-out patches in the final patch series.

Even if tests with space-ridden paths aren't run /often/, it'd still
be a good idea to fix them when they're noticed as broken, IMO. (I'm
currently testing with quotes and backslashes, too, now :)

Thanks,

Bryan
