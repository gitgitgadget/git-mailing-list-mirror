From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 09:44:12 +0100
Message-ID: <20071204084412.GA19597@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <20071204081634.GD31042@auto.tuwien.ac.at> <200712041028.59185.ismail@pardus.org.tr> <200712041033.39579.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTOQ-0005fV-72
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXLDIoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXLDIoS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:44:18 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43596 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbXLDIoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:44:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 0E8FA8BF757E;
	Tue,  4 Dec 2007 09:44:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MGxvXzGVZH7; Tue,  4 Dec 2007 09:44:12 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B094A8BF755C; Tue,  4 Dec 2007 09:44:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712041033.39579.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67025>

On Tue, Dec 04, 2007 at 10:33:39AM +0200, Ismail D=F6nmez wrote:
> Following to_utf8 function works for me :

=46or me too (Debian sarge+etch).

> sub to_utf8 {
> =B7 =A0 my $str =3D shift;
>=20
> =A0 =A0 if(utf8::valid($str))
> =A0 =A0 {
> =A0 =A0 =A0 =A0 utf8::decode($str);
> =A0 =A0 }
> =B7
> =A0 =A0 return $str;

In the original thread, there was some discussion, that some people
might want a different fallback endcoding. So mayme you should=20
keep the second call to decode for the fallback encoding.

> }

mfg Martin K=F6gler
