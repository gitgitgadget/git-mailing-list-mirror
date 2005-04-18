From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch] fixup GECOS handling
Date: Mon, 18 Apr 2005 22:35:12 +1000
Message-ID: <1113827713.5286.13.camel@localhost.localdomain>
References: <1113820589.16288.5.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 14:32:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNVPn-0008OG-0N
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 14:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVDRMfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 08:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDRMfh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 08:35:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262058AbVDRMfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 08:35:33 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNVTO-00065C-On; Mon, 18 Apr 2005 13:35:32 +0100
To: azarah@nosferatu.za.org
In-Reply-To: <1113820589.16288.5.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 12:36 +0200, Martin Schlemmer wrote:
> realgecos[strchr(realgecos, ',') - realgecos] = '\0';

Er, *strchr(realgecos, ',') = 0; surely? Even if the compiler is clever
enough to optimise out the gratuitous addition and subtraction, that's
no real excuse for it.

-- 
dwmw2

