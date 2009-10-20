From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 11:53:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910201149020.4985@pacific.mpi-cbg.de>
References: <hbi4mt$tjt$1@ger.gmane.org>  <7vzl7mr1f5.fsf@alter.siamese.dyndns.org> <bdca99240910200156x48511478w9eaa2239eb8342b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 11:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0BMG-0003Fz-5a
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbZJTJuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 05:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbZJTJuI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:50:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:51289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbZJTJuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 05:50:07 -0400
Received: (qmail invoked by alias); 20 Oct 2009 09:50:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 20 Oct 2009 11:50:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rz3d+DiRrF9hWSiAD9M0sWQI+IoUyYhFQ58w/HU
	LHckWgCpgxiEAh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bdca99240910200156x48511478w9eaa2239eb8342b4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130781>

Hi,

On Tue, 20 Oct 2009, Sebastian Schuberth wrote:

> On Tue, Oct 20, 2009 at 09:04, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >> When compiling with MSVC on x86-compatible, use an intrinsic for byte 
> >> swapping. In contrast to the GCC path, we do not prefer inline 
> >> assembly here as it is not supported for the x64 platform.
> >>
> >> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> >
> > Unlike the other one this is not Acked by Marius, Dscho, or J6t; 
> > should I pick this up myself, or should I wait to be fed by one of 
> > msysgit people?
> 
> Well, in fact I am one of the msysgit poeple, although I mostly worked 
> on the installer until now. In general, I like my patches to be 
> reviewed, but this one is rather uncritical, I guess. So it's up to you, 
> Junio, I'm perfectly OK with waiting for an ACK.

Apart from the fact that I do not have MSVC (and I don't want it, either), 
there is another strong reason why I think Sebastian does not need ACKs or 
SOBs on MSVC patches: he has plenty of experience as a maintainer of a 
rather big (commercial) software that has to compile on Windows, MacOSX 
and several Unix-type OSes (and it is known that Sebastian is a Windows 
guy).

So I would trust Sebastian's patches (at least when it comes to MSVC) 
without even reviewing them.

Ciao,
Dscho
