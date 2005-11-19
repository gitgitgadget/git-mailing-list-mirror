From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Change encoding of RSS feed to latin-1
Date: Sat, 19 Nov 2005 22:18:33 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511192218.33352.ismail@uludag.org.tr>
References: <200511192156.23259.ismail@uludag.org.tr> <20051119201406.GA8985@puritan.petwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Nov 19 21:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdZAX-00028t-2A
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 21:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKSUSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 Nov 2005 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVKSUSh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 15:18:37 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:23722 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750795AbVKSUSh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 15:18:37 -0500
Received: from [85.101.239.128] (unknown [85.101.239.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 44496AB39C
	for <git@vger.kernel.org>; Sat, 19 Nov 2005 22:18:31 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.92
In-Reply-To: <20051119201406.GA8985@puritan.petwork>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12351>

Saturday 19 November 2005 22:14 tarihinde, Nikolai Weibull =C5=9Funlar=C4=
=B1 yazm=C4=B1=C5=9Ft=C4=B1:=20
> Ismail Donmez wrote:
> > As the other thread grew into merits of using UTF-8 I think best fi=
x
> > for now is putting encoding=3Dlatin-1 into RSS feed so everyone is
> > happy. After all its latin-1 encoded data not utf-8. Anyone disagre=
es?
> > Can we now please fix/change gitweb so xml parsers can parse it
> > without workarounding?
>
> If you know that your log-messages will be in latin-1 or UTF-8 or
> whatever encoding you like, then modify your gitweb.cgi to match.  Ju=
st
> search for 'utf-8' and change it to what you prefer.
>
> What perhaps is of general interest is modifying the distributed
> gitweb.cgi to allow for easily changing the encoding on a
> per-installation basis, just like $projectroot is configurable on a
> per-installation basis.
>
> UTF-8 is still a sane default for gitweb.cgi.

I am just interested in parsing linus's tree's rss feed. And no UTF-8 i=
s not a=20
sane default when the encoding used is not UTF-8. And Linus puts it it =
will=20
be latin-1 for long I guess.

Regards,
ismail
