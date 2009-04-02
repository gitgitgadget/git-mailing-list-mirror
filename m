From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git clone --depth <depth>" producing history with <depth + 1>
 commits?
Date: Thu, 2 Apr 2009 03:04:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de>
References: <49CBB490.8040908@hartwork.org> <49D3C300.1040303@hartwork.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 03:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpBLr-0007Xi-Cu
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 03:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbZDBBCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 21:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbZDBBCj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 21:02:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:46331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750886AbZDBBCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 21:02:38 -0400
Received: (qmail invoked by alias); 02 Apr 2009 01:02:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 02 Apr 2009 03:02:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183ektwxho3Pt066EwglNTswicuxndrfqiJrBcNdn
	5TA3FK1qIFmCz2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49D3C300.1040303@hartwork.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115428>

Hi,

On Wed, 1 Apr 2009, Sebastian Pipping wrote:

> Sebastian Pipping wrote:
> > Is "git clone --depth 1 <ropository>" expected to give a history
> > with 2 commits?  "--depth 2" gives 3 commits, "--depth 0" all.
> > 
> > Is that by design or a bug?
> 
> Anyone?  Is "git clone --depth 1 <ropository>" really supposed to 
> produce a history holding _two_ commits?  Why so?

Because storing _no_ commit (according to you, that should happen with 
--depth=0) would make no sense?

After all, if you want to clone, you want to clone at least _something_.

Ciao,
Dscho
