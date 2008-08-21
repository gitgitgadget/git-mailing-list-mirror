From: Teemu Likonen <tlikonen@iki.fi>
Subject: "log --pretty=format:" language
Date: Thu, 21 Aug 2008 08:02:23 +0300
Message-ID: <20080821050223.GA3295@mithlond.arda.local>
References: <20080820175325.GD27773@sigill.intra.peff.net> <20080820180034.GB32005@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MichaelTiloDressel@t-online.de, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 07:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW2L5-00052I-PU
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 07:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbYHUFC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 01:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYHUFC4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 01:02:56 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:37426 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbYHUFC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 01:02:56 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 488DC54E01008361; Thu, 21 Aug 2008 08:02:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KW2JT-00011d-84; Thu, 21 Aug 2008 08:02:23 +0300
Content-Disposition: inline
In-Reply-To: <20080820180034.GB32005@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote (2008-08-20 14:00 -0400):

> There is a lot of room for discussion here.
> 
> For example:
> 
>   - what should %d show? Right now it shows each decoration, split by
>     commas. It doesn't show the enclosing parentheses automatically.
> 
>     Is this too strict? Should there be some way of pulling out
>     individual decorations from the list, or specifying a different
>     delimiter? If so, probably that should be part of a general
>     improvement in the format expansion macro language.

If such "general improvement" takes place I'd like to point out (most 
likely old news, but anyway) that %b can't be indented in practical 
sense. For example, the command

    git log --pretty=format:%x09%s%n%n%x09%b -1 3a634dc

prints this:

        Add hints to revert documentation about other ways to undo changes

        Based on its name, people may read the 'git revert' documentation when
they want to undo local changes, especially people who have used other
SCM's.  'git revert' may not be what they had in mind, but git
provides several other ways to undo changes to files.  We can help
them by pointing them towards the git commands that do what they might
want to do.

[...]
