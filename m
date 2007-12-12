From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What to do if git-cvsimport/cvsps hangs?
Date: Wed, 12 Dec 2007 16:58:25 +0100
Message-ID: <47600521.7080604@alum.mit.edu>
References: <824peojm4g.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TyZ-0007gR-LP
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbXLLP5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXLLP5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:57:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38192 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbXLLP5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:57:24 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id lBCFvKNM002769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 16:57:21 +0100
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <824peojm4g.fsf@mid.bfk.de>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68059>

Florian Weimer wrote:
> This is probably more of a cvsps question than a GIT question, but
> AFAICT, the cvsps upstream is mostly inactive these days.
> 
> I tried to import the PostgreSQL repository, using
> 
>   git-cvsimport  -d :pserver:anoncvs@anoncvs.postgresql.org:/projects/cvsroot -k -C pgsql pgsql
> 
> However, after a bit of activity, git-cvsimport hangs at the following
> line [...]
> 
> Is there some kind of replacement for cvsps which works more reliably?

Yes, cvs2svn, which can now also output to git.  But note: cvs2svn only
supports one-time conversions (not incremental), you need to use the
trunk version of cvs2svn, and using it to convert to git is not yet
documented very well.  See the following thread:

http://marc.info/?l=git&m=118592701426175&w=4

Please let us know how it goes!

Michael
