From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merge-Recursive Improvements
Date: Tue, 12 Feb 2008 15:48:06 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Voltage Spike <voltspike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4rk-0006Rx-L8
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbYBLXsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYBLXsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:48:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47557 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265AbYBLXsI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 18:48:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNm6vp017685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 15:48:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNm6H3029349;
	Tue, 12 Feb 2008 15:48:06 -0800
In-Reply-To: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.742 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73714>



On Tue, 12 Feb 2008, Voltage Spike wrote:
> 
> First, git is overly zealous at merging differences and two functions added
> at the same point in a file become intertwined during the merge. A trivial
> example of this behavior:

Hmm. Have you tested what happens if you use XDL_MERGE_EAGER instead of 
XDL_MERGE_ZEALOUS in the "level" argument to xdl_merge() in 
merge-recursive.c?

(No, I didn't test it myself, but it may get you the behaviour you want, 
and we could make it a config option for people who want a less aggressive 
merge)

			Linus
