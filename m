From: Jaap Eldering <eldering@a-eskwadraat.nl>
Subject: Re: git subtree push mangles commit message newlines
Date: Thu, 18 Jul 2013 23:51:12 +0200
Message-ID: <20130718215112.GD22040@a-eskwadraat.nl>
References: <20130718212233.GB22040@a-eskwadraat.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzw6X-00045E-VT
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933853Ab3GRVvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:51:14 -0400
Received: from square.phys.uu.nl ([131.211.39.72]:62117 "EHLO
	square.phys.uu.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759416Ab3GRVvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=a-eskwadraat.nl; s=alef;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=gC+honx173zmQttkWzbZIF7u0hxbP/a2XSKK3t8lERg=;
	b=CYBcH4bC6ocMPP3Xf7AfisCIiBFZWodLX6N6gSrXQl0rqY0LjY9U8yDj9hRfi3YwJ8566OpaeYiWUvkIaos82AtAFP9rNd1S0xBAtyyTYJPfCaVA6TMLv68Q2i9fhxT1ZUUOmxbAwEZ29ZflpthVmcWZ7ZGSUhyCLCokyAiRxlk=;
Received: from nikola.localdomain ([10.14.0.2])
	by square.phys.uu.nl with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <eldering@A-Eskwadraat.nl>)
	id 1Uzw6S-0006TF-O5
	for git@vger.kernel.org; Thu, 18 Jul 2013 23:51:12 +0200
Received: from eldering by nikola.localdomain with local (Exim 4.72)
	(envelope-from <eldering@A-Eskwadraat.nl>)
	id 1Uzw6S-0006fH-Kj
	for git@vger.kernel.org; Thu, 18 Jul 2013 23:51:12 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130718212233.GB22040@a-eskwadraat.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230756>

Never mind, this is already fixed in a5b8e28e4eb. Sorry for the noise.

Jaap


On Thu, Jul 18, 2013 at 11:22:33PM +0200, Jaap Eldering wrote:
> Hi all,
> 
> I recently started using git-subtree and ran into a small issue when
> pushing to the subtree repository: newlines in the commit message seem
> not to be preserved.
> 
> I was using git-subtree from [1], but can also reproduce this with the
> version from the main git source-tree commit 634392b26275fe, and I
> don't see any changes that could affect this behaviour since then.
> 
> Best,
> Jaap
> 
> [1] https://github.com/helmo/git/tree/subtree-updates/contrib/subtree
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
