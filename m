From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question on alternates
Date: Tue, 24 Jul 2007 12:05:36 +0200
Organization: At home
Message-ID: <f84iu9$e27$1@sea.gmane.org>
References: <20070724100053.GA18701@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 12:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHHa-0005rl-SR
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763474AbXGXKGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762626AbXGXKGT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:06:19 -0400
Received: from main.gmane.org ([80.91.229.2]:46954 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760241AbXGXKGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:06:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDHHL-00088s-S4
	for git@vger.kernel.org; Tue, 24 Jul 2007 12:06:07 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 12:06:07 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 12:06:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53551>

Michael S. Tsirkin wrote:

> Is it possible to add an alternate to .git/objects/info/alternates
> to an existig repository, after the fact?

Yes.

> If I do, is there a way to find and remove objects that
> already exist in the alternate?

I guess "git repack -a -d -l" (or "git gc --prune").

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
