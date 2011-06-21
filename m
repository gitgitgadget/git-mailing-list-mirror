From: Andrew Cameron <andrew@worksmartlabs.com>
Subject: Re: git checkout running very slowly (>12s)
Date: Tue, 21 Jun 2011 10:44:53 -0400
Message-ID: <BANLkTikJDHUbt8X+W-W66YNL4qDnwthB3w@mail.gmail.com>
References: <loom.20110615T213016-856@post.gmane.org>
	<4DF9363F.6080009@op5.se>
	<loom.20110616T010709-333@post.gmane.org>
	<loom.20110620T221426-685@post.gmane.org>
	<20110621004452.GA3064@sigill.intra.peff.net>
	<20110621143437.GB18700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ2CK-0002g3-QH
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab1FUOoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:44:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56557 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1FUOoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:44:54 -0400
Received: by qyk9 with SMTP id 9so1725238qyk.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 07:44:53 -0700 (PDT)
Received: by 10.229.128.211 with SMTP id l19mr5197157qcs.31.1308667493062;
 Tue, 21 Jun 2011 07:44:53 -0700 (PDT)
Received: by 10.229.250.205 with HTTP; Tue, 21 Jun 2011 07:44:53 -0700 (PDT)
In-Reply-To: <20110621143437.GB18700@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176158>

On Tue, Jun 21, 2011 at 10:34 AM, Jeff King <peff@peff.net> wrote:

> I was curious, and your issue was easy to replicate, so I bisected it
> myself. The fix was:
>
>  commit e53e6b4433f264250c2e586167caf61721b0185c
>  Author: Brian Downing <bdowning@lavos.net>
>  Date:   Thu Jun 10 21:59:07 2010 -0500
>
>      unpack-trees: Make index lookahead less pessimal
>
> which went into v1.7.1.1.
>
> -Peff
>

You beat me to it.  Thanks for the suggestion and the investigative work!

Andrew
