From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sat, 25 Apr 2009 11:43:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904251142150.3101@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <200904232116.10769.j6t@kdbg.org> <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de> <7vbpqkznjs.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904251039460.3101@localhost.localdomain>
 <49F3588A.4000707@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxmw8-000459-LZ
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbZDYSqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbZDYSqW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:46:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60667 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751432AbZDYSqV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 14:46:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3PIhBbQ011337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Apr 2009 11:43:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3PIhAfw007097;
	Sat, 25 Apr 2009 11:43:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <49F3588A.4000707@gmx.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117569>



On Sat, 25 Apr 2009, Michael Gaber wrote:
> 
> http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF

Yeah, and people thought "pascal" was a good language because it didn't 
contain "break" statements to break out of loops, or "return" statements 
to break out of functions early.

Too bad. They were wrong.

			Linus
