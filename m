From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Wed, 06 Jun 2007 13:41:21 -0700
Message-ID: <7vhcpkzuha.fsf@assigned-by-dhcp.cox.net>
References: <11808537962798-git-send-email-el@prans.net>
	<20070603225354.GB16637@admingilde.org>
	<7vabvgmvuo.fsf@assigned-by-dhcp.cox.net>
	<20070604071810.GD16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elvis Pranskevichus <el@prans.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3hX-0001Vl-JM
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935353AbXFFWJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935218AbXFFWJw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:09:52 -0400
Received: from fed1rmpop104.cox.net ([68.230.241.8]:41582 "EHLO
	fed1rmpop104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608AbXFFWJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:09:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606204122.YYHK14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 16:41:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8LhM1X00d1kojtg0000000; Wed, 06 Jun 2007 16:41:22 -0400
In-Reply-To: <20070604071810.GD16637@admingilde.org> (Martin Waitz's message
	of "Mon, 4 Jun 2007 09:18:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49325>

Martin Waitz <tali@admingilde.org> writes:

> On Sun, Jun 03, 2007 at 05:01:03PM -0700, Junio C Hamano wrote:
>> Martin Waitz <tali@admingilde.org> writes:
>> > but lightweight tags are not fetched by default.
>> 
>> Are you sure about that?
>
> not any more now that you questioned it ;-)
>
> But at least there is a hook script which refuses to receive
> un-annotated tags and I always considered those tags to be temporary
> tags in the local repository.

I'll take the patch to 'next' and see if anybody screams.  We
can add the '-m "Label from CVS"' bit easily if annotated tags
turns out to be easier for people before it graduates to
'master', although I suspect we probably do not have to.
