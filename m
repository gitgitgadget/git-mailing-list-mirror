From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Integrating with hooks
Date: Wed, 14 Nov 2007 00:07:29 +0100
Organization: At home
Message-ID: <fhdane$kfs$1@ger.gmane.org>
References: <20071113173721.GI25282@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 00:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4se-0001Qk-7e
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761710AbXKMXIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761259AbXKMXIB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:08:01 -0500
Received: from main.gmane.org ([80.91.229.2]:38456 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758742AbXKMXIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:08:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Is4r9-0008AB-MB
	for git@vger.kernel.org; Tue, 13 Nov 2007 23:07:43 +0000
Received: from abwy6.neoplus.adsl.tpnet.pl ([83.8.248.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 23:07:43 +0000
Received: from jnareb by abwy6.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 23:07:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwy6.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64904>

[Cc: Todd A. Jacobs <nospam@codegnome.org>, git@vger.kernel.org]

Todd A. Jacobs wrote:

> I've created some bash functions which handle tagging some files with
> revision information, but even after reading the git manual I'm not
> really sure how to integrate them so that they remove revision expansion
> before each check-in (to avoid cluttering the repository with keyword
> substitutions), and add them back (with the current commit info) after
> each commit.
> 
> These are the functions:

[...]

> How do I hook this in the way I want so that it's handled automatically?

Take a look at gitattributes(5), namely 'filter' attribute.

Although instead of implementing it "by hand", perhaps it would be
enough to use 'ident' and/or 'export-subs' attribute.

P.S. Because of the way git updates files, and git thinks about files
it is I think universally regarded to be bad idea to put in a file
any Id that depend on commit data.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
