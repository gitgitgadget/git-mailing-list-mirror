From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config
 file
Date: Fri, 26 Jan 2007 08:03:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701260802060.25027@woody.linux-foundation.org>
References: <200701261413.46823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 17:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HATYR-0005iK-TV
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 17:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbXAZQD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 11:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbXAZQDZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 11:03:25 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40503 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030574AbXAZQDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 11:03:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0QG3LgP007244
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Jan 2007 08:03:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0QG3HFC019154;
	Fri, 26 Jan 2007 08:03:19 -0800
In-Reply-To: <200701261413.46823.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.584 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37868>



On Fri, 26 Jan 2007, Andy Parkins wrote:
> 
> This patch adds a configuration entry "user.signingkey" which, if
> present, will be passed to the "-u" switch for gpg, allowing the tag
> signing key to be overridden.  If the entry is not present, the fallback
> is the original method, which means existing behaviour will continue
> untouched.

FWIW: Ack. This sounds like a good idea, and the patch looks fine too.

		Linus
