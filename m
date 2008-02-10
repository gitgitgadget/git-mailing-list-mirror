From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 06:45:31 +0100
Message-ID: <200802100645.32743.robin.rosenberg.lists@dewire.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com> <47AA0FD8.1050801@catalyst.net.nz> <loom.20080210T033717-237@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Derek Mahar <derek.mahar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 06:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO511-0005uH-UH
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 06:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYBJFpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 00:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYBJFph
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 00:45:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10801 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbYBJFph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 00:45:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 69FCD8006AB;
	Sun, 10 Feb 2008 06:45:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dawQZb+cUtiX; Sun, 10 Feb 2008 06:45:35 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id E98F5800687;
	Sun, 10 Feb 2008 06:45:34 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <loom.20080210T033717-237@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73317>

s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> How do you get git-cvsimport to avoid the "duplicate" commit that it =
creates
> when it imports a commit that you "landed" in CVS with git-cvsexportc=
ommit?  I
> call this commit a duplicate because though it has a different SHA1 i=
dentifier,
> commit timestamp, and even committer email address, it refers to the =
same tree
> identifier as the landed commit.  However, because it has the same te=
xtual
> difference as the landed commit, the duplicate commit introduces no n=
ew textual
> difference.  It is essentially an "empty" commit.  Do you just accept=
 and ignore
> this empty commit?

git rebase will drop those "empty" commits by default and you'll end up=
 with the
cvs-imported version.

-- robin
