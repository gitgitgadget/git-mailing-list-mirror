From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Mon, 27 Apr 2009 16:06:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904271605250.22156@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain> <7vvdopwxxa.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904280027540.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZwq-0004j8-Sz
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391AbZD0XJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756953AbZD0XJE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:09:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41997 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756806AbZD0XJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:09:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RN6lQN032171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 16:07:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RN6kKP032353;
	Mon, 27 Apr 2009 16:06:47 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0904280027540.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.957 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117729>



On Tue, 28 Apr 2009, Johannes Schindelin wrote:
>
> As I said, this is highly unlikely, as certain people made sure that the 
> Google Code people do not like Git.

There are actually lots of sane and educated people inside google. Many of 
them freely acknowledge what a horrid thing SVN is.

			Linus
