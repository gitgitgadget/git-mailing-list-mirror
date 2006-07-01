From: Paul Mackerras <paulus@samba.org>
Subject: Re: Problem with GITK
Date: Sat, 1 Jul 2006 20:49:37 +1000
Message-ID: <17574.21313.93368.666335@cargo.ozlabs.ibm.com>
References: <4d8e3fd30606281340n147821e2hcbd4ccaf9551173f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 12:57:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwdAS-0000QZ-Ak
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 12:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWGAK5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 06:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWGAK5e
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 06:57:34 -0400
Received: from ozlabs.org ([203.10.76.45]:15822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932567AbWGAK5d (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 06:57:33 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4B15467A65; Sat,  1 Jul 2006 20:57:32 +1000 (EST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30606281340n147821e2hcbd4ccaf9551173f@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23044>

Paolo Ciarrocchi writes:

> there is a strange orange line in the following screenshot from gitk:
> http://paolo.ciarrocchi.googlepages.com/Screenshotgit.png

That's an X server bug, and just today I found it.  The bug
description and proposed patch are at:

https://bugs.freedesktop.org/show_bug.cgi?id=7381

Paul.
