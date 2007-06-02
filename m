From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Sat, 02 Jun 2007 15:15:18 -0700
Message-ID: <7vvee6nguh.fsf@assigned-by-dhcp.cox.net>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at>
	<200705291121.12119.jnareb@gmail.com>
	<20070529215536.GA13250@auto.tuwien.ac.at>
	<200706012305.41183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 00:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hubsd-0007NV-L3
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 00:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762012AbXFBWPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761988AbXFBWPX
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 18:15:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50369 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761644AbXFBWPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 18:15:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602221519.DTBZ22318.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 18:15:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6mFJ1X0021kojtg0000000; Sat, 02 Jun 2007 18:15:19 -0400
In-Reply-To: <200706012305.41183.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 1 Jun 2007 23:05:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48956>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 29 May 2007, Martin Koegler wrote:
> ...
>> But I agree, that there should be the possibilty to choose a the
>> fallback encoding.
>
> I think for the beginning it would be enough to have
>
>   # assume this charset if line contains non-UTF-8 characters
>   our $fallback_encoding = "latin1";
>
> or something like that (perhaps different wording in the comment,
> perhaps different name of the variable) in the gitweb.perl for your
> idea to be accepted.
>
> That, and using to_utf8 (as before e3ad95a8) and not my_decode_utf8
> as subroutine name. If only it would be possible to avoid I think
> quote costly "eval {....}" invocation...

Except that I had an impression that block form of "eval" (as
opposed to "parse and evaluate string" kind) was not costly at
all.

Please make it so.

I'll read the other parts of your message again -- I might have
further comments.
