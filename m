From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Make it possible to run git archive --remote without
 a git directory.
Date: Fri, 06 Apr 2007 01:21:16 +0200
Message-ID: <4615846C.9020705@lsrfire.ath.cx>
References: <200704051012.37361.simon@lst.de> <200704052147.39255.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZbGj-0003xa-5j
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767412AbXDEXV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 19:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767416AbXDEXV0
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:21:26 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:42414
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767409AbXDEXVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 19:21:25 -0400
Received: from [10.0.1.201] (p508e699f.dip.t-dialin.net [80.142.105.159])
	by neapel230.server4you.de (Postfix) with ESMTP id 7020C3D00D;
	Fri,  6 Apr 2007 01:21:24 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <200704052147.39255.simon@lst.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43884>

Simon Hausmann schrieb:
> On Thursday 05 April 2007 10:12:37 Simon Hausmann wrote:
> [...]
>=20
> Sorry, for replying to my own mail, but attached is a revised patch t=
hat also=20
> allows --list to work without a git dir, as pointed out by Jeff Garzi=
k.
>=20
> Would be nice if the patch could be applied to git :)

Oh, saw your patch just now -- of course only _after_ I sent mine.
Still, I like my patch better because it reverts the code to a known
good version and it adds a test case.  And maybe a little bit because
it's mine. ;-)

I forgot addressing the 'git-archive --remote' case, though.  The code
is fine (i.e. --remote works outside a repo with the patch applied), bu=
t
a test case for that is missing.  Care to provide this missing piece on
top of my patch?

Thanks,
Ren=E9
