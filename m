From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Wed, 22 Mar 2006 17:28:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 02:28:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEcv-0006Rh-UK
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCWB2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWCWB2a
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:28:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932427AbWCWB23 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 20:28:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N1SNDZ023598
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 17:28:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N1SN1m005917;
	Wed, 22 Mar 2006 17:28:23 -0800
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17841>



On Wed, 22 Mar 2006, Linus Torvalds wrote:
> 
> This one-liner to cvsps.c seems to make sure we have an ancestor branch 
> for that "gdb-4.18-branch" branch, at least according to the cvsps output. 

The "git cvsimport" is still running, but at least it seems to be happily 
running further past the point it broke earlier.

Will send the patch over to David Mansfield.

		Linus
