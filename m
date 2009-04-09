From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] graph API: Added logic for colored edges
Date: Thu, 09 Apr 2009 20:58:51 +0300
Message-ID: <87hc0x7lpg.fsf@iki.fi>
References: <20090331235922.GA7411@linux.vnet>
	<20090407185724.GA9996@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryYE-0005RP-30
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbZDIR64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758677AbZDIR64
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:58:56 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:37985 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499AbZDIR6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:58:55 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49CA1E6700AB985C; Thu, 9 Apr 2009 20:58:52 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LryWZ-0002fn-GZ; Thu, 09 Apr 2009 20:58:51 +0300
In-Reply-To: <20090407185724.GA9996@linux.vnet> (Allan Caffee's message of "Tue\, 7 Apr 2009 14\:57\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116192>

On 2009-04-07 14:57 (-0400), Allan Caffee wrote:

> Modified the graph drawing logic to colorize edges based on
> parent-child relationships similiarly to gitk.

I like the colored graph very much, thanks. Unfortunately there are some
problems with aligning of log messages and headers. For example, try
this in git.git repository:


$ git log -1 --graph 796b137

*   commit 796b13781aecce551b8f92049a66646e60f31dce
|\ Merge: 6da14ee db12d97
| | Author: Junio C Hamano <gitster@pobox.com>
| | Date:   2009-04-08 23:41:27 -0700


Without colors or without your patch the alignment is correct:

$ git log -1 --graph --no-color 796b137

*   commit 796b13781aecce551b8f92049a66646e60f31dce
|\  Merge: 6da14ee db12d97
| | Author: Junio C Hamano <gitster@pobox.com>
| | Date:   2009-04-08 23:41:27 -0700


(Perhaps the "Merge:" header could have two spaces befor the data, but
this is  unrelated to --graph.)
