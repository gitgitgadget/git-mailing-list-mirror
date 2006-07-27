From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: 27 Jul 2006 07:22:38 -0700
Message-ID: <867j1zb00h.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060726010358.20964.80443.stgit@machine>
	<Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060726021058.GV13776@pasky.or.cz>
	<Pine.LNX.4.63.0607260416070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<ea7r3s$ta2$1@sea.gmane.org>
	<Pine.LNX.4.63.0607261702500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<86ejw7b4em.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0607271559161.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 16:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G66lA-0000B6-96
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 16:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWG0OWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWG0OWk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 10:22:40 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:26900 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751309AbWG0OWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 10:22:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A96628F697;
	Thu, 27 Jul 2006 07:22:39 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11579-02-3; Thu, 27 Jul 2006 07:22:39 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 122738F6A1; Thu, 27 Jul 2006 07:22:39 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.9.1; tzolkin = 5 Imix; haab = 14 Xul
In-Reply-To: <Pine.LNX.4.63.0607271559161.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24292>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Wishful thinking. If it wasn't for political reasons, certain people would 
Johannes> use cygwin's perl already, instead of ActiveState.

I don't think this is a "cygwin" perl though.  This is released under
Perl's terms, so it's not just gnu.  It's a complete build system with
a bundled C compiler, running on Windows natively.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
