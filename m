From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 8 Sep 2011 14:13:49 +0530
Message-ID: <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 10:44:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1aDb-0002hz-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 10:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab1IHIoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 04:44:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43051 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab1IHIoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 04:44:10 -0400
Received: by wwf5 with SMTP id 5so617574wwf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rvOAC89UpJ/irfTJX+4JiqOYHwAG8oevAagNt/oqI9U=;
        b=KJjSThz/J1jXwPDDqqLL1EK6FbDxlT5V35EQl5d2wWMwxmcT/MWHUamv7YoKqwGCBJ
         Tc+dIy4UQXVo5N6dp8gCkuVwLe8IR66PYm/aX3iaWxvaimp1vJzO15U/or0MjSQexVs/
         IABUW3/C1lzJNHCftgfKCB72dl3iCv9+8ASNk=
Received: by 10.216.205.169 with SMTP id j41mr412287weo.89.1315471449622; Thu,
 08 Sep 2011 01:44:09 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Thu, 8 Sep 2011 01:43:49 -0700 (PDT)
In-Reply-To: <1315428191-9769-1-git-send-email-gf@unixsol.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180952>

Hi Georgi,

Georgi Chorbadzhiyski writes:
> Sometimes when sending lots of changes it is not nice
> to send emails as fast as possible. Of course you can
> confirm each email after waiting couple of seconds but
> this is not optimal. This patch adds --sleep option
> to git-send-mail and corresponding sendmail.sleep config
> variable to control how much seconds to wait between
> sending each email. The default is 0 (not wait at all).

I use git-send-email a lot, and I ask it to print out the list of all
emails once before confirming.  After confirming, I just switch back
to Emacs and continue work- in the many instances, I've never actually
needed to slow the process down.  If anything, I wished it could
concurrently send many emails and do things /faster/ *.   I'm a little
curious about why you want to slow it down- is your SMTP server
configured to block you because it suspects that you're trying to
spam?

Thanks.

* I first need to see if SMTP servers today can take in emails at this
speed without suspecting spam.

-- Ram
