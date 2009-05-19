From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 11:33:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 20:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6U8n-0005mW-4R
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 20:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZESSeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZESSeH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 14:34:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41036 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbZESSeH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 14:34:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JIXxBr030804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 May 2009 11:34:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JIXw8k030641;
	Tue, 19 May 2009 11:33:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A12F0ED.4070707@nortel.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119556>



On Tue, 19 May 2009, Chris Friesen wrote:
> 
> However, if I make a change on the arch-specific branch, then tag the
> main branch and merge it into the arch-specific branch, git tells me
> the arch-specific branch is already up-to-date and the tag doesn't
> get propagated.

You can always just do "git fetch --tags" to fetch any new tags without 
doing anything else.

			Linus
