From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 13:45:41 -0500
Message-ID: <20070814184541.GL21692@lavos.net>
References: <11870975181798-git-send-email-bdowning@lavos.net> <7vhcn2c673.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:46:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL1Oz-0004m6-04
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765628AbXHNSp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 14:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761450AbXHNSp5
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 14:45:57 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:23204 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761381AbXHNSp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 14:45:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtZjAM+UwUZKhvbzRmdsb2JhbACBVIUlhxYBAQE1AQ
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 14 Aug 2007 14:45:50 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 97EFE309F31; Tue, 14 Aug 2007 13:45:41 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vhcn2c673.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55847>

On Tue, Aug 14, 2007 at 11:38:24AM -0700, Junio C Hamano wrote:
> That interface is at too low a level, I am afraid.  Many
> commands do want to control when they read the index and it
> affects the result, especially when the work tree traversal
> implemented in dir.c is involved.
> 
> I am not rejecting/objecting, but just raising concerns.  I do
> not have time to review this today, but just wanted to see if
> you fully assessed the implications (and if so that would save
> work on my end).

I really don't understand the implications.  That was just something
that got it working on my end, and I figured I should send it along
in case it was just that simple.

-bcd
