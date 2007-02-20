From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 17:28:15 -0800
Message-ID: <7v7iud4nyo.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 02:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJno-0007gQ-GZ
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 02:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbXBTB2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 20:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbXBTB2R
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 20:28:17 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58396 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbXBTB2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 20:28:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220012816.FJA1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 20:28:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RdUF1W0021kojtg0000000; Mon, 19 Feb 2007 20:28:15 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40190>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 19 Feb 2007, Junio C Hamano wrote:
>> 
>> Hmm.  I am puzzled.  Are you suggesting to change behaviour of
>> "git apply" with --index?
>
> Yeah. Or at least _verify_ that the patch is within the subdirectory we 
> are in right now. Right now, we do neither, and it will actually change 
> files outside that subdirectory, which I think is a bit dangerous.

I think use_patch() has always took care of that.
