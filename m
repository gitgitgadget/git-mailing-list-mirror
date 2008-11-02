From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Encoding problems using git-svn
Date: Sun, 2 Nov 2008 14:45:36 +0100
Message-ID: <200811021445.37149.robin.rosenberg@dewire.com>
References: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com> <8b168cfb0810300814i53a264c2x997543e145d5e15a@mail.gmail.com> <20081102094845.GB16003@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James North <tocapicha@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 14:47:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwdId-00053o-2V
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 14:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYKBNpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 08:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYKBNpq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 08:45:46 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:36940 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753283AbYKBNpq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 08:45:46 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C5015C2BF7; Sun, 2 Nov 2008 14:45:40 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
In-Reply-To: <20081102094845.GB16003@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99842>

On s=F6ndag 02 november 2008 10:48 Eric Wong wrote:
> James North <tocapicha@gmail.com> wrote:
> > Hi Eric,
> >
> > Don't worry about not seeing the patch and thanks for the answer :)
> >
> > Your patch works great.
> >
> > Messages appear without problems on "svn log" and "git log", I have=
n't
> > found any gotcha that I know of.
>
> Thanks for the confirmation.
>
> > The weird thing is that this problem was not found by anyone before=
, I
> > guessed there should be some people with a setup similar to mine.
>
> Squeaky wheel gets the grease :)
>
> Honestly, I think most folks have just moved onto UTF-8 entirely and
> left legacy encodings behind.  Especially people using modern tools l=
ike
> git (along with SVN enforcing UTF-8 at the repository/protocol level)=
=2E

"Most" people don't have a legacy encoding problem, but some of us do a=
nd=20
tools that help with migration by enforcing UTF-8 internally help. SVN =
is such
an example, though not very helpful as an SCM. That way we can still us=
e=20
legacy encodings for old stupid tools until we can move to an all UTF-8=
 world.=20
We're not there yet, but in a few years hopefully. That's when it's sad=
 that=20
the git command line for example still enforce the legacy encoding. Som=
e=20
GUI's, like git gui, jgit and probably a few others help by recoding wh=
en=20
necessary.

-- robiin
