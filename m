From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Sun, 30 Apr 2006 19:35:10 +0200
Organization: At home
Message-ID: <e32ses$vs1$1@sea.gmane.org>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE> <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE> <e32pto$p3a$1@sea.gmane.org> <BAYC1-PASMTP054CF113E95D45B8778DACAEB00@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Apr 30 19:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaFpR-0003d4-5n
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 19:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWD3RfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWD3Re7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 13:34:59 -0400
Received: from main.gmane.org ([80.91.229.2]:13455 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751213AbWD3Rej (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 13:34:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaFoS-0003SJ-19
	for git@vger.kernel.org; Sun, 30 Apr 2006 19:34:28 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 19:34:28 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 19:34:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19350>

sean wrote:

> [branch.origin]
> description = "Pristine master from Junio"

I'd like to add
> pristine = true

and for git to warn if we try to commit to branch which is supposed to be
pristine (tracking external repository).

-- 
Jakub Narebski
Warsaw, Poland
