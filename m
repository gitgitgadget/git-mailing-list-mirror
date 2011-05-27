From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 10:01:17 -0700
Message-ID: <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org> <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 27 19:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ0QW-0000DC-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 19:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab1E0RCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 13:02:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1E0RCP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 13:02:15 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4RH2DU8007126
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 27 May 2011 10:02:14 -0700
Received: by wya21 with SMTP id 21so1402675wya.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 10:02:12 -0700 (PDT)
Received: by 10.216.79.5 with SMTP id h5mr2204682wee.110.1306515732141; Fri,
 27 May 2011 10:02:12 -0700 (PDT)
Received: by 10.216.164.195 with HTTP; Fri, 27 May 2011 10:01:17 -0700 (PDT)
In-Reply-To: <m262owhyuy.fsf@igel.home>
X-Spam-Status: No, hits=-102.931 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174631>

On Fri, May 27, 2011 at 9:50 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> Is this a gmail thing?

Gmail on the sending side - quite possibly part of a reflowing thing,
especially with quoting. I send patches as attachments because gmail
is crap in this regard (and yes, I hate it, and I go back to alpine
for any bigger issues).

But on the receiving side? Sounds unlikely, since I've used gmail for
the last year to receive patches, and this is the first time I've seen
it.

And the sent email that had the issue this time implied mutt, not gmail.

Regardless, what took me by surprise was how (a) the patch applied
fine, (b) it _looked_ fine in all the normal tools, and (c) it just
didn't work.

Now, very arguably this is not a git issue at all. Having the odd nbsp
be more visible in my other tools would have been fine - either 'less'
showing it (the way it shows other control characters) or my terminal
making some visual distinction. That said, I think it's something that
git could perhaps protect against a bit.

                    Linus
