From: Paul Mackerras <paulus@samba.org>
Subject: Re: [REPLACEMENT PATCH 2/2] Add "--early-output" log flag for interactive
 GUI use
Date: Sun, 4 Nov 2007 14:06:09 +1100
Message-ID: <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 04:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoVoz-0005iv-DN
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 04:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbXKDDG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 23:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbXKDDG1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 23:06:27 -0400
Received: from ozlabs.org ([203.10.76.45]:34349 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294AbXKDDG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 23:06:26 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4BBFEDDE33; Sun,  4 Nov 2007 14:06:25 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63337>

Linus Torvalds writes:

> When the full list is generated, there will be a "Final output:" string
> prepended to it, regardless of whether any early commits were shown or
> not, so that the consumer can always know the difference between early
> output and the final list.

How hard would it be to put the total number of commits on that "Final
output" line?  That would be useful for me.

Paul.
