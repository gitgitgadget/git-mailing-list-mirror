From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Best way to merge two repos with same content, differenthistory
Date: Fri, 19 Jun 2009 11:52:59 +0200
Message-ID: <4A3B5FFB.1030001@alum.mit.edu>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com> <robbat2-20090605T183716-227340397Z@orbis-terrarum.net> <63BEA5E623E09F4D92233FB12A9F794303117DCB@emailmn.mqsoftware.com> <robbat2-20090605T194802-473902673Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 11:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHamf-0005x6-6S
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 11:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbZFSJxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 05:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbZFSJxG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 05:53:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46592 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZFSJxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 05:53:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n5J9r1Hu003356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Jun 2009 11:53:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.21) Gecko/20090318 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
In-Reply-To: <robbat2-20090605T194802-473902673Z@orbis-terrarum.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121891>

Robin H. Johnson wrote:
> [Regarding cvs2git] In doing so discovered a testcase where RCSRevisionReader and
> CVSRevisionReader gave different output themselves, the latter (which is
> documented as more accurate otherwise) missing the contents of an entire
> file. It's on the cvs2svn-dev mailing list now. Tracing that first,
> thereafter comparing it to the new Git side.

In case anybody is following this, the issue that Robin found was in
release 2.2.0 of cvs2svn/cvs2git, but had already been fixed in the
current trunk version...

Conclusion 1: Please use the trunk version of cvs2git, not release
2.2.0.  Trunk is usually the most stable version available, especially
for 2git conversions.

Conclusion 2: I've really got to get around to making a new release :-/

Michael
