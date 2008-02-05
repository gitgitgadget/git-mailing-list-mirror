From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH-v2 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 5 Feb 2008 15:21:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051520520.8543@racer.site>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org> <1202205704-10024-4-git-send-email-bonzini@gnu.org> <alpine.LSU.1.00.0802051500190.8543@racer.site> <47A87DDC.5030708@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPdU-0006zJ-A5
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYBEPW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYBEPW1
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:22:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:39852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbYBEPW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:22:26 -0500
Received: (qmail invoked by alias); 05 Feb 2008 15:22:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 05 Feb 2008 16:22:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9bOMJz1T9KF8+gNvZbDpDEVLmU7NycrR/tN5Mgf
	yM6ceBUVvjbQeR
X-X-Sender: gene099@racer.site
In-Reply-To: <47A87DDC.5030708@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72669>

Hi,

On Tue, 5 Feb 2008, Paolo Bonzini wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 5 Feb 2008, Paolo Bonzini wrote:
> > 
> > > The hook is not suppressed by the --no-verify option, and the exit 
> > > status is ignored by git.
> > 
> > Umm.  Should the exit status really be ignored?  What _use_ would it 
> > be then?
> 
> None; in the previous version I used an exit status of 1 to kill the 
> commit. But since this hook, unlike others, is meant to prepare things 
> for the user, the hook itself was not suppressed by --no-verify, only 
> checking the exit status.  Junio thought it was a mess, so I now 
> completely ignore the exit status.
> 
> I just wrote the above sentence because prepare-commit-msg is the only 
> git-commit hook whose exit status is ignored.

I might be missing something, but should this not be solved by having the 
prepare-commit-msg exit 0?  I mean, it is conceivable that such a bad 
error occurs in the hook that the commit should be stopped then and there.

Ciao,
Dscho
