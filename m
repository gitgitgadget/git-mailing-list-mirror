From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Lock binairy files in Git
Date: Wed, 4 Mar 2009 15:15:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903041512110.8549@intel-tinevez-2-302>
References: <1236175008046-2422894.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeruB-0008Al-7B
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 15:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbZCDOPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbZCDOPc
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 09:15:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:36889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752373AbZCDOPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 09:15:31 -0500
Received: (qmail invoked by alias); 04 Mar 2009 14:15:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 04 Mar 2009 15:15:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5F41E39j5xwNq0zrjcq1RFy6VvEWF8NvEQhs+qD
	JwoVEhvFtXyoN2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236175008046-2422894.post@n2.nabble.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112214>

Hi,

On Wed, 4 Mar 2009, Henk wrote:

> In our current version control system we lock binairy files when we edit
> them. This way other developers know when a file is being edited.

No, you cannot.  Git is distributed, and therefore what you want is 
fundamentally impossible.

You can write hooks, however, enforcing "locks", and make your users 
install them.

But due to the fundamental impossibility of the thing, you have to risk 
that this scenario fails.

It might be better to come up with a non-tool solution to the problem, 
i.e. appointing people responsible for a certain set of your binary files.  
That is outside the purview of Git, though.

Ciao,
Dscho
