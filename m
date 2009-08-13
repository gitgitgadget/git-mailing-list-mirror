From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git stash: Give friendlier errors when there is nothing to apply
Date: Thu, 13 Aug 2009 09:35:50 +0200
Message-ID: <200908130935.51470.trast@student.ethz.ch>
References: <200908111409.04506.trast@student.ethz.ch> <4a81787d.0e0f660a.5238.4c8b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Thu Aug 13 09:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbUrB-0002NT-Ob
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 09:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZHMHgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 03:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZHMHgH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 03:36:07 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:52815 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbZHMHgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 03:36:06 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 09:36:06 +0200
Received: from thomas.localnet (129.132.210.214) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 09:36:06 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <4a81787d.0e0f660a.5238.4c8b@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125790>

Ori Avtalion wrote:
> The change makes sure a stash (given or default) exists before
> checking if the working tree is dirty.
> 
> If the default stash is requested, the old message was scary and
> included a 'fatal' error from rev-parse:
>      fatal: Needed a single revision
>      : no valid stashed state found
> 
> It is replaced with a friendlier 'Nothing to apply' error, similar to
> 'git stash branch'.
> 
> If a specific stash is specified, the 'Needed a single revision' errors
> from rev-parse are suppressed.
> 
> Signed-off-by: Ori Avtalion <ori@avtalion.name>
> ---
> 
> Thomas, I added handling for the 'git stash apply <stash>' case based
> on your reminder, and also changed the error messages related to it.
> 
> All of the stash tests pass, as before.

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
