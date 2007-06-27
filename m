From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with Linus's git repository?
Date: Wed, 27 Jun 2007 09:34:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:34:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3aTh-0001fW-9n
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 18:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbXF0Qeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXF0Qeq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 12:34:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54787 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753265AbXF0Qeq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 12:34:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RGYFET002415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2007 09:34:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RGY9q9021918;
	Wed, 27 Jun 2007 09:34:10 -0700
In-Reply-To: <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
X-Spam-Status: No, hits=-2.627 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51056>



On Wed, 27 Jun 2007, walt wrote:
> >
> > It's not missing, it's packed. I tend to re-pack after I make a release,
> > and this time I did it after -rc6...
> 
> Sometime overnight this problem disappeared.  I haven't actually
> tested this idea, but I have a hunch that your commit yesterday
> of "Fix zero-object version-2 packs" is the reason.

No, I think the reason is simply that I pushed more updates to kernel.org, 
so now the kernel git repo has an explicit and separate "master" branch 
again.

What is your git version? The _real_ fix probably is to just upgrade. Are 
you using that broken(*) Debian git package by any chance?

		Linus

(*) By broken I mean "stable cannot be bothered to upgrade packages to 
modern versions, and is still on some ancient 1.4-based git version"
