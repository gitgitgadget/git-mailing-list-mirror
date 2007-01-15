From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Sun, 14 Jan 2007 23:08:26 -0800
Message-ID: <20070115070826.GB939@localdomain>
References: <200701150144.56793.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VW7-0000bo-Nh
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:07 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V95-0003eK-RP
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAOHI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 02:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbXAOHI3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 02:08:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38750 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083AbXAOHI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 02:08:28 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D2E7A7DC094;
	Sun, 14 Jan 2007 23:08:26 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 Jan 2007 23:08:26 -0800
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701150144.56793.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36863>

Jakub Narebski <jnareb@gmail.com> wrote:
> To make gitweb faster I thought about adding to it, or to Git.pm,
> simple nonvalidation config file reader. Nonvalidating means that
> it would accept some input which git-repo-config considers invalid.

How about something like git-for-each-ref that dumps the entire output
of a config file into an eval()-able string?  That way we don't have to
deal with corner-cases and subtle differences between C and Perl
implementations.

-- 
Eric Wong
