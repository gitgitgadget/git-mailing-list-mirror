From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 07:52:08 -0600
Message-ID: <17850.1928.124641.990272@lisa.zopyra.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17849.17947.645022.282882@lisa.zopyra.com>
	<200701261205.28504.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 14:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARV7-0006kZ-IY
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 14:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965670AbXAZNwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 08:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965671AbXAZNwS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 08:52:18 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60561 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965670AbXAZNwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 08:52:18 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QDqAa19068;
	Fri, 26 Jan 2007 07:52:10 -0600
In-Reply-To: <200701261205.28504.andyparkins@gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37855>

On Friday, January 26, 2007 at 12:05:27 (+0000) Andy Parkins writes:
>On Friday 2007 January 26 00:06, Bill Lear wrote:
>
>> git log -S --check foo
>>
>> and the thing went off into outer space.  Now at over 2 1/2 minutes of
>> CPU time on my 2 Ghz Opteron box...
>
>I would guess it's because you've used "-S<space>--check"; the --check will be 
>ignored as git-log doesn't use it, but the -S is saying "search for the empty 
>string" in all log messages - that's probably a long list, and so takes a 
>while to compile.

Well, remember this was a test repo, one file, one commit, with the word
"foo" in the file.  Even if searching for a space, it should not take
that long.  I think it's an infinite loop somewhere.


Bill
