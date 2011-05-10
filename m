From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 00:30:47 +0200
Message-ID: <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com> <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvSo-0006cZ-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1EJWb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:31:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50353 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1EJWb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:31:27 -0400
Received: by qwk3 with SMTP id 3so3938987qwk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zD/1cFAZUsAdPiKprDoo3VlZ8G/2DLVHrAa6idlQkj8=;
        b=EyErWjUkjPfX79muk7v5oUhGnlGk3KESfU85XKQQzRlCzWLjCO2FVCNdhnMVs5g+t9
         CLVt0pgP8XhqfWy45YbkKSmd8X8TnDBdU/Aq3+6kTKxe9th7aF9UtTiATjd6NfUdQv/w
         UjcwagXVSVrFT6wscJKlFwUq2fqDPLHjY+CZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JbZLryi6ktz3WnaYXTVvCFGebPk+0jPLpn/A6mn8BzvumdcQKijhs0qr+JE0bPvR1l
         P8LqUbfjK/wfPTyXDh3+IcyV+Xoms9zLfL+BtDX4gqcxdIY5FU8ePW8bUZsveyYVgZtx
         67Djlqn0BJqXKBv2CEcW9Pd+sSKf1R/uz08GI=
Received: by 10.224.207.131 with SMTP id fy3mr7193381qab.89.1305066687232;
 Tue, 10 May 2011 15:31:27 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 15:30:47 -0700 (PDT)
In-Reply-To: <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173376>

Heya,

On Wed, May 11, 2011 at 00:20, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
> So, sounds like most people agree with me. What should we do for this
> to happen? propose a patch?

Yes, write a patch that adds a --reverse flag, off by default, (or
something like that), possibly with a config flag.

-- 
Cheers,

Sverre Rabbelier
