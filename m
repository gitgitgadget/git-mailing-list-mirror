From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 17:06:14 -0500
Message-ID: <31e9dd080711151406u6df05debs56ac473977dfede3@mail.gmail.com>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
	 <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsmrD-0001f1-M8
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbXKOWGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762101AbXKOWGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:06:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:37472 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761561AbXKOWGP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 17:06:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so809998wah
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=99xL8P9bLJToyqL0MtAGVL3hXUGOFRu89Zzwbuahzvg=;
        b=VyBxp0KHk27lOkky3zOPe+qCruI2M97gMRiAy7zRCoi9XAq8U9h+upVKd+dHjOLYi4iep+brDfZAthI6tzl78RKllr0nitQP+jueFqvqlBDbHnHS0okpZSTbU9cJIs0jHsaYj61BkQcZC+lwpd7GkZhyeKDx7BN8Iyfi+W18oF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bRwxkRGIvmVvckxsouR2LS9x73yDzD09qUVTnNLlE+342fOsHAgEur6zxz30DIqxU7vn0TmgkC3WvBa5ulYdoEuoJHMxqSOpzNe7dQTz5ngk5zaPed3M1oxZTuPcNZ4eTgkWJbe6usrzhZ+JSC37Se8+SfrPWlHoSBq9RBbs4Hk=
Received: by 10.114.209.1 with SMTP id h1mr234092wag.1195164375115;
        Thu, 15 Nov 2007 14:06:15 -0800 (PST)
Received: by 10.115.76.19 with HTTP; Thu, 15 Nov 2007 14:06:14 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65170>

On Nov 15, 2007 5:01 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 15 Nov 2007, Jason Sewall wrote:
> >
> > find . -type f -exec dos2unix {} +
>
> Oops.
>
> You just ran "dos2unix" on all the *git* files!
>
> Which certainly explains why all your old objects got corrupted!
>
> > What's going on?
>
> PEBKAC ;)

Yeah, Junio beat you to it. :)

I take comfort in the fact that others have suffered far worse
consequences from find misuse....
