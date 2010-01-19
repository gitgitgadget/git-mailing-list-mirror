From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-describe recognize modified files
Date: Tue, 19 Jan 2010 11:35:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
References: <829260.92036.qm@web45202.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: tzachi perelstein <tzachi_perelstein@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 11:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXBRA-0004pY-Mv
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 11:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab0ASKfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123Ab0ASKfr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 05:35:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:34713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752932Ab0ASKfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 05:35:44 -0500
Received: (qmail invoked by alias); 19 Jan 2010 10:35:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 19 Jan 2010 11:35:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XKpEjdfWXmjgp9se9y0US6zOSk4LBz9g5QBtk8v
	fFGEwcCv86nEVB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <829260.92036.qm@web45202.mail.sp1.yahoo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137447>

Hi,

On Tue, 19 Jan 2010, tzachi perelstein wrote:

> I use git-describe to form a build version automatically. This allows me
> to deliver temporary builds for testing without having to make manual
> tags for them. The only thing that bothers me about this is that from
> the output of git-describe I cannot tell if there are some modified
> files in tree or not. In both cases I will get the same version. 
> 
> To solve this issue, in addition to git-describe, my do_version script
> also run git-status, and if there are "modified:" files then it
> concatenates the string "+dirty" to output of git-describe.

The problem is that this does not describe the exact version you used very 
well.  If you are really serious about describing the exact state you 
described, make a tag (committing the changes to a detached HEAD first, if 
you do not want the changes in a real branch).

Ciao,
Dscho
