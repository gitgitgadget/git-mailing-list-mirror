From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Setting SVN properties with git-svn, and removing empty
	directories
Date: Sat, 23 Feb 2008 19:18:40 +0100
Message-ID: <20080223181840.GA30325@atjola.homenet>
References: <799406d60802230938s559168f8lc9b1f640f2c07fee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSyxz-0005tu-J1
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYBWSSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYBWSSo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:18:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:43128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753547AbYBWSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 13:18:43 -0500
Received: (qmail invoked by alias); 23 Feb 2008 18:18:41 -0000
Received: from i577B98AA.versanet.de (EHLO atjola.local) [87.123.152.170]
  by mail.gmx.net (mp035) with SMTP; 23 Feb 2008 19:18:41 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18aCR0gFD4awQv1GpT8BrQIJeDMRQFCyX1Jub2L7a
	U8HVACNjK9RmUn
Content-Disposition: inline
In-Reply-To: <799406d60802230938s559168f8lc9b1f640f2c07fee@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74832>

On 2008.02.23 12:38:03 -0500, Adam Mercer wrote:
> 2) Whenever I delete a directory using git-svn and merge my changes t=
o
> the upstream svn repository using "git svn dcommit" the directories i=
n
> question are removed from the git repository but only the contents of
> these directories are removed from the svn repository, the directorie=
s
> themselves remain. Is there a way to ensure that these directories ar=
e
> removed from the svn repository?

Acccording to the man page, you can pass --rmdir to dcommit or set
svn.rmdir in the configuration to have git-svn delete empty directories
in the SVN repo.

Bj=F6rn
