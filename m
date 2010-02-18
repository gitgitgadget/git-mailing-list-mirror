From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Fri, 19 Feb 2010 00:34:37 +0100
Message-ID: <46d6db661002181534r10a887b5gcc23435cb8952f13@mail.gmail.com>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFtQ-000134-SX
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab0BRXel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 18:34:41 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:44190 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0BRXej convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 18:34:39 -0500
Received: by bwz1 with SMTP id 1so752060bwz.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 15:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I6Gp6buxlMIPn6Seg3sRvfKRX+W16gqRjZH21yrEHk4=;
        b=h+FMW7e+sW2QnvsrC7c1IjngUwguQJGL9XDqEF8ivS7laV+u6gBS6A0iYehLq4tFxE
         kAkhPKrCVtdJpZYvFUSP0tWbHsA5U8BY+9U8l8type/dJqzAEYWg/3UZAgrJF6SUpma3
         u/JTIWPSRa5EXYEXUDLRt+3K4VSyicxBA4ykA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NL2wDngtGuMWRfRMD7COKGe1WD0pcwOsg/6sUlVXCOAijSkqxuwIYZA+zJ8xEh8Jym
         mrzX+sys3aLyR1ewrVML/nmS3pTDRblL1krOwDZikgvbuEPbQI9HO6TeG95XOfK0pVJE
         gwiS5Fw/7o0zEY7ul5LdLRL70iRRpbIw9WFPc=
Received: by 10.204.34.2 with SMTP id j2mr2843281bkd.202.1266536077242; Thu, 
	18 Feb 2010 15:34:37 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140396>

On Thu, Feb 18, 2010 at 7:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, this is just a request-for-discussion. I'm trying out a patch lik=
e
> this, and I think it's a step in the right direction. The git directo=
ry
> structure is _very_ flat, and currently in a fully built git tree, th=
e
> top-level directory has something like 750 files in it.
>
> After this, it still has a ton of files, but it has shrunk to ~575 fi=
les
> instead, and at least for my (admittedly somewhat odd) setup, that
> actually matters for auto-completion etc.

maybe rather than just autocompletion, it does help new code to land
in the right place ? I think just for this reason at least it's a good
move.

I've a wild idea on a new command to add to git and I was pondering
between having it as a perl script or a builtin. Now I know where it
should go if I choose a builtin, provided you get a wide consensus.

> which doesn't seem all that different, but not having that annoying
> break in "Display all 180 possibilities?" is quite a relief.
>
> NOTE! If you do this in a clean tree (no object files etc), or using =
an
> editor that has auto-completion rules that ignores '*.o' files, you
> won't see that annoying 'Display all 180 possibilities?' message - it
> will just show the choices instead. =A0I think bash has some cut-off
> around 100 choices or something.

odd. On my msysgit setup and bash 3.1, I get this on a clean tree:

$ ls builtin<tab>
Display all 90 possibilities? (y or n)

But hey, this is on Windows, so we should not bother :-)

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
