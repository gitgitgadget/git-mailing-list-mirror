From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-rev-list(1): group options; reformat; document more
 options
Date: Thu, 31 Aug 2006 16:15:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608311611440.27779@g5.osdl.org>
References: <20060831223715.GC482@diku.dk> <Pine.LNX.4.64.0608311557470.27779@g5.osdl.org>
 <20060831230811.GE482@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 01 01:16:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvlQ-0005ix-Ij
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWHaXP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWHaXP5
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:15:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964814AbWHaXP4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 19:15:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7VNFfnW008644
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 31 Aug 2006 16:15:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7VNFdmD028779;
	Thu, 31 Aug 2006 16:15:40 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060831230811.GE482@diku.dk>
X-Spam-Status: No, hits=-2.447 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26289>



On Fri, 1 Sep 2006, Jonas Fonseca wrote:
> Linus Torvalds <torvalds@osdl.org> wrote Thu, Aug 31, 2006:
> > 
> > Umm? You should get a "usage" error, no?
> 
> Yes, ok, they do not seem to make sense for git-rev-list, however if you
> pass either to git-log, the output seems to make room for a diff, adding
> one extra newline, but without appending any diff.

Ahh. I think that a "-r" without any other request for patches (or 
"--name-status" or similar) should probably imply "--raw". At least that 
was how it historically worked..

Anyway, _if_ it ever worked (and I think it did, but I'm way too lazy to 
bother checking), this may have been broken by the extensive diff option 
cleanups by Timo in June. Timo? Junio?

			Linus
