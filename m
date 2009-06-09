From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 15:14:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 00:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME9bc-00040b-D2
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 00:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbZFIWPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbZFIWPa
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 18:15:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50585 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbZFIWPa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 18:15:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n59MEx9P031360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 15:15:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n59MEwGG021458;
	Tue, 9 Jun 2009 15:14:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121231>



On Tue, 9 Jun 2009, Scott Chacon wrote:
> 
> * breaks the various things that 'checkout' does into separate
> commands - moves 'revert' to doing what 'checkout -- path' does

No.

NAK on this one. 

The fact that some idiotic SVN usage exists is not an excuse to break 
long-standing git users. "revert" comes from bk, and quite frankly, I 
object _very_ strongly to taking naming from something that is very 
obviously the inferior system (SVN) over something very obviously superior 
(BK and git).

Feel free to add other "helper" aliases that are actually _new_ and have 
no pre-existing git meaning, but not things like this. Not breaking 
existing git usage just because somebody is too stupid and/or lazy to try 
to learn a new word.

		Linus
