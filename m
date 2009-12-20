From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 20:25:02 +0000
Message-ID: <a5b261830912201225q7d596b55qb54676922301954e@mail.gmail.com>
References: <87my1ev4gi.fsf@users.sourceforge.net>
	 <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
	 <a5b261830912200723s131f0b93w2f5ab94f19faf86a@mail.gmail.com>
	 <7vws0ha2mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 21:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMSL2-0002tD-HX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 21:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbZLTUZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 15:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZLTUZF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 15:25:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:52057 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbZLTUZE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 15:25:04 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1187645eyd.19
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=inL51nBTi96Vv8b/20z53alQBDmE1rVQvtWn53iKCvw=;
        b=gNAxMKRQ2Z6hBb5U9SRkmEIpfTsMqd+ZHy9JUFjLc6ZJ7kOBIixkIcPPAfgC69yK4j
         e5CQVlFyVt5vvTkod7+dnJm7peOjcr5rS/r4+rkYWAIJ+5XkhCWj7w/HxNJirJkZUPGM
         /ny9NZxiijNsZw2/NTcHfy+T49mC8pkWz/YOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A4HBilG/ln+jZfRNxEn69QARyZpX5mjiAbYwCFDdhLfXBvdfPG6N51NkjTIc4VwNt6
         KXwGDe+4ZkGClLGMi2OaiSjZAGgoDkWcTQh7qpYvakOPIhqmOUYnQMxVfFflymFCzFL3
         iyJqYkrI9Nt2l9Y8Md0/Myt0b2aDnnd/pJ6aU=
Received: by 10.213.96.221 with SMTP id i29mr8118295ebn.96.1261340702671; Sun, 
	20 Dec 2009 12:25:02 -0800 (PST)
In-Reply-To: <7vws0ha2mt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135533>

2009/12/20 Junio C Hamano <gitster@pobox.com>:
>
> On X, does the "default: thin borders, kind of windows98ish" look ver=
y
> different from the non-themed classic Tk style?
>

Here is a big set of screenshots then:

Unmodified or with Tk 8.4:
original windows: http://www.patthoyts.tk/screenshots/git-gui-old.png
original unix:        http://www.patthoyts.tk/screenshots/git-gui-x11.p=
ng

With Tk 8.5 and using themed widgets:
unix default: http://www.patthoyts.tk/screenshots/git-gui-default.png
unix alt:        http://www.patthoyts.tk/screenshots/git-gui-alt.png
unix classic: http://www.patthoyts.tk/screenshots/git-gui-classic.png
unix clam:     http://www.patthoyts.tk/screenshots/git-gui-clam.png
unix tileqt:    http://www.patthoyts.tk/screenshots/git-gui-tileqt.png
 (experimental)

windows7:     http://www.patthoyts.tk/screenshots/git-gui-win32.png


> What I am trying to get at is to gain enough information so that I ca=
n
> suggest a rewrite of these two lines (quoted at the beginning by Dsch=
o)
> like this:
>
> =C2=A0 Ttk defaults to the native look as much as possible on Windows=
 and
> =C2=A0 MacOSX; the default on X is the _________ look.
>
> =C2=A0 The user may choose a theme by:
>
> =C2=A0 - on Windows, doing ________;
> =C2=A0 - on MacOSX, doing _________;
> =C2=A0 - on X, selecting a theme using the TkTheme XRDB resource clas=
s;
>
> which I think would be much easier to read.

You write better than I do. The theme used globally by themed Tk can
be selected on at least Ubuntu's GNOME desktop by adding the following
line into ~/.Xresources:
  *TkTheme: clam
It is also possible to add a Theme menu or selection combobox onto the
options dialog and record a theme selection along with the other
git-gui saved options. Then a user could use 'git config gui.theme
clam'. The set of available themes can be extended with packages and
is somewhat platform dependent (ie: xpnative can only be present on
Windows XP and above).

Pat Thoyts.
