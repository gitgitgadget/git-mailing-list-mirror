From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Tue, 31 Mar 2009 00:17:29 +0200
Message-ID: <20090330221729.GB68118@macbook.lan>
References: <20090323195304.GC26678@macbook.lan> <49C7F233.9050205@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoPow-0006kg-OM
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZC3WRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 18:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbZC3WRe
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:17:34 -0400
Received: from darksea.de ([83.133.111.250]:50305 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752211AbZC3WRd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:17:33 -0400
Received: (qmail 12588 invoked from network); 31 Mar 2009 00:17:29 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 00:17:29 +0200
Content-Disposition: inline
In-Reply-To: <49C7F233.9050205@pelagic.nl>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115195>

On Mon, Mar 23, 2009 at 09:33:55PM +0100, Ferry Huberts (Pelagic) wrote:
> maybe you can also add remarks about autocrlf and safecrlf?
> both need to be off

>From my experience thats not necessarily true. You can use
autocrlf=input to repair broken revisions were crlf's have been
mistakenly committed into the repository. And if I remember correctly
safecrlf helps if you want to make sure that no information gets lost.

So when importing from a nice correct cvs repository you would expect
safecrlf to not stop your import. And I suspect there are actually cvs
users that were very careful with their lineendings who would use it.

cheers Heiko
