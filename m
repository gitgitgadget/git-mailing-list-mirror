From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] reset: add option "--merge-dirty" to "git reset"
Date: Fri, 11 Sep 2009 09:02:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909110859390.3654@localhost.localdomain>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.37592.chriscool@tuxfamily.org> <alpine.LFD.2.01.0909101617280.3654@localhost.localdomain> <200909110729.32581.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm8af-0004iE-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 18:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZIKQDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 12:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbZIKQDD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 12:03:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58508 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749AbZIKQDC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 12:03:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BG2p9W021814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Sep 2009 09:02:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BG2onm021193;
	Fri, 11 Sep 2009 09:02:50 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200909110729.32581.chriscool@tuxfamily.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.958 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128202>



On Fri, 11 Sep 2009, Christian Couder wrote:
> 
> No, I realize it was my writing skills that were lacking again. I will 
> rework the commit message using some tables like in Daniel's message.

Ok, thanks.

> > The patch also seems to imply that it's always about HEAD. True?
> 
> Yes.

It might be worth noting/explaining very explicitly. "git reset" uin 
general does not ever try to make HEAD special - except as a _default_ 
location, of course, and as the thing that is actually modified.

I realize _why_ (HEAD is kind of the "base" for the index state), but I 
think it's worth a comment or something. I did a double-take when I saw 
that part of the diff exactly because it's unusual.

		Linus
