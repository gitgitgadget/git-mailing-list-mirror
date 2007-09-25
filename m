From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Missing strptime
Date: Mon, 24 Sep 2007 17:52:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709241750510.3579@woody.linux-foundation.org>
References: <OF8EBEA0A7.5425E9EA-ON88257360.00812AEA-88257360.00819919@beckman.com>
 <Pine.LNX.4.64.0709250127170.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: mkraai@beckman.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 02:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZyfW-0001ja-VV
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 02:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbXIYAws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXIYAws
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 20:52:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36173 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681AbXIYAwr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 20:52:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8P0qgpK022075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2007 17:52:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8P0qgBj026043;
	Mon, 24 Sep 2007 17:52:42 -0700
In-Reply-To: <Pine.LNX.4.64.0709250127170.28395@racer.site>
X-Spam-Status: No, hits=-2.737 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.39__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59083>



On Tue, 25 Sep 2007, Johannes Schindelin wrote:
> 
> The only user for strptime is convert-objects, a program that should 
> probably move to contrib/ anyway.  It was used once, a long time ago, to 
> convert from the old format, which hashed the compressed contents, to the 
> current format, which hashes the contents _before_ compression.

Actually, it also changes the date format, I think.

> AFAIAC if a similar need should arise, the better alternative would be to 
> write git-fast-export, a tool which dumps the contents of a repository 
> suitable to pipe into git-fast-import.

Agreed. It probably might as well just be moved to contrib and let it 
bitrot.

		Linus
