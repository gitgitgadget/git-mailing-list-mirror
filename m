From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fetch failure from git2.kernel.org?
Date: Sun, 22 Apr 2007 10:53:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221050350.9964@woody.linux-foundation.org>
References: <86fy6ssp32.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 19:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgFd-0005LX-CJ
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 19:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbXDVRx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbXDVRx0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 13:53:26 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:47969 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753607AbXDVRxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 13:53:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MHrEng022180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 10:53:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MHrDQ5031029;
	Sun, 22 Apr 2007 10:53:13 -0700
In-Reply-To: <86fy6ssp32.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-3.042 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45255>



On Sun, 22 Apr 2007, Randal L. Schwartz wrote:
> 
> is this known?  transient?

Junio seems to have tightened his permissions on kernel.org, and as a 
result the most recent pack is unreadable by anybody but him (I'm not sure 
if such private files even get mirrored out - but even if they do, they 
will get mirrored out with the same tight permissions and won't be 
readable).

		Linus
