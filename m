From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Tue, 17 Jul 2007 13:40:24 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070717114024.GA12215@informatik.uni-freiburg.de>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com> <7vejje3a4k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 13:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAlQ9-00016f-HI
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 13:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbXGQLkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765728AbXGQLkb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 07:40:31 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35556 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757482AbXGQLka (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 07:40:30 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IAlPp-0007d8-6X; Tue, 17 Jul 2007 13:40:29 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6HBePXi013467;
	Tue, 17 Jul 2007 13:40:25 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6HBeOhM013466;
	Tue, 17 Jul 2007 13:40:24 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejje3a4k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52754>

Hello,

Junio C Hamano wrote:
> We could write it as "$(TAR) Ccf blt - ." if we can rely on the
> 'C' option, but I suspect it is a GNU extension.  Does anybody
> have POSIX.1 handy?
I don't have POSIX.1 handy, but on Solaris 10, you need to say:

	tar cf - -C blt .

(That is, Solaris' tar has the 'C' option, which is quite a good
indication, that it's included in POSIX :-)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dgigabyte+in+bit
