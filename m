From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: git configure script
Date: Thu, 27 Nov 2008 09:25:32 +0000
Message-ID: <e2b179460811270125r2b64fc23sdcb244de0594fbc0@mail.gmail.com>
References: <njx4p1ub7zz.fsf@cfl-sunray1.lanl.gov>
	 <vpq7i6q8azp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Matthieu Moy" <Matthieu.Moy@imag.fr>
To: "Neale T. Pickett" <neale@lanl.gov>
X-From: git-owner@vger.kernel.org Thu Nov 27 10:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5d9F-0000ZN-0x
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbYK0JZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYK0JZe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:25:34 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:27476 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYK0JZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:25:33 -0500
Received: by qw-out-2122.google.com with SMTP id 3so227219qwe.37
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 01:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fu6f6UKIuurUP47/RkN5xumVGtmFw0Me/z92g8Z/ll0=;
        b=JaNS9MZ3sZbr649Mrm6IYHynMFi5bNe6OJNdZn4z3WoW3iyKsLABG2X7IAwcNCzB1U
         GxzfDdToL5/WVa/QXqXO4atzduiwzdas9h6TAvuLpp1JiEcNaXXugLuVH9oQEFLGkR/t
         NlDtGkSYvuKMl3dKWZqSXF7JT+uapa6kABtfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pQdGUnWFpcq0jD4bPzeM3OLudAkYrVt624asvxECmBE0i2lbs9U7KUcnrHlhu2ekFS
         sf0o5OKBrSsZF5rbDM97/1QeKyOrAsFBDKdAB0FkxXHI+GNn6DLDvqkdB/gw3kCMEPLu
         oVei3CVgtwuGtp0BP4HxI+BbNuHLphnuCtDXg=
Received: by 10.214.216.4 with SMTP id o4mr6546332qag.256.1227777932161;
        Thu, 27 Nov 2008 01:25:32 -0800 (PST)
Received: by 10.215.101.13 with HTTP; Thu, 27 Nov 2008 01:25:32 -0800 (PST)
In-Reply-To: <vpq7i6q8azp.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101802>

2008/11/26 Matthieu Moy <Matthieu.Moy@imag.fr>
>
> neale@lanl.gov (Neale T. Pickett) writes:
>
> > But it installed everything in $HOME/bin and $HOME/libexec.  Looking
> > into it, it seems the shipped Makefile doesn't look to see what --prefix
> > is, despite the configure script claiming that "make install" would
> > honor this.
>
> It does, since it includes config.mak.autogen which overrides prefix
> defined in Makefile.
>
> I'm 99% sure you did something wrong. You should investigate by
> looking into config.mak.autogen after running configure.

Indeed. I believe something goes a little funny if you build as root.
Can you try again running ./configure and (g)make as a non-root user,
then only (g)make install as root / under sudo etc.

Cheers, Mike
