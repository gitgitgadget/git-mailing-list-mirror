From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 16:27:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301624050.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
 <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
 <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
 <7vy7gximkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 01:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFeeV-0002kt-Rk
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 01:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760204AbXG3X1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 19:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760058AbXG3X1t
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 19:27:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35157 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755952AbXG3X1s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 19:27:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UNReoC001493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 16:27:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UNRZdS003995;
	Mon, 30 Jul 2007 16:27:35 -0700
In-Reply-To: <7vy7gximkc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.729 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.16__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54291>



On Mon, 30 Jul 2007, Junio C Hamano wrote:
> 
> We would need to do something like this patch, perhaps?  This
> function has three callers, two in builtin-add and another in
> builtin-mv.

I think you need to check that ce is in stage 0 too.

		Linus
