From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with Linus's git repository?
Date: Thu, 28 Jun 2007 08:41:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706280840570.8675@woody.linux-foundation.org>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
   <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
 <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706280632540.5321@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 17:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3w7v-0005zz-VW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 17:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbXF1Plo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 11:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759500AbXF1Pln
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 11:41:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48584 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759034AbXF1Plm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 11:41:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SFfdUx020445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2007 08:41:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SFfXYZ028391;
	Thu, 28 Jun 2007 08:41:33 -0700
In-Reply-To: <Pine.LNX.4.64.0706280632540.5321@x2.ybpnyarg>
X-Spam-Status: No, hits=-2.628 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51115>



On Thu, 28 Jun 2007, walt wrote:
> 
> No, every morning I pull from you and Junio and Petr Baudis using cg-update,
> so I'm very much current.  I notice that cg-update specifically does an
> http GET on kernel/git/torvalds/linux-2.6.git/HEAD which is actually a
> symlink to your refs/heads/master.  Your 'master' now exists, but didn't
> exist two days ago as far I could see from my end.

Oh, don't use "cg-update", or just fix it to do "git pull".

That explains it. cogito simply is not maintained any more.

		Linus
