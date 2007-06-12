From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] 75d8ff1 fails on SunOS 5.9 (missing hsterror) from ba505322
Date: Tue, 12 Jun 2007 22:03:07 +0200
Message-ID: <20070612200307.GB2459@steel.home>
References: <86ejkh40cr.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyCa9-0007UD-51
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 22:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXFLUDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 16:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbXFLUDL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 16:03:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:13476 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbXFLUDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 16:03:10 -0400
Received: from tigra.home (Fcad5.f.strato-dslnet.de [195.4.202.213])
	by post.webmailer.de (mrclete mo20) (RZmta 7.2)
	with ESMTP id 801450j5CGSWGH ; Tue, 12 Jun 2007 22:03:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 312C7277BD;
	Tue, 12 Jun 2007 22:03:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 51D4FD261; Tue, 12 Jun 2007 22:03:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86ejkh40cr.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj8OeQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49993>

Randal L. Schwartz, Tue, Jun 12, 2007 18:13:40 +0200:
> I suspect this broke in ba505322 when connect.c added hsterror().
> 
> Yes, bumping to g18bece works fine.  So it looks like we need a compat
> hsterror(), or it should be removed or ifdef'ed somehow.  Paging Alex Riesen?

Looks like. What have they got instead to clarify what h_errno means?
