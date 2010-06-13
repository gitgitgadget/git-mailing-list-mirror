From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: github:FI
Date: Sun, 13 Jun 2010 15:14:48 +0000
Message-ID: <AANLkTil5hze7Sx80G1byy-gJx934RpeLiB0cv_oep3zL@mail.gmail.com>
References: <AANLkTin838fW6L0W1P__seKnIZi58QtdQzgmUFFQTJC2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 17:14:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONotj-0005qo-6M
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 17:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab0FMPOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 11:14:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47287 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab0FMPOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 11:14:49 -0400
Received: by iwn9 with SMTP id 9so2329361iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9Z15pnxg1EMvFuboR/v5apO8CWEJbvnCO/BTa9sS4NI=;
        b=NfMrO0FsU0l6PYExd+onBTn/a0oBYx0NSgGu1nbvPvCChzktLp1exjSmdvnYDi22vD
         Z4tCzZmrql4lFrWpmVjpLmS1jh7cG4diGX+df8/aZ89Zb60EK97Pkw1GbmzQYlyzrWEQ
         WjfTn9tyQxASsVTBp5vZ5LdzRRgJZA8a2BuvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iWJDdwqSRqrHbYo6zzVYzmUuEj7ZQKZI7Mg2zz94VPoEISJz3pzw26cQEZawpoMmOk
         /0J/EhXR40vcc4yE4VXAp5QGNcRScsn8fcJYWFW/I77aRzpsEc22egJk1T8zz1dXmT9s
         wCYmI25HZkVUVHW0lCmNzsD/qcqDbNtpP6utM=
Received: by 10.231.59.199 with SMTP id m7mr4800714ibh.30.1276442088657; Sun, 
	13 Jun 2010 08:14:48 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Sun, 13 Jun 2010 08:14:48 -0700 (PDT)
In-Reply-To: <AANLkTin838fW6L0W1P__seKnIZi58QtdQzgmUFFQTJC2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149051>

On Sun, Jun 13, 2010 at 14:28, Mahesh Vaidya <forvaidya@gmail.com> wrote:
> I am exploring git hosting options and web interfaces. I have
> implemented my own system based on gitweb, git, gitosis and gitstat.
> I'm exploring github:FI
>
> If anyone knows is it worth the price. we have@100 users; so we are
> looking at $1000 * 100

I use GitHub but I've never tried github:fi, and I'm not the target
audience.

I've heard from some people that have reviewed it from their corporate
deployments, and the typical process seems to be 1) Oh an internal
GitHub would be nice 2) It costs WHAT!.

Here's some issues that were noted when pobox was looking at it, I
think they eventually went with some gitweb + fork support kind of
thing:

    http://gist.github.com/309320

GitHub has a really nice UI, but a startup cost of a $100k for a 100
man company seems like a lot to fork out for that, when you can get
away with using e.g. gitorious or a gitweb setup with some
customization.
