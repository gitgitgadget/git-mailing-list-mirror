From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/7] revert: refactor code to find commit subject in
 find_commit_subject()
Date: Thu, 22 Jul 2010 18:50:12 +0200
Message-ID: <20100722165012.GA4938@m62s10.vlinux.de>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
 <20100722131836.2148.58435.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 22 18:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObyyX-00037i-EK
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 18:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0GVQuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 12:50:20 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:60160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752526Ab0GVQuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 12:50:18 -0400
Received: (qmail invoked by alias); 22 Jul 2010 16:50:16 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp007) with SMTP; 22 Jul 2010 18:50:16 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18jZb5bRwMjzQJAh+9/96lTd5pd53RLvCHdmtFqfN
	jQ7C8ouG7u2JCh
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 44DE1DC5B0; Thu, 22 Jul 2010 18:50:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100722131836.2148.58435.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151462>


Wouldn't it be better to merge this with  [PATCH 4/7], so we won't create
find_commit_subject in revert.c and then immediatly move it to commit.c?
