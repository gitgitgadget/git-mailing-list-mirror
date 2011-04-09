From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: New to git
Date: Sat, 9 Apr 2011 23:35:22 +0400
Message-ID: <BANLkTi=tU8vYMoD9bM9z6fy19OX40FLK=A@mail.gmail.com>
References: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
	<20110408201024.GA15964@sigill.intra.peff.net>
	<BANLkTikCF7Kv2xVYmr3O_P2t1TAzEFxXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Marco Maggesi <marco.maggesi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 21:35:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8dwN-0004HZ-W3
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 21:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab1DITfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 15:35:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57195 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab1DITfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 15:35:22 -0400
Received: by qwk3 with SMTP id 3so2631803qwk.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T+uXrksJoS20GmfD84b5A0npTi4FuYHaLceahmJ7JIA=;
        b=dYlRvaeFCFBZUG+BKw8cSafTpPWdnTq23ek7hs3IgirAfBqGOeiDY+HuaGoQSpTUyk
         0ZdzsU+bkKLXs8p4NHNkWzC/pGiD+8/7OBKW+8Bkuebx5UzFdO2wyWAcDOW66M69le07
         fTIZOGHb7WxVCMtLqptAh7PpnMPhgHUbyH4qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DuNnSMVNZk11HRm6lsxD2nJQvtuaLjqc/gNhcrxDsLuUmxtU/Dbf9S0uzGrfTWWLdN
         Mqr6ggxpkGtPfOjAodNw9//95FFdAmj5Y1I8bVk0Xobl2+ADS1pvtg6IR5uVgzFBI3R0
         yXyRlkBJ63yWxERY4MDyQilWCYZjvvNVqFpJk=
Received: by 10.229.46.140 with SMTP id j12mr2844453qcf.192.1302377722083;
 Sat, 09 Apr 2011 12:35:22 -0700 (PDT)
Received: by 10.229.241.201 with HTTP; Sat, 9 Apr 2011 12:35:22 -0700 (PDT)
In-Reply-To: <BANLkTikCF7Kv2xVYmr3O_P2t1TAzEFxXiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171205>

On Sat, Apr 9, 2011 at 11:15 PM, Marco Maggesi <marco.maggesi@gmail.com> wrote:
>
> Well, the server is a very old machine and I didn't find easy to
> compile git on it because of many missing dependencies (but I didn't
> try very hard either).

Some time ago, I built git on an old machine running Linux (RedHat 8.0
but maybe some packages were upgraded). Here is the line that I used:

make NO_OPENSSL=1 NO_NSEC=1 NO_CURL=1 NO_TCLTK=1 NO_PYTHON=1

I needed git only to push and fetch to that repository, and it worked
well for me.

Dmitry
