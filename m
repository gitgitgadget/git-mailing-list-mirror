From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 16:25:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:28:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuTj-0005Sw-09
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbZDTOZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755778AbZDTOZm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:25:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755464AbZDTOZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:25:41 -0400
Received: (qmail invoked by alias); 20 Apr 2009 14:25:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 20 Apr 2009 16:25:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oPSgxXoVofcvCiagC//QHAeVmZQaUlbHFyc/1+H
	V8pkBmMmc1fP8g
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090420132414.GD25059@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116991>

Hi,

On Mon, 20 Apr 2009, Dmitry Potapov wrote:

> When you create a new commit, it is always belong to _one_ branch and 
> never to two or more branches.

Certainly you forgot about detached HEADs?  And about the ability to 
create new branches which point to the _exact_ same commit as other 
branches?  And about the option to delete the original branch, not 
removing the commit, or the other branches, at all?

No, this all shows: we _have_ a different branch model from most other 
VCSes, and we _obviously_ make that not clear enough.

Meaning, we should point out that our branches are different, _and_ we 
should describe the light-weighted nature of them better in our 
documentation (especially the tutorials).

Ciao,
Dscho
