From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: =?iso-8859-1?Q?RE=A0=3A_trailling_whitespace_with_git_am_=3F?=
Date: Fri, 14 Aug 2009 23:50:18 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF0181FAC3@venusbis.synchrotron-soleil.fr>
References: <81b0412b0908141443vc54c009o9ec39b3f617311dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4fW-000852-1n
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbZHNVu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbZHNVu3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:50:29 -0400
Received: from raclette.synchrotron-soleil.fr ([195.221.0.6]:50711 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753249AbZHNVu3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 17:50:29 -0400
Received: from localhost (unknown [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id EB1B978331;
	Fri, 14 Aug 2009 21:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBl6NKLaBnHy; Fri, 14 Aug 2009 23:50:24 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 5817978333;
	Fri, 14 Aug 2009 23:50:24 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: trailling whitespace with git am ?
Thread-Index: AcodKDQiPGAPx64fSGOCI5VE2qfhZAAACphB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125961>

> > so /s /t and /r are the same things for git ?

> almost. For git-apply's whitespace fixing code. Why?

Because for the user the message trailling whitespace was not clear
In fact the problem was a dos/unix format not a trailling space.

but whitespace=fix solve this problem. I was surprise first because I was looking for
remaining space at the end of lines of the patch not this CR+LF things.

Maybe git apply should warn the user a different way if their is that sort of dos/unix imcompatibilities.

thanks

Frederic
