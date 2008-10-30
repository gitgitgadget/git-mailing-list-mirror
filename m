From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: request for pre-generated git.info pages
Date: Thu, 30 Oct 2008 09:06:35 +0000
Message-ID: <e2b179460810300206g79e06c63m2060092fa654b18b@mail.gmail.com>
References: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: SLONIK.AZ@gmail.com, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 10:07:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvTVP-00048z-Lb
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 10:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYJ3JGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYJ3JGi
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 05:06:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:14664 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYJ3JGg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 05:06:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so476091rvb.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Gmotn4+E2u6Xsw0Iiix3QKwltpaHenax7hU7WPc4qdQ=;
        b=S80YRYFVzN1O4e2MO/71ZVGvO2H/Uj29SO1ByTi8BJvZm/TASoOh4g4CssXmFoVUUt
         BG9DEVP90WUwdgD+nzoCes11m9QyC6a9C4hLBWSK17jNcOw4a1B603Sr8swIHiWGTZ4Y
         BnusBZFgr/nmwzWk8wgU1qXVlwnaSM+BHOyS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jREfkpiKB7L6bit6hR57mzPKdNzWs9Fle+FWDS01QxJsTILKYywQ50vDVCW0KBbJPu
         RhoTBrDqKAPGMpkSNSMkVONVlvd4P1GE4uutHwZmwVAWAiQ+FA0eKorU+pLNzBdwlWa/
         buIKGiNXwdinY5sT9kH1wCksW8mGY36mHU7u4=
Received: by 10.141.36.10 with SMTP id o10mr5497489rvj.176.1225357595587;
        Thu, 30 Oct 2008 02:06:35 -0700 (PDT)
Received: by 10.141.52.18 with HTTP; Thu, 30 Oct 2008 02:06:35 -0700 (PDT)
In-Reply-To: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99449>

2008/10/29 Leo Razoumov <slonik.az@gmail.com>:
> I am an emacs user but with my current setup I have difficulties
> generating git.info pages. Main Git repo already provides
> pre-generated man and html  documentation in "man" and "html"
> branches. I would kindly beg to extend this privilege to "info" pages
> to benefit all the emacs users out there.

Unfortunately I don't have a working asciidoc etc toolchain either
(though I will take a look at getting it working on my central git box
which is Linux based). As I'm not an emacs or Info user I probably
wouldn't know if they were building correctly anyway.

However, if anyone can do the above, I'll be happy to help them get
set up to push an 'info' branch to gitbuild.git
(http://repo.or.cz/w/git/gitbuild.git).

How often would you want the info pages rebuilt? Just the versions
which Junio tags? Or would you only want them built from one branch
(e.g. maint)?

Mike
