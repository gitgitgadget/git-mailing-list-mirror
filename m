From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Help with a tcl/tk gui thing..
Date: Thu, 2 Oct 2008 07:49:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810020746480.3341@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>  <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>  <alpine.LFD.2.00.0810011605001.3341@nehalem.linux-foundation.org>
 <237967ef0810012218i28d41573s6bb7866e0be485f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:54:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPVz-0001v3-LR
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYJBOtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbYJBOtl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:49:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48971 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753527AbYJBOtk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 10:49:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m92EnAej020163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Oct 2008 07:49:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m92En9EM011523;
	Thu, 2 Oct 2008 07:49:09 -0700
In-Reply-To: <237967ef0810012218i28d41573s6bb7866e0be485f2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97345>



On Thu, 2 Oct 2008, Mikael Magnusson wrote:
> 
> Heh, sorry, I'm an idiot. I forgot to put '#!/usr/bin/python' on the first
> line. I was running 'python tracker-ui.py' then did chmod +x just before
> committing :). So the cross is coming from running 'import time'.

Ahh. It did _something_, so I assumed it was working, just not well. Being 
confused about the language would do it ;)

I fixed it up and merged it as an alternate UI. It doesn't react well to a 
tracker file that has just been initialized with the timeout (but without 
any of the extra information that gets filled out once you actually start 
getting tracked), but it's certainly prettier than my original one.

Thanks,

		Linus
