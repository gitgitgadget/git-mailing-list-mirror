From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: new platform & S_IFGITLINK problem
Date: Tue, 4 May 2010 07:34:04 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005040732310.5478@i5.linux-foundation.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk> <7vfx2b2ft5.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org> <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org> <4BDFBB18.70800@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alan Hourihane <alanh@fairlite.co.uk>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 04 16:37:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9JFL-0003Y7-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 16:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab0EDOhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 10:37:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51396 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932313Ab0EDOhF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 10:37:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o44EZWet019578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 May 2010 07:35:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o44EZVgG000507;
	Tue, 4 May 2010 07:35:31 -0700
In-Reply-To: <4BDFBB18.70800@op5.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.447 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146313>



On Tue, 4 May 2010, Andreas Ericsson wrote:
> 
> So why not make even pack file access work with the git macros?

Because I'm a sneaky bastard, and I have a long-term plan.

The whole filename character set conversion thing.

So having a git_[l]stat() macro - used only for working tree accesses - 
would be one step in that direction. Doing it for git internal files would 
totally screw that plan up.

		Linus
