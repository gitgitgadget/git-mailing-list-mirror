From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git exclude patterns for directory
Date: Tue, 19 Jun 2007 22:34:49 +0200
Message-ID: <20070619203449.GB4180@steel.home>
References: <20070619200821.GA16423@camelot>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jimmy bahuleyan <jimmy.cancer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0kPg-0004ao-KC
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764976AbXFSUex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXFSUew
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 16:34:52 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:41704 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbXFSUew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 16:34:52 -0400
Received: from tigra.home (Faad5.f.strato-dslnet.de [195.4.170.213])
	by post.webmailer.de (mrclete mo47) (RZmta 7.4)
	with ESMTP id K05514j5JJ9PI7 ; Tue, 19 Jun 2007 22:34:50 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 32118277BD;
	Tue, 19 Jun 2007 22:34:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0EEECC164; Tue, 19 Jun 2007 22:34:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070619200821.GA16423@camelot>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopJuBo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50506>

jimmy bahuleyan, Tue, Jun 19, 2007 22:08:21 +0200:
> Is there a way where I could specify a pattern in .git/info/exclude that
> would make git ignore directories.

put it in .gitignore in the top-level directory (just the "IGNORE").
.gitignore works recursively.
