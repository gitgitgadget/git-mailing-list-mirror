From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change softrefs file format from text (82 bytes per entry) to binary (40 bytes per entry)
Date: Sun, 10 Jun 2007 01:30:45 -0700
Message-ID: <7vir9w8b4a.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706092019.13185.johan@herland.net>
	<200706092025.30156.johan@herland.net>
	<Pine.LNX.4.64.0706100900420.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIoy-0003X5-TL
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762646AbXFJIar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762641AbXFJIar
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:30:47 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51756 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762605AbXFJIaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:30:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610083046.YOVL12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 04:30:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9kWl1X00F1kojtg0000000; Sun, 10 Jun 2007 04:30:46 -0400
In-Reply-To: <Pine.LNX.4.64.0706100900420.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 10 Jun 2007 09:02:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49676>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Jun 2007, Johan Herland wrote:
>
>> The text-based softrefs file format uses 82 bytes per entry (40 bytes 
>> from_sha1 in hex, 1 byte SP, 40 bytes to_sha1 in hex, 1 byte LF).
>> 
>> The binary softrefs file format uses 40 bytes per entry (20 bytes 
>> from_sha1, 20 bytes to_sha1).
>> 
>> Moving to a binary format increases performance slightly, but sacrifices 
>> easy readability of the softrefs files.
>
> It is bad style to introduce one type, and then change it to another in a 
> backwards-incompatible way. Either you make it backwards compatible, or 
> you start with the second format, never even mentioning that you had 
> another format.

While I agree with that in principle, I think you are being a
bit too harsh to a set of patches that shows possible
alternatives for an idea that is not even in any unreleased
version of git.

Got out of the wrong side of bed this morning?
