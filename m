From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 11:51:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org> <20080314183731.GA2994@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaF1A-0003oo-BA
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbYCNSvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYCNSvz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:51:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51472 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865AbYCNSvy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 14:51:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EIqHFK007563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 11:52:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EIpKMY014270;
	Fri, 14 Mar 2008 11:51:21 -0700
In-Reply-To: <20080314183731.GA2994@atjola.homenet>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.319 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77273>



On Fri, 14 Mar 2008, Bj?rn Steinbrink wrote:
> 
> Hm, that's just squashing revert commit. Squashing can be done via:
> git reset --soft HEAD~5    # Or wherever your squashed commit should start
> git commit -m "Squashed from HEAD~5 onwards"
> 
> Now the "revert" version of that:
> git reset --hard HEAD~5      # Go back to the state that we want
> git reset --soft ORIG_HEAD   # Move HEAD back, but keep the index as is
> git commit -m "Back at the state of HEAD~5"
> 
> AFAICT that should have the same advantages as using read-tree, but
> doesn't feel so low-level :-)

Umm. The low-level one is a *lot* easier to understand than your 
"high-level" one, wouldn't you say?

And when the low-level plumbing commands are easier, are they not then 
better porcelain?

		Linus
