From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 10:02:13 +0100
Message-ID: <20070323090213.GA7186@fiberbit.xs4all.nl>
References: <382665.13897.qm@web31804.mail.mud.yahoo.com> <7v7it8s7c4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: ltuikov@yahoo.com, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUg1B-0008F8-E2
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbXCWJZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbXCWJZA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:25:00 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:42274 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422754AbXCWJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:25:00 -0400
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2007 05:24:59 EDT
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1HUff3-0001ts-O8; Fri, 23 Mar 2007 10:02:13 +0100
Content-Disposition: inline
In-Reply-To: <7v7it8s7c4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42917>

On Friday March 23rd 2007 at 01:16 Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > BTW, git has always said to me "Pushing version ... to the masses"
> > whenever I'd do "git-push --tags web".
> 
> Sorry, I must be blind, and git-grep is too.
> 
> $ git grep -e 'to the masses' -e 'Pushing v'
> 
> returns absolutely empty.

The line comes from an older version of templates/hooks--update. The
line was removed in commit 829a686f1b50ba96cac2d88494fa339efe0c0862 .

So Luben does seem to have a hook installed, perhaps this is the
culprit.
-- 
Marco Roeland
