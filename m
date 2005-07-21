From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Support configurable SMTP port for stg mail.
Date: Thu, 21 Jul 2005 21:55:46 +0100
Message-ID: <1121979346.7654.3.camel@localhost.localdomain>
References: <20050721202058.8047.77221.stgit@h164.c77.b0.tor.eicat.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvi5Q-0001dn-Gx
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 22:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVGUUzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVGUUzu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 16:55:50 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:47789 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261850AbVGUUzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 16:55:48 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050721205547.IYUP25008.mta09-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Thu, 21 Jul 2005 21:55:47 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050721205547.VIAR8813.aamta12-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Thu, 21 Jul 2005 21:55:47 +0100
To: Bryan larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050721202058.8047.77221.stgit@h164.c77.b0.tor.eicat.ca>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-07-21 at 16:20 -0400, Bryan larsen wrote:
> The example configuration file makes it appear that the SMTP port is configurable.  Make it so.

The documentation for smtplib.SMTP says that the smtpserver parameter is
passed to connect(). This latter function parses the smtpserver for
'server:port' like strings and does the right thing. I tried it with
Python 2.3 and it seems to work fine without this patch.

Thanks anyway.

-- 
Catalin
