From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 20:51:36 +0200
Organization: At home
Message-ID: <ee9jv6$ga0$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz93a9v9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 20:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNZqT-0004pl-4S
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 20:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIMSwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWIMSwV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 14:52:21 -0400
Received: from main.gmane.org ([80.91.229.2]:5269 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751106AbWIMSwU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 14:52:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNZq8-0004kE-4V
	for git@vger.kernel.org; Wed, 13 Sep 2006 20:52:04 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 20:52:04 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 20:52:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26930>

Junio C Hamano wrote:

> Using tag has an added benefit that you now have a place to say
> why you dropped it.  So what we would need to support this is an
> agreed-upon name under $GIT_DIR/refs/ that is omitted from
> display by convention across Porcelains (the core side should
> not ignore them because even when you are abandoning them, you
> do not want to lose them),

I think that using hidden directory (dot-directory), e.g.
$GIT_DIR/refs/.abandoned/ is a good idea... unless it conflicts somewhat
with the way lock files are named...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
