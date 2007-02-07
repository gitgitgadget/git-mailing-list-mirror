From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 10:27:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071025100.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> 
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <68948ca0702071019i5704f24fnf2b9a7d6dfa74d86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 19:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HErW6-0005ar-8y
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 19:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706AbXBGS1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 13:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965709AbXBGS1X
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 13:27:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58593 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965708AbXBGS1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 13:27:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17IRJmA012761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 10:27:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17IRIef022354;
	Wed, 7 Feb 2007 10:27:18 -0800
In-Reply-To: <68948ca0702071019i5704f24fnf2b9a7d6dfa74d86@mail.gmail.com>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38953>



On Wed, 7 Feb 2007, Don Zickus wrote:
>
> I didn't see these options in the man pages.  Might be worth putting in
> there??

Well, they really _are_ there, indirectly:

	The command takes options applicable to the git-rev-list(1) command 
	to control what is shown and how, and options applicable to the 
	git-diff-tree(1) commands to control how the change each commit 
	introduces are shown.

so you have to look at both git-rev-list and git-diff-tree to get all the 
options.

It then goes on to say:

	This manual page describes only the most frequently used options.
	                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

so technically it's complete and true.

But yeah, maybe we could include all the options there.

		Linus
