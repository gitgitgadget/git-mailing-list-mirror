From: Mike Hommey <mh@glandium.org>
Subject: Re: how to create v2 patch
Date: Sat, 1 Dec 2007 14:43:21 +0100
Organization: glandium.org
Message-ID: <20071201134321.GA10997@glandium.org>
References: <47515693.9070405@imap.cc> <47515EF3.8010507@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tilman Schmidt <tilman@imap.cc>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 14:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IySdG-0006Rk-GJ
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 14:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXLANn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbXLANn0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 08:43:26 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:29547 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbXLANnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 08:43:25 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 844DD1C00092
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 14:43:23 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-85-180.w86-205.abo.wanadoo.fr [86.205.43.180])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 67FA61C00086;
	Sat,  1 Dec 2007 14:43:23 +0100 (CET)
X-ME-UUID: 20071201134323426.67FA61C00086@mwinf1907.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IyScs-0003fV-5e; Sat, 01 Dec 2007 14:43:22 +0100
Content-Disposition: inline
In-Reply-To: <47515EF3.8010507@obry.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66715>

On Sat, Dec 01, 2007 at 02:17:39PM +0100, Pascal Obry wrote:
> Tilman Schmidt a =E9crit :
> > Let's say that following the scheme laid out in
> > http://www.kernel.org/pub/software/scm/git/docs/everyday.html#Indiv=
idual%20Developer%20(Participant)
> > I have produced a patch, submitted it to LKML, received a few
> > comments, committed appropriate changes to my local git tree,
> > and now want to submit a revised patch. How do I do that?
> > If I just run git-format-patch again, it produces my original
> > patch plus a second one containing my updates, but what I need
> > is a single new patch replacing the first one.
>=20
> Can't you merge both of your changes in your local repository? I woul=
d
> do that with an interactive rebase.

Or just git commit --amend when committing.

Mike
