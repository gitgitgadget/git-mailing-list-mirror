From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/5] revision caching documentation: man page and
 technical discussion
Date: Sat, 08 Aug 2009 09:58:14 +1200
Message-ID: <1249682294.6221.2.camel@maia.lan>
References: <op.ux8i6lq9tdk399@sirnot.private> <4A7B9ACA.1060601@vilain.net>
	 <4A7C18F2.2000905@dawes.za.net>
	 <alpine.DEB.1.00.0908071419590.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <discard@dawes.za.net>, Nick Edelen <sirnot@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZXQH-0002vp-Bg
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 23:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZHGV4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZHGV4S
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 17:56:18 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47484 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbZHGV4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 17:56:17 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id AF5B321C47C; Sat,  8 Aug 2009 09:56:17 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id E9EA821C32F;
	Sat,  8 Aug 2009 09:56:12 +1200 (NZST)
In-Reply-To: <alpine.DEB.1.00.0908071419590.8306@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125231>

On Fri, 2009-08-07 at 14:20 +0200, Johannes Schindelin wrote:
> > I think the word he had in mind was "coalesce".
> As Git users typically have a quite good idea what a "merge" is, I'd 
> prefer that word anyway.

I don't like that so much, given that "merge" has quite a specific
meaning.  But not really that fussed.  In this case it's more like a
'gc' or 'repack'; an internal reshuffle of an index to make it a single
one and not many.

Sam
