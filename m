From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] Allow specifying specialized merge-backend per path.
Date: Tue, 17 Apr 2007 08:16:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170815500.5473@woody.linux-foundation.org>
References: <11767973183627-git-send-email-junkio@cox.net>
 <11767973191314-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpPv-0002QM-Hg
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbXDQPQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbXDQPQV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:16:21 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51848 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbXDQPQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:16:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFGFTW005796
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:16:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFGEEu031945;
	Tue, 17 Apr 2007 08:16:14 -0700
In-Reply-To: <11767973191314-git-send-email-junkio@cox.net>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44778>



On Tue, 17 Apr 2007, Junio C Hamano wrote:
>
> This allows 'merge' attribute to control how the file-level
> three-way merge is done per path.

Cool. Good job. The whole attribute thing seems to be really working out.

		Linus
