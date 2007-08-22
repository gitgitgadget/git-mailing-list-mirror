From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 11:46:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221144160.30176@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <fage86$hui$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvEJ-0000Fd-05
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 20:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763478AbXHVSqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763365AbXHVSqz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 14:46:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38056 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761917AbXHVSqy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 14:46:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MIkKTE028218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 11:46:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MIkFGu031107;
	Wed, 22 Aug 2007 11:46:15 -0700
In-Reply-To: <fage86$hui$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.747 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56404>



On Wed, 22 Aug 2007, Salikh Zakirov wrote:
> 
> Linus Torvalds posted an untested patch in a recent discussion and requested
> that anyone interested in this functionality continued development and testing.

That untested patch was seriously broken - it didn't do the sorting of 
empty directories right. So it would need a lot of other work.

So I'm firmly back in the "just add a '.gitignore' file to the directory" 
camp.

Or you can fake it out entirely by making it an empty subproject, which 
also gives you an empty directory.

			Linus
