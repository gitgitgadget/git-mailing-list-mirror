From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git "manifest" command
Date: Tue, 5 Jun 2007 19:11:08 +0200
Message-ID: <20070605171108.GB21708@moooo.ath.cx>
References: <slrnf6ad74.4vk.csaba-ml@beastie.creo.hu> <20070605114454.GI16637@admingilde.org> <slrnf6al3s.4vk.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcYw-00027Y-8b
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 19:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXFERLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 13:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759928AbXFERLM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 13:11:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:35388 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751724AbXFERLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 13:11:11 -0400
Received: (qmail invoked by alias); 05 Jun 2007 17:11:09 -0000
Received: from pD9EBB5EC.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp057) with SMTP; 05 Jun 2007 19:11:09 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19PmMg7sIBPVI7lyuw9QAbs3R1mzSLi/uMs3ruhxR
	/wCz6ILDxVuTzE
Content-Disposition: inline
In-Reply-To: <slrnf6al3s.4vk.csaba-ml@beastie.creo.hu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49210>

Csaba Henk <csaba-ml@creo.hu> wrote:
> On 2007-06-05, Martin Waitz <tali@admingilde.org> wrote:
> > like git ls-tree -r?
> 
> Yes. I knew this functionality must be there somewehere...

If you use this from a script note that ls-tree shows the subdirectory
of a tree that corresponds to the current directory in the repository.
This one should always show the full tree:
    $ git ls-tree --full-name -r HEAD $(git rev-parse --show-cdup)
