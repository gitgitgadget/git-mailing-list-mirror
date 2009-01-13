From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git/webdav is refusing to authenticate properly.
Date: Tue, 13 Jan 2009 12:11:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901131204420.3586@pacific.mpi-cbg.de>
References: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com> <alpine.DEB.1.00.0901130003490.3586@pacific.mpi-cbg.de> <496BE1E0.9010908@gmail.com> <200901121953.16183.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Spierenburg <ionlyusethisaddressforlists@gmail.com>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 12:13:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMhBb-0006ax-VH
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 12:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZAMLKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 06:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZAMLKb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 06:10:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:38919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751571AbZAMLKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 06:10:31 -0500
Received: (qmail invoked by alias); 13 Jan 2009 11:10:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 13 Jan 2009 12:10:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19miix/iDZmpjmc97Oja8oKBW/CKW4QFygnPVXJsH
	96Hi8wVdchOBSN
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901121953.16183.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105485>

Hi,

On Mon, 12 Jan 2009, Boyd Stephen Smith Jr. wrote:

> On Monday 12 January 2009, Peter Spierenburg 
> <ionlyusethisaddressforlists@gmail.com> wrote
>
> >C'mon, leave my password 'in-the-clear', in a text file on a networked 
> >box? That is the kind of prank a fourth-year student would try to pull 
> >on a freshman.
> >
> >How do I really do it?
> 
> AFAIK, that's the only way for now.

Indeed it is.

> Personally, I'd welcome a patch that allowed fetch/push to prompt the 
> user for a password, but I'm not holding my breath.

I guess everybody who wants that feature does exactly the same as you.

Oh, and FWIW: trying to ridicule the way Git does it completely misses the 
fact that you are using such a ridiculously weak authentication scheme 
anyway that you could just as well open the window and shout your password 
out loud.

Ciao,
Dscho

P.S.: real security would require you to have public/private key based 
client authentication.  But that would leave you vulnerable, too, as you 
are apparently not on a trustable machine.

P.P.S.: I have access to such a machine, too, but I never push _from_ 
there.  That is relatively safe, as only those can access my private keys 
(and my $HOME/.netrc, BTW, as you seemed to have missed .netrc's 0600 
mode) can impersonate me without hassle using sudo anyway.
