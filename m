From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Not going beyond symbolic links
Date: Tue, 5 Aug 2008 13:23:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808051322300.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7vprooysst.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 13:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQKZo-0007gb-Ox
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 13:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbYHELSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 07:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbYHELSi
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 07:18:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:37726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754230AbYHELSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 07:18:37 -0400
Received: (qmail invoked by alias); 05 Aug 2008 11:18:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 05 Aug 2008 13:18:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ud2lxpiZuI3YwQbJ3xObtElQcUhtRgxCTCX5iUt
	pZBvYB43rYzXAt
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vprooysst.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91434>

Hi,

On Mon, 4 Aug 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, please note that Junio's patch affects git-add, AFAIR, not 
> > git-update-index.
> 
> Really?  I thought I added a test case to cover the plumbing as well...

Right, I missed that one.  I kinda hoped that only porcelain is affected.

Ciao,
Dscho
