From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Tell users that git protocol is not for pushing
Date: Tue, 11 Nov 2008 08:24:55 +0100
Message-ID: <20081111072455.GA4206@blimp.localdomain>
References: <1226379976-5959-1-git-send-email-nathan.panike@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 08:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kznde-0002qc-U9
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 08:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbYKKHY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 02:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbYKKHY7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 02:24:59 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:55536 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbYKKHY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 02:24:58 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BU83pbQ=
Received: from tigra.home (Fae1e.f.strato-dslnet.de [195.4.174.30])
	by post.webmailer.de (fruni mo4) (RZmta 17.18)
	with ESMTP id h05533kAB5CEn9 ; Tue, 11 Nov 2008 08:24:56 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 3302A277C8;
	Tue, 11 Nov 2008 08:24:56 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id BB88D36D27; Tue, 11 Nov 2008 08:24:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226379976-5959-1-git-send-email-nathan.panike@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100626>

Nathan W. Panike, Tue, Nov 11, 2008 06:06:16 +0100:
> When one attempts to push to a git-protocol repository, one gets the
> line:
> 
> fatal: The remote end hung up unexpectedly
> 
> This seems a bit obscure to me.  It is better to inform the user that git://
> does not allow pushing.

But it does. See git daemon --help, look for receive-pack.
