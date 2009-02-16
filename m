From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Mon, 16 Feb 2009 11:41:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org> <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com> <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de> <7v1vtzf234.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0ut-00068o-7g
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbZBPKkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbZBPKkF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:40:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:53373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753495AbZBPKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:40:04 -0500
Received: (qmail invoked by alias); 16 Feb 2009 10:40:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 16 Feb 2009 11:40:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+x+h8xyaWxtsCNC5ANbH8SEo5yqIt3XBET4LWH2v
	M0nEOaBKcmuBAk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vtzf234.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110164>

Hi,

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, IMO there is a much worse issue lurking: people might want to 
> > _know_ what "@{-2}" would expand to, _without_ switching branches.
> 
> "git branch --history" anyone?

For a moment, you had me convinced it already exists, and I only 
understood after "git grep history builtin-branch.c" came up empty.

;-)

Ciao,
Dscho
