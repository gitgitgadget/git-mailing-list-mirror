From: =?UTF-8?B?QW5kcsOpIENhcm9u?= <andre.l.caron@gmail.com>
Subject: Fwd: git-archive and submodules
Date: Fri, 20 Apr 2012 14:32:06 -0400
Message-ID: <CALKBF2jzL5-mHaVi1erA=EiF_DALF1Rvwv7yB5CfdEdQa2ZhBg@mail.gmail.com>
References: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com>
	<4F911A2C.4070306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: darco@deepdarc.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 20:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLIdA-0006V4-E8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 20:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720Ab2DTScK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 14:32:10 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37600 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab2DTScG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 14:32:06 -0400
Received: by dake40 with SMTP id e40so13340078dak.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=xo7IHr0Y5T7Q4V7WgS4qAt05jIcsI8EgjVwBkggjFJc=;
        b=reeBqfwQ0HEsnygsFzIX3iZTmqp1E6CWrlcirR/jK1VspPW99DzI/daHt5GcIr/iBs
         iYeDX/Iqw+cuI5cdV6Wdct6gNV3wyw89bgsDgneY5qIBNmDN9b22q3Rr7jGXXi73WxwU
         ep1S6+Bt9B+27jjNB22vJ8LfZGFUvruQNEO2KUUq27CNOOLYXaegCk7DLwW9uV1++X2a
         OJh+GChn3aD5FClmyqMRHtyEM1qUDjSiZ4a4QSQ09cnESrqMan3g+I85dWVkOONyC9TI
         gzbnqmP/N9fUPExiF6TjWFvDqMwXXQ3YXxU7CK4UJVAnWM2tmPssG1GOr/Ub0Kp997eg
         ziYQ==
Received: by 10.68.204.234 with SMTP id lb10mr1159884pbc.161.1334946726328;
 Fri, 20 Apr 2012 11:32:06 -0700 (PDT)
Received: by 10.68.194.34 with HTTP; Fri, 20 Apr 2012 11:32:06 -0700 (PDT)
In-Reply-To: <4F911A2C.4070306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196010>

Hi Robert,

I've recently raised the same submodule issue with git-archive you and
Lars have in the past.

What's the status on your application of the git-archive submodule
patch?  Have you applied the changes suggested by Lens Lehmann[1]?
Your Git fork on GitHub[2] seems to have only applied Lars' patch and
an unrelated SVN glob fix...

Since you've touched this only last year, I'd like to know where you
were at and I can see if I can pick up where you left off (unless you
want to finish yourself).

Thanks,
Andr=C3=A9

[1]: http://comments.gmane.org/gmane.comp.version-control.git/172851
[2]: https://github.com/darconeous/git


---------- Forwarded message ----------
=46rom: Jens Lehmann <Jens.Lehmann@web.de>
Date: Fri, Apr 20, 2012 at 4:11 AM
Subject: Re: git-archive and submodules
To: Andr=C3=A9 Caron <andre.l.caron@gmail.com>
Cc: git@vger.kernel.org


Am 19.04.2012 22:10, schrieb Andr=C3=A9 Caron:
> Hi,
>
> I've recently needed to create a source code archive as part of a
> custom build target. =C2=A0This repository uses submodules and I need=
 to
> include the submodlule's source code in the archives too. =C2=A0Howev=
er,
> git-archive does not have any option to do so.
>
> I've taken a quick look at the GMANE mailing list archives and it
> seems this provoked quite a discussion in 2009 and that Lars Hjemli
> even wrote a patch (in several flavors) for archive.c to include
> submodule-aware processing. =C2=A0The lastest source code at
> `git.kernel.org` does not contain any traces of this patch (or
> submodule aware logic for that matter). =C2=A0The mailing list archiv=
es are
> not very convenient to browse and I can't figure out what the status
> on this submodule-aware git-archive idea is. =C2=A0Has this idea been
> completely rejected, or is it still work in progress?

The idea is not rejected, this would be a worthwhile addition. It has
been brought up again last May, but as far as I know it is stalled
since then:
http://comments.gmane.org/gmane.comp.version-control.git/172851
