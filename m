From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Handling very large numbers of symbolic references?
Date: Tue, 25 Jul 2006 23:29:54 +0200
Message-ID: <44C68D52.6030107@lsrfire.ath.cx>
References: <87psfteb4l.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 23:30:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5UTg-0002e8-H8
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGYV35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 25 Jul 2006 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGYV35
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 17:29:57 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:11199
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964865AbWGYV34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 17:29:56 -0400
Received: from [10.0.1.3] (p508E6E50.dip.t-dialin.net [80.142.110.80])
	by neapel230.server4you.de (Postfix) with ESMTP id B87863B001;
	Tue, 25 Jul 2006 23:29:55 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Nix <nix@esperi.org.uk>
In-Reply-To: <87psfteb4l.fsf@hades.wkstn.nix>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24188>

Nix schrieb:
> However, this causes a potential problem. There are tens of thousands=
 of
> these bugs, and the .git/refs/heads directory gets *enormous* and thu=
s
> the system gets terribly terribly slow (crappy old Solaris filesystem
> syndrome).
>=20
> It seems to me there are two ways to fix this:
>=20
>  - restructure .git/refs/* in a similar way to .git/objects, i.e. as =
a
>    one- or two-level tree.

Branch names are allowed to contain slashes, thus your porcelain is fre=
e
to implement such a tree.  Add a slash after every two bug ID digits an=
d
your directories will never contain more than 100 objects.

Ren=E9
