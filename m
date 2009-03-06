From: John Chapman <thestar@fussycoder.id.au>
Subject: Re: Using Git with windows
Date: Fri, 06 Mar 2009 19:16:25 +1100
Message-ID: <1236327385.4010.5.camel@localhost>
References: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com>
	 <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tariq Hassanen <tariq.hassanen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVSx-00055Y-OX
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZCFIaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbZCFIaG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:30:06 -0500
Received: from smtp-out9.tpgi.com.au ([220.244.226.119]:43438 "EHLO
	mail9.tpgi.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752721AbZCFIaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:30:05 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2009 03:30:04 EST
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
Received: from 192-168-1-3.tpgi.com.au (220-244-46-25.static.tpgi.com.au [220.244.46.25])
	by mail9.tpgi.com.au (envelope-from thestar@fussycoder.id.au) (8.14.3/8.14.3) with ESMTP id n268H5Br003929;
	Fri, 6 Mar 2009 19:17:06 +1100
In-Reply-To: <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112405>

(Hmm, don't know why evolution didn't quote the message...)

Tariq, while git is heaps nicer and better on Linux, it works quite well
on windows as well, and is reasonably mature.

Just be sure to be aware of autocrlf, and that on windows with msysgit,
it is enabled by default.
 - Also, if you use the cygwin version instead, be aware that applying
patches, etc, can get /funky/ when cygwin is using unix line endings,
but your development environment doesn't.  Again, be very aware of line
endings.

Unless you think your repository will become larger than 2GB (Not
likely), then msysgit will do just fine.

Running git under linux in vmware will be faster, but not worth the
bother, in my opinion.
