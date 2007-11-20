From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: quilt/0.46-1 misbehaviour...
Date: Tue, 20 Nov 2007 19:34:02 +0100
Message-ID: <20071120183402.GC3461@steel.home>
References: <20071120055149.GQ6372@mea-ext.zmailer.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:34:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXvg-0004WG-IG
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763756AbXKTSeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763758AbXKTSeI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:34:08 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61378 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763624AbXKTSeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:34:06 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ8+A==
Received: from tigra.home (Fad1d.f.strato-dslnet.de [195.4.173.29])
	by post.webmailer.de (klopstock mo15) (RZmta 14.3)
	with ESMTP id U06a73jAKFWPIy ; Tue, 20 Nov 2007 19:34:02 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BE48D277AE;
	Tue, 20 Nov 2007 19:34:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9557256D22; Tue, 20 Nov 2007 19:34:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071120055149.GQ6372@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65561>

Matti Aarnio, Tue, Nov 20, 2007 06:51:49 +0100:
> .. or perhaps Exim, but odd result in arriving and thus outgoing headers anyway.
>
...
> Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")
> 
> From:	clameter@sgi.com
> From:	Christoph Lameter <clameter@sgi.com>
> To:	ak@suse.de
> Cc:	akpm@linux-foundation.org
> Cc:	travis@sgi.com
> Cc:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> Cc:	linux-kernel@vger.kernel.org
...
> Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|39031)
> Last-Attempt-Date: Mon, 19 Nov 2007 20:17:31 -0500
> Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")
...
> Date: Mon, 19 Nov 2007 17:11:41 -0800
> Subject: [rfc 09/45] cpu alloc: IA64 support
> From: clameter@sgi.com
> From: Christoph Lameter <clameter@sgi.com>
> Message-Id: <20071120011333.850453474@sgi.com>

Is this the problem: duplicate From: and quadriplicate Cc:?
