From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Mon, 21 Jul 2008 03:24:38 +0200
Message-ID: <20080721012438.GF5950@leksak.fem-net>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net> <alpine.DEB.1.00.0807071540310.18205@racer> <20080712222212.GC22323@leksak.fem-net> <alpine.DEB.1.00.0807130222320.2995@eeepc-johanness> <20080713110904.GG22323@leksak.fem-net> <alpine.DEB.1.00.0807131518370.4816@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKk9o-0005hq-1G
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbYGUBYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbYGUBYo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:24:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:60585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756742AbYGUBYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:24:43 -0400
Received: (qmail invoked by alias); 21 Jul 2008 01:24:41 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp035) with SMTP; 21 Jul 2008 03:24:41 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18n+fg9zKsnRao0Qjh/svhjygu0+7wzCCPO1NbLfW
	YAXHCHr801gtg3
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KKk8k-0002lw-PZ; Mon, 21 Jul 2008 03:24:38 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807131518370.4816@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89289>

Hi,

Johannes Schindelin wrote:
> You will have to scroll back a few lines to see exactly what failed, but 
> you will see the exact commands (also of functions that were called), 
> together with their return values (i.e. what the function output, and what 
> was assigned to variables).

I've tested again and found it now. Thanks!

It's a littler harder to see, but now I know that I should look for
the last "+ eval_ret=" line, ...that makes it easier ;)

Puh, now I can finally move this thread to the archives :)

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
