From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] apply: fix copy/rename breakage
Date: Thu, 10 Jul 2008 06:21:44 +0200
Message-ID: <20080710042144.GF18030@leksak.fem-net>
References: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Don Zickus <dzickus@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 06:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGngE-0006un-8V
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 06:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbYGJEVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 00:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYGJEVv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 00:21:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:44303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbYGJEVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 00:21:51 -0400
Received: (qmail invoked by alias); 10 Jul 2008 04:21:48 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp047) with SMTP; 10 Jul 2008 06:21:48 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+ZuVcp616ZuSV1xxnHVOHFCequohWFa2V/gwWAHl
	M6AMDIlF+xyeOG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGnf6-0007il-7u; Thu, 10 Jul 2008 06:21:44 +0200
Content-Disposition: inline
In-Reply-To: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87938>

Hi,

On Wed, Jul 09, 2008 at 08:10:58PM -0700, Junio C Hamano wrote:
> 
> 	diff --git a/A b/A
> 	--- a/A
> 	+++ b/A
> 	... change text here ...
> 	diff --git a/A b/B
> 	copy from A
> 	copy to B
> 	--- a/A
> 	+++ b/B
> 	... change text here ...

Big thanks! Now my patch applies cleanly again and many others, too. So:

Tested-by: Stephan Beyer <s-beyer@gmx.net>

;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
