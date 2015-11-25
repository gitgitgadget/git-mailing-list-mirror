From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Wed, 25 Nov 2015 10:13:42 +0000
Message-ID: <20151125101342.GE18913@serenity.lan>
References: <20151125010722.GA23632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1X6G-0005UM-PY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbbKYKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:14:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35480 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbKYKOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:14:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 20773CDA5B7;
	Wed, 25 Nov 2015 10:14:44 +0000 (GMT)
X-Quarantine-ID: <z43bUsNqADDH>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z43bUsNqADDH; Wed, 25 Nov 2015 10:14:43 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BB1A0CDA637;
	Wed, 25 Nov 2015 10:13:44 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151125010722.GA23632@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281693>

On Tue, Nov 24, 2015 at 08:07:23PM -0500, Jeff King wrote:
> * jk/send-email-ssl-errors (2015-11-24) 1 commit
>  - send-email: enable SSL level 1 debug output
> 
>  Improve error reporting when SMTP TLS fails.
> 
>  Will merge to 'next'.

Can you hold off on this one?  I think my last-minute change not to
switch on --smtp-debug has introduced a Perl warning that needs to be
suppressed.
