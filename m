From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Tue, 10 Mar 2009 20:50:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903102050090.14295@intel-tinevez-2-302>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jiri Olsa <olsajiri@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh8EA-0007JJ-Jf
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 21:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbZCJUFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbZCJUFb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 16:05:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:49689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757439AbZCJUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 16:05:29 -0400
Received: (qmail invoked by alias); 10 Mar 2009 19:51:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Mar 2009 20:51:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5lTdZ05+5AVLXwFU69Xk0xMbUuaSJgx0ZcVM5hH
	f3pYG94OZdq+8p
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112846>

Hi,

On Tue, 10 Mar 2009, Jiri Olsa wrote:

> Hi,
> 
> I was following the git core tutorial and git-read-tree got me segfault.
> I accidentaly executed the git-read-tree without "-m -u" options and
> got segfault.
> 
> I can reproduce with the latest git using following script.

I can reproduce with the script, too...

Working on it,
Dscho
