From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 11:28:24 -0600
Message-ID: <20080212172824.GI27535@lavos.net>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LFD.1.00.0802110942310.2732@xanadu.home> <20080212082211.GE27535@lavos.net> <alpine.LFD.1.00.0802120910440.2732@xanadu.home> <20080212171403.GG27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOywK-0005FZ-At
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbYBLR21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbYBLR21
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:28:27 -0500
Received: from mxsf09.insightbb.com ([74.128.0.79]:48793 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYBLR20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:28:26 -0500
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="253644141"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf09.insightbb.com with ESMTP; 12 Feb 2008 12:28:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGZmsUdKhvkY/2dsb2JhbACBWapx
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="155576744"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 12 Feb 2008 12:28:24 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 0A778309F21; Tue, 12 Feb 2008 11:28:24 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20080212171403.GG27535@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73678>

On Tue, Feb 12, 2008 at 11:14:03AM -0600, Brian Downing wrote:
> 3. Constant entry depth with a memory-usage limit.  This is what the
>    proposed patch does.
> 4. Dynamic entry depth, with a memory-based limit.  This is I believe
>    what you are proposing above, and what I emulate by setting
>    --window=$bignum --window-memory=x.

[...]

> (Though frankly I don't > care much about #3; setting the window entry
> size to something "large enough" seems a simple enough work-around for
> me...)

I meant #4 of course, I renumbered one case but not the other.  I need
to not post right after I wake up.  :)

-bcd
