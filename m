From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 16:52:01 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>  <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>  <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>  <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
 <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEp1d-0006X4-5t
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 17:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbYAOQwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYAOQwG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 11:52:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:59954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750733AbYAOQwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 11:52:05 -0500
Received: (qmail invoked by alias); 15 Jan 2008 16:52:02 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp031) with SMTP; 15 Jan 2008 17:52:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+cHsFuZF+YLPuL4WvB3W6LWeeftHQCzPD+LBgoL
	TQmPGAqVMhXwyg
X-X-Sender: user@eeepc-johanness
In-Reply-To: <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70532>

Hi,

On Tue, 15 Jan 2008, Chris Ortman wrote:

> Are you thinking to just create the standard patch but then regex 
> replace the necessary lines or something different?

I was thinking exactly that.  TortoiseSVN's diff format is not important 
enough to git to merit a core-level change (in git), but it should be easy 
enough even to write a "sed" command line with three expressions to effect 
the transformation you desire.

Ciao,
Dscho
