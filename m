From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/6 (v2)] Suggested for PU: revision caching system to
 	significantly speed up packing/walking
Date: Mon, 17 Aug 2009 11:19:46 +1200
Message-ID: <4A889412.9090209@vilain.net>
References: <op.uyb1uryftdk399@sirnot.private> <c77435a80908161547x4d2a9087qf439d1c30cc4fa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 01:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcp5g-0006as-0d
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 01:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbZHPXTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 19:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756470AbZHPXTv
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 19:19:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59615 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431AbZHPXTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 19:19:51 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 29B1D21CE53; Mon, 17 Aug 2009 11:19:51 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 635E821CE07;
	Mon, 17 Aug 2009 11:19:46 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <c77435a80908161547x4d2a9087qf439d1c30cc4fa99@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126095>

Nick Edelen wrote:
> Well crap, in my infinite wisdom I replied with the final updated
> patchset to the wrong version :-/  I don't want to clog up the list
> with my stupid mistakes, but if you need me to I can resend them to
> v3.
>   

Heh, that sure reads like a sentence written after midnight :-)

These all say v2, and the last lot was labeled as v3.  And I see an
older submission labeled as v2 (8th August) and got duplicates of those
labeled as v3.

Are the ones attached to this the ones that are the best?

Sam

> But yeah, I've uploaded an updated version.  This patchset:
>  - fixes whitespace errors
>  - adds _ondisk versions of structures to ensure portability
>  - cleans up definitions/fix a typo
>
> Hope it works out for you all.  Sorry about the mismatched reply.
>
>  - Nick
>   
