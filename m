From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Thu, 27 Sep 2007 15:30:08 +0200
Message-ID: <0CAD1C47-A396-46AA-9DC0-96BBD41EE4E4@wincent.com>
References: <20070927130447.GH10289@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 15:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IatRc-0006tg-J9
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 15:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbXI0NaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 09:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXI0NaN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 09:30:13 -0400
Received: from wincent.com ([72.3.236.74]:46396 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbXI0NaM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 09:30:12 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8RDUAqt018920;
	Thu, 27 Sep 2007 08:30:10 -0500
In-Reply-To: <20070927130447.GH10289@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59296>

El 27/9/2007, a las 15:04, Pierre Habouzit escribi=F3:

>   There is a behavior of git-push that is the most annoying thing =20
> while
> working with a central-repository: `git push` without any arguments
> insists on pushing every local refspec that match one in origin.

I kind of agree. Without reading the git-push man page I would =20
intuitively expect "git push" with no arguments to push only the =20
branch I currently have checked out, and "git push --all" to push all.

>   I'm not sure what we can do about it, but I'm pretty sure it bites =
a
> lot of people out there. For now I use this alias in my .gitconfig:
>
>   p=3D!git-push origin `git-symbolic-ref HEAD`

Ah, nice alias! Thanks for sharing it.

Cheers,
Wincent
