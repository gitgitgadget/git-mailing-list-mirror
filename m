From: Bill Lear <rael@zopyra.com>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 17:15:11 -0600
Message-ID: <17903.18303.797634.693414@lisa.zopyra.com>
References: <17902.59497.831409.218529@lisa.zopyra.com>
	<17902.60536.5890.608883@lisa.zopyra.com>
	<20070307170904.GB27922@spearce.org>
	<17902.62836.920473.810183@lisa.zopyra.com>
	<20070307230948.GE27922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5NE-0003UU-8M
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992724AbXCGXQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992700AbXCGXP4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:15:56 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61636 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965714AbXCGXPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:15:15 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l27NFCI12274;
	Wed, 7 Mar 2007 17:15:12 -0600
In-Reply-To: <20070307230948.GE27922@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41701>

On Wednesday, March 7, 2007 at 18:09:48 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> Since it just gets the ref name, would one (of sufficient skill) be
>> able to reconstruct the same sort of report that the "pre" update hook
>> does?  That is, from the ref name can I get the old SHA-1?  If I try
>> to write this, what I think I would like to do is just call the
>> existing update hook from the post-update hook, with the post update
>> hook figuring out the proper arguments to pass along.
>
>For what its worth, the receive-pack patch series that I posted a
>few hours ago creates a new post-receive hook that would be suitable
>for generating the report you are looking for.

Ok, I'll have a look at them.  Thanks for the quick work.


Bill
