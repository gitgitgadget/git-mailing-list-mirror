From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [ANNOUNCE] diffit - A git plugin for vim
Date: Sun, 16 May 2010 11:41:57 +0200
Message-ID: <20100516094157.GA9553@localhost>
References: <20100515105009.GA10517@localhost>
 <514EDDA1-E8A4-45CD-ACF5-F7FE18CABD4F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun May 16 11:42:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODaMO-0007wt-Os
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 11:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab0EPJmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 05:42:05 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:49623 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0EPJmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 05:42:03 -0400
Received: by ewy8 with SMTP id 8so1403257ewy.28
        for <git@vger.kernel.org>; Sun, 16 May 2010 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dxLks5jmZvPXZLrJc+4RNPbwXrfMghPRgveOURsknDo=;
        b=EGBHUTO2jvEhLHS/klHMMZBbV240BeHfKz4FNNY6C/1eHMexJC706jn1tfooHVXn4V
         mGx1WQJmZcLlzRam+KoLmUrL9be1C8xlLgURFKkPd6rlJ/N4CxzV+fz1Un4tJpbuqkLL
         IzvOfGf8r2OvxGH4Y5XBVmZkqHJtMmZiAF4Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=g9l4joPhhVk3ItlhvUDAMUmyMHkB6Yk8u8vvhxuAWRc/UPxCpRG+8pUvpapCBpf9Zv
         P1ciosiPihtgkXW7IU6kwL/+xeYwxo1LzmV2MkgLZALYRfRbuGxSbtNthixAYMbYbYS0
         GU364S5AcBwpd7cRihWwX8ggCnR2yojMIz+bg=
Received: by 10.213.52.14 with SMTP id f14mr1898018ebg.49.1274002920707;
        Sun, 16 May 2010 02:42:00 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 16sm2201640ewy.3.2010.05.16.02.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 02:42:00 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1ODaM9-0002dP-3l; Sun, 16 May 2010 11:41:57 +0200
Content-Disposition: inline
In-Reply-To: <514EDDA1-E8A4-45CD-ACF5-F7FE18CABD4F@wincent.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147179>

Hi Wincent,

On Sun, May 16, 2010 at 11:12:37AM +0200, Wincent Colaiuta wrote:

> El 15/05/2010, a las 12:50, Clemens Buchacher escribi=F3:
>=20
> > Hi,
> >=20
> > I am currently working on a git plugin for vim. My aim is for it to=
 imitate
> > much of git-gui's functionality. Right now, it is still closer to "=
add -p".
> >=20
> > But I believe it's already useful. And since I'm new to vim scripti=
ng, it
> > can use some testing.
>=20
> Clemens, were you aware that there are already a couple of Git plug-i=
ns
> for Vim? Of these, the most advanced one currently is almost certainl=
y
> Fugitive:

The git plugins I am aware of, including vim-fugitive, mostly implement=
 git
commands to be executed from vim. I find that utterly useless, since I =
can
already do that from the command line.

What I can not do from the command line is staging hunks and lines
interactively, possibly interrupted by a quick fix to a change. This is=
 what
I would use git-gui for, only it does not integrate very well with my v=
im +
cmdline centric workflow.

Here's my TODO list:

- handle file mode changes

- navigation (prev/next hunk/file)

- stage individual lines and (virtual) range

- unstage changes

- file browser (modified, staged, untracked)

- prepare commit message

- git add -e?

If existing plugins already implement these features, then I have misse=
d it,
and I will be happy to use or improve them instead.

As for diffing, some of the existing plugins implement side-by-side, or=
 even
inline diff, using the vimdiff feature. I prefer the native git-diff fo=
rmat,
however.

Cheers,
Clemens
