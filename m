From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 14:36:52 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601121436.52827.lan@ac-sw.com>
References: <43C52B1F.8020706@hogyros.de> <200601121125.33696.lan@ac-sw.com> <46a038f90601112139l2f2bde5bx15102a1afcf4ec25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 09:37:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewxx7-0002kY-NP
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 09:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWALIg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 03:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWALIg7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 03:36:59 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:13030 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030325AbWALIg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 03:36:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id EE56DBD2B;
	Thu, 12 Jan 2006 14:36:56 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16501-08; Thu, 12 Jan 2006 14:36:54 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 99D1DBD24;
	Thu, 12 Jan 2006 14:36:54 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 95CAD8E34270; Thu, 12 Jan 2006 14:36:54 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 16AFC8E33F0E;
	Thu, 12 Jan 2006 14:36:53 +0600 (NOVT)
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <46a038f90601112139l2f2bde5bx15102a1afcf4ec25@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14552>

> > 1. I need to have ability to make tags, branches thru all subprojects.
>
> I suspect that this is a bad idea -- for the same reason as committing
> to a subproject is a bad idea. The subprojects most likely have their
> own external repositories -- and lifecycles of their own. The same
> headname/branchname won't do.

This is one main idea of supporing subprojects. Everything else I already can 
do. I want to be able to make tag over composite project and be able to fetch 
tagged files later. The same with branches.

I cleary understand if I made tag/branch on subproject outside my composite 
project I will not be able to work with it - this is ok.

But tag/branches on whole composite project is "the must".

I hope it is possible to teach git (or may be something else) to scan all 
subprojects and fetch common tags/branches and work with them.
