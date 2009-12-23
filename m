From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads 
 within branch
Date: Wed, 23 Dec 2009 14:28:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912231425440.4985@pacific.mpi-cbg.de>
References: <20091222222032.GU30538@dr-wily.mit.edu>  <20091222222316.GY30538@dr-wily.mit.edu>  <7vzl5awpf1.fsf@alter.siamese.dyndns.org> <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1915101267-1261574894=:4985"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 14:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNRBW-0006C0-G8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 14:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZLWNXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 08:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZLWNXV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 08:23:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:59104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752422AbZLWNXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 08:23:20 -0500
Received: (qmail invoked by alias); 23 Dec 2009 13:23:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 23 Dec 2009 14:23:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L1jhV3cgLMp3KJGwhAqVTjCfMmGc493qfce3Azj
	kEOQZkj7z9LQeu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135620>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1915101267-1261574894=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Dec 2009, Greg Price wrote:

> On Tue, Dec 22, 2009 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >  - This seems to rewrite only branch heads; don't you want to allow 
> > users  to rewrite lightweight tags and possibly annotated ones as 
> > well, by  perhaps giving "--rewrite-refs=refs/heads/" or 
> > "--rewrite-refs=refs/"  to limit what parts of the ref namespace to 
> > consider rewriting?
> 
> Sure.  I specifically left out tags because I generally think of a tag 
> as something immutable that it would not make sense to rewrite.

I do agree: if you plan to rewrite a ref, you _should_ make it a branch 
anyway.

A tag is not meant to be updated easily, in fact, we explicitely lack 
tools to do so (and it is quite hard to get updated tags from a repository 
where the tags changed anyway).  So rewriting tags is something that 
causes only trouble.

Why should rebase -i cause that trouble all of a sudden?

Ciao,
Dscho
--8323328-1915101267-1261574894=:4985--
