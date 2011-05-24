From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Tue, 24 May 2011 12:52:01 -0400
Message-ID: <BANLkTi=XbiZ0CVdwi8upnxVG26HyB9pmrg@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
	<BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
	<20110523181147.GA26035@sigill.intra.peff.net>
	<20110523201529.GA6281@sigill.intra.peff.net>
	<BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
	<20110523234131.GB10488@sigill.intra.peff.net>
	<7v39k4aeos.fsf@alter.siamese.dyndns.org>
	<4DDB5C0F.1080102@drmicha.warpmail.net>
	<7vsjs48616.fsf@alter.siamese.dyndns.org>
	<4DDBDF0C.2040708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 24 18:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuq2-0006w1-4o
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1EXQwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:52:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37255 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab1EXQwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:52:02 -0400
Received: by pvg12 with SMTP id 12so3050838pvg.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Fb5pvI9Z83mpy6ax0UxxWyV29ogwKEl3ZQ9DVH7mrkk=;
        b=l6Azbhq7Th+DWayyTazu/eZktHLm1sx1XhYxY76Jk8yNyVttdsVh7ErcPY1XmA2PAP
         1m/kRqDjw/QWljOMuqzvZHKtKLH0ZLcqQgekwHRgzpxgFzdgTTcEnQcifoM0yfSeW0wy
         Bus9wYm3lOuHsGZb9WRc/ZpAqA+z02CsSijTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=knTMSENXJlRsH/YhMj4lbeHqI91xNcGsz5YcW9PLFCteglYUo/Get2Co6zgkbBqEpG
         kPnMCCyGDbNL2H0Lvc7hPiwSICQs9srIIgpgLgvdnpB8YkOpL64Wk7ONUqLFIvhjw2cY
         GUzWjNShYZ7XK2xuNo9CFvxXQxAyPrHfVeDTg=
Received: by 10.142.225.6 with SMTP id x6mr1200749wfg.55.1306255921483; Tue,
 24 May 2011 09:52:01 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Tue, 24 May 2011 09:52:01 -0700 (PDT)
In-Reply-To: <4DDBDF0C.2040708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174332>

On Tue, May 24, 2011 at 12:38 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Well, it seemed that Jay wanted an external tool for merge diffs.

Only because I wasn't using textconv, but I should have been.

j.
