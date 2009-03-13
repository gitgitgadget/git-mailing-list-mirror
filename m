From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 17:36:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de> <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <alturin@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 13 17:38:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiAOY-0007WJ-Cg
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 17:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759579AbZCMQgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759922AbZCMQgT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 12:36:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:33120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759934AbZCMQgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 12:36:18 -0400
Received: (qmail invoked by alias); 13 Mar 2009 16:36:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 13 Mar 2009 17:36:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fFhxG9U/f4tVIJZO4KsyfNs6E6+tPZTnUarGwrJ
	62PeS185FMWAud
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113207>

Hi,

On Fri, 13 Mar 2009, Johannes Schindelin wrote:

> The earlier code meant to attempt to strip everything except the test
> number, but only stripped the part starting with the last dash.
> 
> However, there is no reason why we should not use the whole basename.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Even if this is not strictly necessary after Hannes' test cleanup, 
> 	it would still be nice.

Just to clarify: it fixes the issue that these two tests share the same 
file in test-results/: t5521-pull-options.sh  t5521-pull-symlink.sh

As a consequence, one's results overwrite the other one's.

Ciao,
Dscho
