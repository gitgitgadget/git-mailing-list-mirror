From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] rebase simplifications
Date: Wed, 28 Jan 2009 00:10:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280010140.3586@pacific.mpi-cbg.de>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901272323530.3586@pacific.mpi-cbg.de> <7vab9c1hyp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx5t-0006wc-Al
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZA0XKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZA0XKU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:10:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:42740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750854AbZA0XKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:10:19 -0500
Received: (qmail invoked by alias); 27 Jan 2009 23:10:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 28 Jan 2009 00:10:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+e/roFzGaePlhAh5I5lsYG3ukWu3ExbrLCGlcRQv
	opQ84Xg5AzxPHn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab9c1hyp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107422>

Hi,

On Tue, 27 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Changes vs  v1:
> >
> > removed the "rnyn" blurt (which probably marsk me as Alpine user...)
> >
> > removed the SHELL_PATH handling; it is a miracle to me why it works, but 
> > I'd rather not meddle with the magic now that you pointed it out
> >
> > Moved test_commit and test_merge into test-lib.sh
> >
> > Fixed the quoting in test_commit and test_merge
> >
> > AFAIR that's all...

Oh, I forgot the ${2:-...} thing...

> Thanks; looks much nicer (not just relative to v1 but compared to the 
> original).

Thanks!

Ciao,
Dscho
