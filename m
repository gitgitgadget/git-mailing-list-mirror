From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Extra metadata in the commit?
Date: Sat, 25 Apr 2009 01:55:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904250154080.10279@pacific.mpi-cbg.de>
References: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVGT-0007br-7f
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbZDXXy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZDXXy6
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:54:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:33984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750733AbZDXXy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:54:57 -0400
Received: (qmail invoked by alias); 24 Apr 2009 23:54:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 25 Apr 2009 01:54:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eJzdNb2Uel88BXnoPZ2bMMqs0J7UanP2f1Lh2GD
	4lBnRzpGF05uFZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117524>

Hi,

On Fri, 24 Apr 2009, Scott Chacon wrote:

> I'm working on a hg<->git bidirectional tool using Git as the 
> communication protocol, so there is a bunch of Hg metadata that I need 
> to keep in Git to ensure I can convert commits created in Hg back into 
> the exact same objects after they upload to the Git db and then come 
> back down.  This means storing explicit rename info, branch names, etc 
> somewhere without messing up Git clients that want to work on the same 
> repo.  So, I can keep this data in the commit message, but I thought it 
> would be cleaner to keep it as extra fields in the commit object before 
> the "\n\n" separator.

I'd suggest keeping it in the commit body, for better visibility and 
easier handling by tools.

Ciao,
Dscho
