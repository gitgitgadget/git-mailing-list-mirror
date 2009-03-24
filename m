From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 24 Mar 2009 02:39:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903240238440.10279@pacific.mpi-cbg.de>
References: <49BFA97A.1030203@lanwin.de> <18887.26239.115820.450313@cargo.ozlabs.ibm.com> <49C82377.40101@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Steve Wagner <lists@lanwin.de>,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llvbh-0004i3-5K
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbZCXBhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZCXBhk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:37:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:53797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751130AbZCXBhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:37:39 -0400
Received: (qmail invoked by alias); 24 Mar 2009 01:37:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 24 Mar 2009 02:37:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X/7A/vziX3zCUwYnjGrESyxCv/5wdA5EP86Psky
	tvBQrzaF/1f56w
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49C82377.40101@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114389>

Hi,

On Tue, 24 Mar 2009, Pat Thoyts wrote:

> Paul Mackerras wrote:
> > Please try this patch and let me know if it does what you want.
> > 
> [snip]
> 
> This patch works fine on my Vista installation. The .gitk file is now 
> hidden.
> 
> An alternative that was discussed was to move it rather than hide it so 
> that it ends up in the Application Data folder along with settings for 
> other applications. The following patch does this but hits rather more 
> lines of code and ends up needing to check the original location as 
> well.

While I see your point, keep in mind that this patch would make Git for 
Windows even more incompatible with Git "In The Rest Of The World"...

Ciao,
Dscho
