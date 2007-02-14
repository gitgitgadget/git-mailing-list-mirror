From: Junio C Hamano <junkio@cox.net>
Subject: Re: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 10:20:56 -0800
Message-ID: <7v8xf0ppmf.fsf@assigned-by-dhcp.cox.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
	<7vlkj0r7f0.fsf@assigned-by-dhcp.cox.net>
	<45D34D58.8050701@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOkW-0001F5-UN
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbXBNSU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbXBNSU6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:20:58 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35342 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbXBNSU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:20:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214182058.HHKN22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 13:20:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PWLw1W00r1kojtg0000000; Wed, 14 Feb 2007 13:20:57 -0500
In-Reply-To: <45D34D58.8050701@verizon.net> (Mark Levedahl's message of "Wed,
	14 Feb 2007 12:56:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39720>

Mark Levedahl <mdl123@verizon.net> writes:

> Junio C Hamano wrote:
>> I think something like this is a good addition but I do not want
>> us to require zip/unzip to use git.  I think saner alternative
>> would be to use tar.
>>
>>
>>
> That is any easy change. As the dominant content is an already
> compressed pack file, is tar sufficient or should it be a gzip or bzip
> tar?

If you are re-spinning the patch, please do not forget that you
would want to link it in the main Makefile and link the docs to
git.7 by adding them to Documentation/cmd-list.perl.

The USAGE string should fit comfortably on 80-column terminal.
The same goes for AsciiDoc text documentation.  Your lines are
too long.
