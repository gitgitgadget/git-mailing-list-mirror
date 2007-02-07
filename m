From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix "git log -z" behaviour
Date: Wed, 7 Feb 2007 15:05:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071503100.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> 
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
 <68948ca0702071453i3c4d1b66hcf173fc17919acd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:05:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvqs-0004A9-3q
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbXBGXFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbXBGXFR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:05:17 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44107 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161473AbXBGXFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:05:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17N5CdD023889
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 15:05:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17N5BTK030538;
	Wed, 7 Feb 2007 15:05:11 -0800
In-Reply-To: <68948ca0702071453i3c4d1b66hcf173fc17919acd6@mail.gmail.com>
X-Spam-Status: No, hits=-0.442 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38996>



On Wed, 7 Feb 2007, Don Zickus wrote:
> 
> And I thought I had a handle on a lot of the Unix commands.  That -z
> stuff just threw me for a loop.  It's pretty neat to be able to grep
> commits and have the output display the whole commit and diff.

The whole "-z" flag to grep is a GNU extension, as far as I know. I don't 
think it's portable. 

Even for GNU grep, it's not mentioned in the man-page. Whether that is 
just due to the normal inane FSF rules ("man-pages are evil, you should 
use those idiotic info pages") or whether it is a conscious effort to not 
document nonstandard features, I don't know.

		Linus
