From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Mon, 29 Aug 2011 23:30:14 +0200
Message-ID: <1314653414.2054.0.camel@twins>
References: <4E56CE8F.8080501@panasas.com>
	  <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
	  <4E580830.4010305@panasas.com> <1314624752.2816.32.camel@twins>
	 <4E5BFD36.2090000@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Aug 29 23:30:48 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Qy9Ps-00070m-2c
	for glk-linux-kernel-3@lo.gmane.org; Mon, 29 Aug 2011 23:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab1H2Vab (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 29 Aug 2011 17:30:31 -0400
Received: from casper.infradead.org ([85.118.1.10]:51219 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab1H2Va2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2011 17:30:28 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1Qy9PL-0006cx-VX; Mon, 29 Aug 2011 21:30:16 +0000
Received: by twins (Postfix, from userid 1000)
	id 2FCEF84F2D3D; Mon, 29 Aug 2011 23:30:14 +0200 (CEST)
In-Reply-To: <4E5BFD36.2090000@panasas.com>
X-Mailer: Evolution 3.0.2- 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180357>

On Mon, 2011-08-29 at 13:57 -0700, Boaz Harrosh wrote:
> 
> Adding a .gitattributes file to the Linux git tree is a very simple message.
> "In the linux git tree all .c and .h files are c-source files" (And git will
> treat them that way) 

I'm all for it, I hate those labels in git-diff output.. 
