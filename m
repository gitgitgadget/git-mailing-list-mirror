From: Tom Tobin <korpios@korpios.com>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 15:18:20 -0500
Message-ID: <1192565900.6430.16.camel@athena>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <471476B7.5050105@users.sourceforge.net>
	 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	 <47148F72.1090602@users.sourceforge.net>
	 <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
	 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhssE-0004sd-6N
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbXJPUSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 16:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXJPUSb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:18:31 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:3704 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbXJPUSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:18:30 -0400
Received: by py-out-1112.google.com with SMTP id u77so3899297pyb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 13:18:27 -0700 (PDT)
Received: by 10.35.121.12 with SMTP id y12mr9560467pym.1192565907245;
        Tue, 16 Oct 2007 13:18:27 -0700 (PDT)
Received: from ?127.0.0.1? ( [208.75.86.189])
        by mx.google.com with ESMTPS id f51sm7192935pyh.2007.10.16.13.18.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Oct 2007 13:18:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61247>

On Tue, 2007-10-16 at 12:20 -0700, Linus Torvalds wrote:
> The only sane solution is the one the kernel and git have always used=
:=20
> tabs are 8 spaces wide, and anybody who disagrees can go screw themse=
lves.=20
> If you don't have 8-character tabs, you *will* get odd indentation.
>=20
> And no, the answer is not to say "don't use tabs at all" and replace =
them=20
> by spaces. The answer is *also* not "tabs are just for initial code=20
> indents", because not only will most sane editors never even show the=
=20
> difference, it's simply not how people work. So such a rule about=20
> invisible things doesn't work.
[...]
> The fact that some projects have encouraged bad coding style and *ins=
ane*=20
> tab values is not a git problem. We should teach people to do *better=
*,=20
> not become worse just because others have done idiotic things.

I'm reading two different ideas here, and it seems like you're
conflating the two =E2=80=94 and, in the process, telling some pretty s=
mart
people (smarter than me, anyhow) to go fuck themselves.

If a project uses tabs, your statement regarding 8-char-width tabs make=
s
sense; you need some rule by which you can assume others are viewing th=
e
same thing you are.

But you then dismiss out of hand the option of using all spaces; Python
has been getting along perfectly well for quite some time by following
this rule, and my experience with the language leads me to believe it's
the wiser of the choices.  Questions over tab width simply *go away*;
you pick an indentation level (Python uses 4) and stick with it.

I'm not arguing that git should switch to all spaces; projects tend to
become set in their ways, and consistency can be valuable.  I'm merely
pointing out that all-spaces is a quite *sane* option, even if it's one
git doesn't choose.
