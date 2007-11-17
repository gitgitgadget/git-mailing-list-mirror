From: Wayne Davison <wayne@opencoder.net>
Subject: Re: preserving mtime
Date: Sat, 17 Nov 2007 10:22:36 -0800
Message-ID: <20071117182236.GD23659@blorf.net>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItSJj-00051q-8B
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 19:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939AbXKQSWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 13:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757583AbXKQSWi
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 13:22:38 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:35528 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757283AbXKQSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 13:22:37 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id D97335340; Sat, 17 Nov 2007 10:22:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <473D6DC6.8040804@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65294>

On Fri, Nov 16, 2007 at 11:15:34AM +0100, Andreas Ericsson wrote:
>> is it possible to tell git to preserve the file modification time in
>> a checked out copy?

> Fabrizio Pollastri wrote:
> No. Doing so would seriously break build-systems.

I wish that the initial clone would set the modification time to the
commit time.  It would make the intial checkout have a more accurate
representation of when a file was last changed instead of all files
being set to the clone date.  Then, files that are being updated would
get their time set as they do now.  I supposed I'll just use the handy
git-set-file-times script (mentioned in another reply) every time I do
a clone.

..wayne..
