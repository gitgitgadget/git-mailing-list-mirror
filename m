From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Mon, 6 Apr 2009 08:41:32 +0200
Message-ID: <20090406064132.GA25503@localhost>
References: <20090401180627.GA14716@localhost> <1238892420-721-1-git-send-email-drizzd@aon.at> <op.urx07jgeso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Mon Apr 06 08:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqiYf-0002vV-7n
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 08:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbZDFGmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 02:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZDFGmN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 02:42:13 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:42067 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbZDFGmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 02:42:12 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Apr 2009 08:42:02 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LqiWT-0006hu-0o; Mon, 06 Apr 2009 08:41:33 +0200
Content-Disposition: inline
In-Reply-To: <op.urx07jgeso3nzr@sulidor.mdjohnson.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 06 Apr 2009 06:42:08.0656 (UTC) FILETIME=[CEB23900:01C9B682]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115772>

On Sun, Apr 05, 2009 at 09:29:33PM -0500, Michael Johnson wrote:
>> +# history
>> +#
>> +#        a --- c
>> +#      /   \ /
>> +# root      X
>> +#      \   / \
>> +#        b --- d
>
> This also explains a lot. Is there any way to get this sort of simplified 
> representation from the existing tools? I would think gitk would show it, 
> but would I be able to recognize it.?

I simply tagged everything that showed up in "git merge-base --all" and then
I did "gitk --all --simplify-by-decoration". That shows pretty much the
graph above.
