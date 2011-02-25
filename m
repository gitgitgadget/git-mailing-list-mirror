From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Fri, 25 Feb 2011 12:11:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1102251208380.1561@bonsai2>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 25 12:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psvaq-0006Nf-J7
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 12:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab1BYLMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 06:12:10 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:55553 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932459Ab1BYLMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 06:12:09 -0500
Received: (qmail invoked by alias); 25 Feb 2011 11:12:07 -0000
Received: from pD9EB2478.dip0.t-ipconnect.de (EHLO noname) [217.235.36.120]
  by mail.gmx.net (mp035) with SMTP; 25 Feb 2011 12:12:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SAfpeUhHShW13mQxWdWavQNU1pKZesiu9kyUiHv
	W6GPf9SqAbJkya
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110225090544.GA3783@tugrik.mns.mnsspb.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167899>

Hi,

On Fri, 25 Feb 2011, Kirill Smelkov wrote:

> Johannes, can we please try my patch[1] for msys.dll not to load 
> user32.dll for every msys program (i.e. sh.exe too)? Combined together 
> with 3 clipboard functions removal (details in [2]) from sh.exe, I bet 
> this will result in significantly faster shell startup, configure runs, 
> etc...
> 
> This days I have lack of access to windows machines, only wine, so I
> desperately need someones help to at least first rebuild msys.dll.
> 
> [1] http://repo.or.cz/w/msys/kirr.git/commitdiff/f7d7efebd35e8e5bf6d685ff4f1197941984be04
> [2] http://repo.or.cz/w/msys/kirr.git/commitdiff/a97bed5d22f9c05f39776d8ea7856db4ce572dc5

Three things:

[2] does not apply cleanly, so I am still desperately trying to find some 
time to finish it off (the patches are to msys.git, not the 'msys' branch 
of msysgit.git, so I had to find a quarter an hour in order to put them 
there in the first place, taking up all the Git time budget I wanted to 
allow myself for this week).

Further, I think that my beloved Shift+Insert will no longer work with 
your [2].

And lastly, in [2] you claim that you cross-built msys-1.0.dll. I would 
like to have a script doing that in msysgit.git.

Ciao,
Dscho
