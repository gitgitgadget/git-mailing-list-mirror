From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Mon, 7 Jul 2008 16:08:41 +0200
Message-ID: <20080707140841.GB6726@leksak.fem-net>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrPX-00077i-G5
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYGGOIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYGGOIo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:08:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:47323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554AbYGGOIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:08:44 -0400
Received: (qmail invoked by alias); 07 Jul 2008 14:08:42 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp048) with SMTP; 07 Jul 2008 16:08:42 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX197OPRV0Ql7/AHNQAjkZLXB1XjeFBZnGN4Qyqw1l/
	sxh3uZFxYoN6Jr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFrOT-0004r2-13; Mon, 07 Jul 2008 16:08:41 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87610>

Hi,

> > This option realizes a stupid hack that tries to run the test
> > cases line by line (separated by &&).
> 
> In what way is that better than "sh -x t????-*.sh"?

Your suggestion is more like "./t????-*.sh -v" instead of -s, at least
on bash and dash here.
But I didn't know the -x flag and it seems that this could be used in
test-lib.sh to make the hack faster, more robust and less hacky ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
