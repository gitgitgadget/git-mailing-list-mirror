From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH/UTF-8] gitk: properly deal with tag names containing /
	(slash)
Date: Tue, 12 Feb 2008 13:21:12 +1100
Message-ID: <18353.664.502848.772753@cargo.ozlabs.ibm.com>
References: <20080206070608.6881.qmail@096465580ae94c.315fe32.mid.smarden.org>
	<7vtzkm35d1.fsf@gitster.siamese.dyndns.org>
	<20080207093415.13241.qmail@945a2ee23beef0.315fe32.mid.smarden.org>
	<20080211105741.16353.qmail@d33cfe7d8389ec.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 03:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlLh-0004Gy-7X
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 03:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbYBLC5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 21:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYBLC5r
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 21:57:47 -0500
Received: from ozlabs.org ([203.10.76.45]:57810 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095AbYBLC5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 21:57:46 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A33B0DDE45; Tue, 12 Feb 2008 13:57:45 +1100 (EST)
In-Reply-To: <20080211105741.16353.qmail@d33cfe7d8389ec.315fe32.mid.smarden.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73621>

Gerrit Pape writes:

> When creating a tag through gitk, and the tag name includes a slash (or
> slashes), gitk errors out in a popup window.  This patch makes gitk use
> 'git tag' to create the tag instead of modifying files in refs/tags/,
> which fixes the issue; if 'git tag' throws an error, gitk pops up with
> the error message.

Thanks, applied.

Paul.
