From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 12:25:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708231225180.30176@woody.linux-foundation.org>
References: <46CD94AB.7070709@trolltech.com>
 <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
 <7vhcmqt7oh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIKG-0007iJ-Sa
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXHWT0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbXHWT0g
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:26:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53265 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208AbXHWT0g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 15:26:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NJPn6k026456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 12:25:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NJPmMO023427;
	Thu, 23 Aug 2007 12:25:48 -0700
In-Reply-To: <7vhcmqt7oh.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.951 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_48,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56519>



On Thu, 23 Aug 2007, Junio C Hamano wrote:
> 
> As you said, there is something else going on.  write-tree is
> about reading the index entries and writing them out as a set of
> trees, and at that point it should not even matter if you have
> garbage in the work tree or if you do not even have a work tree.
> All the crlf conversions have been done when the object hit the
> index, so its reading or not reading core.autocrlf should not
> change its behaviour.

Ok, I just sent out the analysis of this, maybe you should add that as the 
changelog for the one-liner, and sign-off from me.

		Linus
