From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/4] git log -g --pretty=format: learns about
 reflog
Date: Thu, 26 Feb 2009 11:30:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261125230.6258@intel-tinevez-2-302>
References: <cover.1235622145.git.deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdWf-0002l5-8C
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZBZKaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZBZKaF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:30:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:33360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753096AbZBZKaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:30:04 -0500
Received: (qmail invoked by alias); 26 Feb 2009 10:30:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 26 Feb 2009 11:30:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XwidH3NtXuuAd5an5RAcPsPY0aITrXEcPA6wuxf
	butszBX+wAb+KX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111549>

Hi,

On Wed, 25 Feb 2009, Deskin Miller wrote:

> I strongly suspect that there's a cleaner way to do this, but don't 
> really know what that would be, so any comments regarding alternate 
> approaches would be very appreciated.  Also, I'm more than happy to 
> write testcases and documentation once there is some agreement about 
> what the preferred implementation is.

>From skimming your mail, I am not quite sure if I understand correctly 
what you want to do.  Is it that you want to be able to output the 
"Reflog:" and "Reflog message:" information that "git log -g" prints?

If so, I suggest expanding the signature of format_commit_message.

Even better: define a "struct format_commit_options" a pointer to 
which gets passed around, and which should make the code cleaner 
anyway.

You could then put a pointer to the reflog_info into that struct.

Ciao,
Dscho
