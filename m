From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] Add support for URLs to git-apply
Date: Sun, 9 Dec 2007 18:02:50 +0100
Organization: glandium.org
Message-ID: <20071209170250.GA18955@glandium.org>
References: <1197194672-28568-1-git-send-email-mh@glandium.org> <1197194672-28568-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 18:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1PYg-0007lP-Qn
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbXLIRCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXLIRCx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:02:53 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:41651 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbXLIRCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:02:52 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 7399570000C2
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 18:02:51 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 5781C70000C1;
	Sun,  9 Dec 2007 18:02:51 +0100 (CET)
X-ME-UUID: 20071209170251358.5781C70000C1@mwinf2816.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1PYI-0004zt-QT; Sun, 09 Dec 2007 18:02:50 +0100
Content-Disposition: inline
In-Reply-To: <1197194672-28568-2-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67629>

On Sun, Dec 09, 2007 at 11:04:32AM +0100, Mike Hommey wrote:
> Instead of doing several "wget -O - url | git-apply -" in a raw, you now
> can just git-apply url1 url2 ...
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
> 
> After spending an afternoon wgetting patches to applying them, I got fed up
> and just added basic url support to git-apply. Note that the fwrite_strbuf
> function should just live in http.c, but until the http api is fully switched
> to use strbufs instead of its struct buffer (which I'm planning to do), it
> can stay like this.

I'm going to resend these 2 patches, with some others that do some changes
to the http code.

Mike
