From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Checking for a valid email address
Date: Fri, 27 Feb 2009 10:19:56 -0600
Message-ID: <799406d60902270819x610704a4qc93a979b2a08c918@mail.gmail.com>
References: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
	 <20090227090807.GQ4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 17:21:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld5Sr-0003lN-4X
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 17:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZB0QUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 11:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZB0QT7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 11:19:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:45577 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZB0QT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 11:19:58 -0500
Received: by gxk22 with SMTP id 22so2773535gxk.13
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UDg6D1EgArxbEjU3NiC4P7L6ETIWCekqghZOdvmIejk=;
        b=cKoM8yduq4de3SQAlJ+zJ+iqN7QGsiLpLdpVWB8jVcqsxeaTPgHAwFXu0qKymXwIvK
         7iXucP+EM0+T99vftwEnkACp7j/U+7d/fx0kFrjNBMLa2xPAB80ObxY6NY4NC3eq7rgo
         hNC5jclQQOsLhN/O06zfDG0+6WNDja6PViqK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DOLMiPE/yo3icb2TksfBwFH0DZPT1F4duPzAjBpwTIdC/PjCHvmtzlWgy64QSmMgYs
         VZ2IyhFpW7t7ENCGlSz1Yr/IZU/MA7GwN4Q91JF+JPkTTqY0X3aY2L/aPKY73WbVkFlI
         U2rd3E0f4ZmNzJyGZmiPo09zi/fEQ+04VQbKI=
Received: by 10.90.49.3 with SMTP id w3mr1373827agw.21.1235751596374; Fri, 27 
	Feb 2009 08:19:56 -0800 (PST)
In-Reply-To: <20090227090807.GQ4371@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111680>

On Fri, Feb 27, 2009 at 03:08, Miklos Vajna <vmiklos@frugalware.org> wrote:

> You can use a script like this:
>
> http://www.perl.com/CPAN/authors/Tom_Christiansen/scripts/ckaddr.gz
>
> Other helpful git commands to get the current email address:
>
> git var GIT_AUTHOR_IDENT
> git config user.name
> git config user.email
>
> You can do the rest, hopefully. :)

Thanks, thats helpful.

Cheers

Adam
