From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: va_copy is not available on all systems.
Date: Tue, 21 Aug 2007 20:37:09 +0200
Message-ID: <20070821183709.GA22102@steel.home>
References: <46C99448.2AB33DFF@eudaptics.com> <20070820191509.GB5544@steel.home> <20070821033813.GF27913@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INYbY-0003zg-E4
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 20:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760924AbXHUShQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 14:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761477AbXHUShQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 14:37:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45481 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760924AbXHUShO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 14:37:14 -0400
Received: from tigra.home (Fad89.f.strato-dslnet.de [195.4.173.137])
	by post.webmailer.de (klopstock mo59) (RZmta 10.3)
	with ESMTP id g06367j7LHwPiP ; Tue, 21 Aug 2007 20:37:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 21B7B277BD;
	Tue, 21 Aug 2007 20:37:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 875F8BE01; Tue, 21 Aug 2007 20:37:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070821033813.GF27913@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFiUp4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56321>

Shawn O. Pearce, Tue, Aug 21, 2007 05:38:14 +0200:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > Johannes Sixt, Mon, Aug 20, 2007 15:16:56 +0200:
> > > Since va_copy() must be provided by the compiler, we don't have a
> > > reasonable chance to provide a working definition in git_compat_util.h.
> > 
> > Maybe we don't have to:
> > 
> > Subject: [PATCH] Avoid using va_copy in fast-import: it seem to be unportable
> 
> Thanks Alex.  This feels more like the right solution to the problem.
> I made a few minor edits, any comment?

Like editing in my sign-off which I didn't provide :)

I actually think fprintf was less object code, but thanks to admins(*) of
my employer, I am too late anyway.

* The admins blocked gmail because of it being virus infected. Ha!
  Of course it is, it is a mailbox, for gods sake!
