From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Tue, 8 May 2007 13:44:46 -0400
Message-ID: <3AF7D319-64EC-49DD-BDBB-D438EBA0CD6A@silverinsanity.com>
References: <200705081349.34964.ismail@pardus.org.tr> <20070508150220.GA18860@informatik.uni-freiburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue May 08 19:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlTkB-0003g5-N4
	for gcvg-git@gmane.org; Tue, 08 May 2007 19:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966690AbXEHRoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 13:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966874AbXEHRoy
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 13:44:54 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42229 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966690AbXEHRox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 13:44:53 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CCF441FFC003;
	Tue,  8 May 2007 17:44:51 +0000 (UTC)
In-Reply-To: <20070508150220.GA18860@informatik.uni-freiburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46604>


On May 8, 2007, at 11:02 AM, Uwe Kleine-K=F6nig wrote:

> Personally I prefer FHS, so I have
>
> 	mandir=3D$(prefix)/share/man
>
> in my config.mak.

The Perl man files Git(3pm) and private-Error(3pm) seem to ignore =20
that setting though.  :-(

I just have a "mybuild" target in config.mak that calls make all, =20
doc, test, install, and install-doc before cleaning up files from the =20
wrong places (man instead of share/man, Perl's System dir on OS X) =20
and running "stow -R" to catch new files.

~~ Brian