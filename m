From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 12 Feb 2009 22:51:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902122251120.10279@pacific.mpi-cbg.de>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com> <20090130045131.GB18655@coredump.intra.peff.net> <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
 <7vr62j0wpc.fsf@gitster.siamese.dyndns.org> <7v3aekqhpo.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902121200420.10279@pacific.mpi-cbg.de> <7vzlgrjrjz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjTf-0000vP-Ha
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbZBLVul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758072AbZBLVul
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:50:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:48328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756980AbZBLVuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:50:40 -0500
Received: (qmail invoked by alias); 12 Feb 2009 21:50:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 12 Feb 2009 22:50:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/md8la5Zfm1y6UX5baVb2WvWUJayjRwkHIcZLq4F
	N4zWkVS4drXbtP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vzlgrjrjz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109668>

Hi,

On Thu, 12 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> diff --git a/builtin-clone.c b/builtin-clone.c
> >> index f73029e..431c136 100644
> >> --- a/builtin-clone.c
> >> +++ b/builtin-clone.c
> >> @@ -350,6 +350,18 @@ static struct ref *write_remote_refs(const struct ref *refs,
> >>  	return local_refs;
> >>  }
> >>  
> >> +static void install_branch_config(const char *origin, const char *local,
> >> +				  const char *remote)
> >
> > I would have used a different order (local, origin, remote), but that's 
> > okay, I guess.
> 
> Ok, here is an incremental that will be squashed.

Thanks, very much appreciated,
Dscho
