From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PULL] Pull request from msysGit
Date: Thu, 7 Oct 2010 22:22:48 +0200
Message-ID: <AANLkTimYywBtG-tD-aV6uDK+HPerDHqaJyt1Sx4tOXJT@mail.gmail.com>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk> <4CAE00C5.1050509@ramsay1.demon.co.uk>
 <4CAE1FE6.9020306@opentext.com> <AANLkTinSjFDdwqTEU6XzOVHupph0G2ZKM+u3r7t_W3DD@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Harris <pharris@opentext.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, sschuberth@gmail.com
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3wzx-0003wE-Lg
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0JGUXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 16:23:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43141 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab0JGUXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 16:23:17 -0400
Received: by qwf7 with SMTP id 7so236977qwf.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=im2URXvoLJEHbNtz2VitWsnDw14ELRopOn2OIMff+3k=;
        b=cr5wHZZwZ7T/P5Suq/ZZe4/8xJ3839CVqX1RaVIVc6JaAX1Cbp3nJF3d2e0lv/hfBG
         fkfKhfmrv0NMsjPebBpkOI4t6vfvmVxwOhTBZ5drmRTWKmWeQmMAHywnQ6Nk8LyRLT2H
         kxJHN6vQXCma4OC3YQiToHaOcfmubtDc44+vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=WXLJ1oSzutuJhfEcW49LDt5KawJ75OpUwCnxnSkJvvAVU/T52FKCVvnP37PoLlUCQD
         W2MYyqm2YIoweYj2GbFiRk86sIIx7fLOt7UKVyf2Iy0MXP270XPvwPHNyHknpz4mRMhE
         nmP6BxZtII1Yibp/dKvNhv8GxOeLfQjHHukj8=
Received: by 10.220.194.73 with SMTP id dx9mr29898vcb.1.1286482996722; Thu, 07
 Oct 2010 13:23:16 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 7 Oct 2010 13:22:48 -0700 (PDT)
In-Reply-To: <AANLkTinSjFDdwqTEU6XzOVHupph0G2ZKM+u3r7t_W3DD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158451>

On Thu, Oct 7, 2010 at 10:18 PM, Pat Thoyts <patthoyts@gmail.com> wrote:
>
> I also wonder why changes to a compat/mingw.h file should affect the
> msvc build. As it has it's own compat/vcbuild and headers in there,
> surely it should be independent of mingw-gcc compatability headers?
>

compat/msvc.h includes compat/mingw.h. We really should move more
stuff to compat/win32.h, and have cygwin include it's own header or
something instead.
