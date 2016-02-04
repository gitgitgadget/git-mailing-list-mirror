From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 14:06:09 +0000
Message-ID: <20160204140609.GH29880@serenity.lan>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
 <20160204121437.GF29880@serenity.lan>
 <alpine.DEB.2.20.1602041334450.2964@virtualbox>
 <20160204130111.GG29880@serenity.lan>
 <alpine.DEB.2.20.1602041411520.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 15:07:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRKYv-0006jh-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 15:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbcBDOHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 09:07:03 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56769 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbcBDOHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 09:07:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E9BDD866034;
	Thu,  4 Feb 2016 14:06:57 +0000 (GMT)
X-Quarantine-ID: <gyg4XgeTHwDK>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gyg4XgeTHwDK; Thu,  4 Feb 2016 14:06:51 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 87A0C86600D;
	Thu,  4 Feb 2016 14:06:10 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602041411520.2964@virtualbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285464>

On Thu, Feb 04, 2016 at 02:13:47PM +0100, Johannes Schindelin wrote:
> On Thu, 4 Feb 2016, John Keeping wrote:
> 
> > Although I don't think the historic context is useful in deciding which
> > direction to go in the future.
> 
> Being a maintainer, I find that argument particularly hard to defend.

I worded that badly, what I wanted to say is that how we got here is
less interesting than where we are.  From a quick bit of grep'ing it
looks to me like where we are is in favour of adding spaces around
binary operators inside $(( )) constructs based on the majority of the
uses in the code as it currently stands.

> But sure, you go ahead and prepare a patch series that turns everything
> around, adding spaces around those operators.
> 
> Whatever the outcome, the inconsistency must be fixed.

I disagree.  Unless there are other changes in the same area, the noise
isn't worth it.

However, I do think we need to agree on a policy so that new code can be
consistent.  This should then be documented in CodingGuidelines.
