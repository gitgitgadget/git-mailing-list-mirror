From: walt <wa1ter@myrealbox.com>
Subject: Re: cg-update bug?
Date: Sat, 21 Jan 2006 07:03:59 -0800
Organization: none
Message-ID: <dqtih0$i80$1@sea.gmane.org>
References: <dqo6fs$sr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 21 16:06:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0KJR-0001j3-M1
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 16:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWAUPEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 10:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAUPEY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 10:04:24 -0500
Received: from main.gmane.org ([80.91.229.2]:22984 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932158AbWAUPEX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 10:04:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1F0KHe-0001Iu-Qa
	for git@vger.kernel.org; Sat, 21 Jan 2006 16:04:09 +0100
Received: from adsl-69-234-176-54.dsl.irvnca.pacbell.net ([69.234.176.54])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 16:04:06 +0100
Received: from wa1ter by adsl-69-234-176-54.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 16:04:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-176-54.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060121)
In-Reply-To: <dqo6fs$sr$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14997>

walt wrote:
> ...there is no -v flag for cg-update.  Could it be added
> so I can get the old behavior back?

Thanks for adding the flag, Petr.  I tried it on git and
the kernel this morning, and in each case cg-update -v
printed the name of only one file.  From looking at the
logs I'm pretty sure there were multiple files updated,
not just one.  Does it print all filenames for you?
