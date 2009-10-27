From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: more graceful handling of invalid commands
Date: Tue, 27 Oct 2009 15:17:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271517180.11562@felix-maschine>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com> <20091027133932.60b996c3@perceptron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-374944561-1256653052=:11562"
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mrk-0003Vk-3M
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZJ0OR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbZJ0OR3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:17:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:56070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752646AbZJ0OR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:17:28 -0400
Received: (qmail invoked by alias); 27 Oct 2009 14:17:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO felix-maschine.local) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 27 Oct 2009 15:17:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18crApZC+ocvMP/pH5V4lX/qK4eEBRdV3d9OQvFmO
	Hhs7ct3CO2fUUg
X-X-Sender: johannes@felix-maschine
In-Reply-To: <20091027133932.60b996c3@perceptron>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131341>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-374944561-1256653052=:11562
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Oct 2009, Jan Krüger wrote:

> Currently, when there is an invalid command, the rest of the line is
> still treated as if the command had been valid, i.e. rebase -i attempts
> to produce a patch, using the next argument as a SHA1 name. If there is
> no next argument or an invalid one, very confusing error messages
> appear (the line was '.'; path to git-rebase-todo substituted):
> 
> Unknown command: .
> fatal: ambiguous argument 'Please fix this in the file $somefile.':
> unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> fatal: Not a valid object name Please fix this in the file $somefile.
> fatal: bad revision 'Please fix this in the file $somefile.'
> 
> Instead, verify the validity of the remaining line and error out earlier
> if necessary.
> 
> Signed-off-by: Jan Krüger <jk@jk.gs>

ACK,
Dscho
--8323329-374944561-1256653052=:11562--
