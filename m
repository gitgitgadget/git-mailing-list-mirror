From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: =?iso-8859-1?Q?RE=A0=3A_trailling_whitespace_with_git_am_=3F?=
Date: Fri, 14 Aug 2009 22:21:05 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF0181FABD@venusbis.synchrotron-soleil.fr>
References: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr> <81b0412b0908141310x7e4acf4fgf4ea71cf53de6eea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3HD-0004jI-MK
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbZHNUVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbZHNUVQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:21:16 -0400
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:46660 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757123AbZHNUVP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:21:15 -0400
Received: from localhost (unknown [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id AB86378314;
	Fri, 14 Aug 2009 20:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g+ZLX8zbDuUY; Fri, 14 Aug 2009 22:21:11 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 13CD67832E;
	Fri, 14 Aug 2009 22:21:11 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: trailling whitespace with git am ?
Thread-Index: AcodGzo4TlrvT2UUQfCzvk/p/4/fbgAAEtNy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125945>

> This patch has DOS line endings (like CR, followed by LF).

> You can either use dos2unix (or your editor of choice), or update your git
> to current master branch, where "git am" handles such patches transparently.

I am using git 1.6.3.3 debian unstable is it ok ?

In fact we saw that this problem was due to our webmail

the patch was attached to a mail and using the webmail interface a save to disk transform the CR -> CR LF

we tested it with gmail and the microsoft webmail

now the problem is that a patch with CR+ LF do not have the same signature that a patch
with  only CR.

how can I do the difference between a patch with normal CR+LF (the autor use this format)
and a patch without CR+LF due to the webmail ?

See you

Frederic
