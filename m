From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: gitweb - encoding problems
Date: Tue, 22 May 2007 00:09:09 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705220009.09911.ismail@pardus.org.tr>
References: <20070521205721.GA21771@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon May 21 23:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqF6S-0001Sz-Km
	for gcvg-git@gmane.org; Mon, 21 May 2007 23:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbXEUVHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbXEUVHd
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 17:07:33 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:57606 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756727AbXEUVHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 17:07:32 -0400
Received: from southpark.local (unknown [85.108.77.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 48F826008C75;
	Tue, 22 May 2007 00:07:22 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070521205721.GA21771@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48051>

On Monday 21 May 2007 23:57:21 you wrote:
> binmode STDOUT, ':utf8';
>
> print decode_utf8('=C3=A4=C3=B6=C3=BC');

[~]> perl test.pl
=C3=A4=C3=B6=C3=BC

[~]> cat test.pl
use Encode;
binmode STDOUT, ':utf8';

print decode_utf8('=C3=A4=C3=B6=C3=BC'),"\n";
[cartman@southpark][00:08:15]
[~]> perl --version

This is perl, v5.8.8 built for i686-linux

Copyright 1987-2006, Larry Wall

Perl may be copied only under the terms of either the Artistic License =
or the
GNU General Public License, which may be found in the Perl 5 source kit=
=2E

Complete documentation for Perl, including FAQ lists, should be found o=
n
this system using "man perl" or "perldoc perl".  If you have access to =
the
Internet, point your browser at http://www.perl.org/, the Perl Home Pag=
e.

You got an old Encode.

--=20
Perfect is the enemy of good
