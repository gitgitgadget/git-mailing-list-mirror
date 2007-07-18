From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 08:07:37 +0200
Message-ID: <858x9ez1li.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB2hM-0004Qn-80
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbXGRGHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 02:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXGRGHk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:07:40 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:41040 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751248AbXGRGHj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 02:07:39 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 567254C41C;
	Wed, 18 Jul 2007 08:07:38 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 4415EABCE2;
	Wed, 18 Jul 2007 08:07:38 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-042-236.pools.arcor-ip.net [84.61.42.236])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 20C00292B62;
	Wed, 18 Jul 2007 08:07:38 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8DAF31C3ACCE; Wed, 18 Jul 2007 08:07:37 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0707180135200.14781@racer.site> (Johannes Schindelin's message of "Wed\, 18 Jul 2007 01\:35\:35 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3690/Wed Jul 18 05:08:02 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52829>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 18 Jul 2007, David Kastrup wrote:
>
>> This must likely be the most common FAQ/rant/whatever concerning git.
>
> If you had the idea already, I wonder why you did not find it.  It's not 
> really anything like hard to find:
>
> http://git.or.cz/gitwiki/GitFaq#head-1fbd4a018d45259c197b169e87dafce2a3c6b5f9

The FAQ answer is weazeling on several accounts:

a) No, git only cares about files, or rather git tracks content and
   empty directories have no content.

In the same manner as empty regular files have no contents, and git
tracks those.  Existence and permissions are important.

b) The problem is not just that empty directories don't get added into
the repository.  They also don't get removed again when switching to a
different checkout.  When git-diff returns zero, I expect a subsequent
checkout to not leave complete empty hierarchies around because git
can't delete any empty leaves which it chose not to track.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
