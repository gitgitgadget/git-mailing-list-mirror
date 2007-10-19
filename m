From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing	objects'
Date: Fri, 19 Oct 2007 15:55:30 +1300
Message-ID: <47181CA2.5010605@vilain.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <47181430.2080907@vilain.net> <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com> <20071019023645.GC8298@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iii1e-0004bH-I9
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbXJSCzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758983AbXJSCzj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:55:39 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48549 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbXJSCzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:55:38 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id E6221205ACC; Fri, 19 Oct 2007 15:55:36 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 4D65B21CFDB;
	Fri, 19 Oct 2007 15:55:32 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20071019023645.GC8298@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61618>

Jeff King wrote:
> On Fri, Oct 19, 2007 at 12:24:44PM +1000, David Symonds wrote:
> 
>> Forward thinking, that's probably most sensible, since git 4.7 might
>> not use delta compression, but maybe wavelet compression, or other
>> scheme entirely. Using deltas is an implementation detail, after all.
> 
> Git already uses two types of compression (zlib on all objects, deltas
> between objects in packfiles). So just saying "compressing" is actually
> a bit ambiguous, and I think noting that what we are _actually_ doing
> right now is delta compression is worthwhile.

True.  But then, zlib compression is also delta compressing and huffman
coding.  Git's delta compression is quite similar; it just uses a larger
window than the sliding 64k gzip one.

Sam.`
