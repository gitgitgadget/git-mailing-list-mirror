From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/6 (v4)] full integration of rev-cache into git,
 completed test suite
Date: Tue, 08 Sep 2009 09:06:04 +1200
Message-ID: <1252357564.5969.4.camel@maia.lan>
References: <op.uys3quhbtdk399@sirnot.private>
	 <op.uyuwkuoxtdk399@sirnot.private> <op.uyzwycxotdk399@sirnot>
	 <op.uzv4covmtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain
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
X-From: git-owner@vger.kernel.org Mon Sep 07 23:06:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MklQO-000407-1U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 23:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbZIGVGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 17:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZIGVGF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 17:06:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43592 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbZIGVGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 17:06:02 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9A8A621C351; Tue,  8 Sep 2009 09:06:03 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 5DC3B21C2D1;
	Tue,  8 Sep 2009 09:05:57 +1200 (NZST)
In-Reply-To: <op.uzv4covmtdk399@sirnot.private>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127947>

On Mon, 2009-09-07 at 16:11 +0200, Nick Edelen wrote:
> This last patch 

^^ You don't need to write comments like "This patch"; in the history
such words are meaningless.

> provides a working integration of rev-cache into the revision 
> walker, along with some touch-ups:
>  - integration into revision walker and list-objects
>  - tweak of object generation

"tweak" ?

>  - more fluid handling of damaged cache slices

What does this mean?

>  - numerous tests for both features from the previous patch, and the 
> integration's integrity
> 'Integration' is rather broad -- a more detailed description follows for each 
> aspect:
>  - rev-cache
> the traversal mechanism is updated to handle many of the non-prune options 
> rev-list does (date limiting, slop-handling, etc.), and is adjusted to allow 
> for non-fatal cache-traversal failures.
> 
>  - revision walker
> both limited and unlimited traversal attempt to use the cache when possible, 
> smoothly falling back if it's not.
> 
>  - list-objects
> object listing does not recurse into cached trees, and has been adjusted to 
> guarantee commit-tag-tree-blob ordering.

This is quite a long commit message.  Is the above detail all useful?
Can it be split into one patch for each of the above integrations?

> Signed-off-by: Nick Edelen <sirnot@gmail.com>

Sam
