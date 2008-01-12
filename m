From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 01:40:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org> <200801120115.41274.robin.rosenberg@dewire.com> <191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org>
 <7v7iif28i2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:40:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUQY-0006RS-Fl
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762650AbYALAkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762647AbYALAkS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:40:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762640AbYALAkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:40:17 -0500
Received: (qmail invoked by alias); 12 Jan 2008 00:40:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp001) with SMTP; 12 Jan 2008 01:40:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L/a48pbkLNcs11RH/FFEtUGDfseFeWJSh/8N/NY
	vC1pNtVimZRJjh
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iif28i2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70238>

Hi,

On Fri, 11 Jan 2008, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
> > Is there a reason for this? It seems like it would be trivial to end 
> > up with misdiagnosed "untracked" files when using any language other 
> > than English given this behaviuor.
> 
> No.  The assumption of the code has always been that sane filesystems 
> would return from readdir() the names you gave from creat().

We do not really have to rehash that whole discussion for the Nth time, do 
we?

Ciao,
Dscho
