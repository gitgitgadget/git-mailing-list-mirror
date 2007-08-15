From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 07:42:05 +0200
Message-ID: <46C2922D.8000408@gmail.com>
References: <1186984174.10249.7.camel@localhost>	<200708131933.10125.m.kozlowski@tuxland.pl>	<1187026955.2688.4.camel@laptopd505.fenrus.org>	<1187037445.6628.98.camel@heimdal.trondhjem.org>	<1187054366.2757.0.camel@laptopd505.fenrus.org>	<46C10AA8.3090505@gmail.com>	<20070814102033.604c8695@the-village.bc.nu>	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>	<7vwsvx8twx.fsf@assigned-by-dhcp.cox.net>	<1187143925.32555.208.camel@localhost> <7vlkcdjrmu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756414AbXHOFqZ@vger.kernel.org Wed Aug 15 07:46:37 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756414AbXHOFqZ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBiG-0006bV-Pe
	for glk-linux-kernel-3@gmane.org; Wed, 15 Aug 2007 07:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414AbXHOFqZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Aug 2007 01:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbXHOFqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Aug 2007 01:46:08 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:48924 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbXHOFqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Aug 2007 01:46:07 -0400
Received: from [213.51.130.190] (port=59784 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILBhf-0001I7-8F; Wed, 15 Aug 2007 07:45:59 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:57501 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILBhZ-0001zc-32; Wed, 15 Aug 2007 07:45:53 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <7vlkcdjrmu.fsf@assigned-by-dhcp.cox.net>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55882>

On 08/15/2007 07:25 AM, Junio C Hamano wrote:

> Joe Perches <joe@perches.com> writes:

>> Rene Herman had an idea about using some git
>> metadata that might be useful.  The completely
>> external data approach suggested by Al Viro 
>> might be OK too in that it wouldn't tie listeners
>> to git requiring more content in git metadata.
> 
> The reason I found Linus's suggestion desirable is because it
> fundamentally does not require git to track any metadata.  If
> the commits are in git, then his script would let you gather the
> data, but otherwise you should be able to do the same by
> grepping patches.  Obviously you would need to filter by paths,
> looking at the diffstat, but the approach does _not_ tie users
> to git.

I believe that wouldn't be much of a problem really. Users in this context 
are people submitting patches and most people who do will, could and maybe 
even should be running git these days -- git is very good, GPLd and the 
Linux source code managament system.

But for occasional contributors that don't, a MAINTAINERS file much like the 
current could also be generated into releases; it's just that the source 
would live as file/directory metadata inside git.

Still like the notion of a generic file/directory metadata implementation 
inside git, through that "<tag>=<value>" system that I suggested. Wouldn't 
be intrinsically tied to Linux or anything, with any project being free to 
invent their own tags and has heaps of possible uses, from the current 
MAINTAINERS info, through summary information, author/licese information, 
anything goes...

Rene.
