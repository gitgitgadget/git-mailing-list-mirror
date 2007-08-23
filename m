From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 14:31:11 -0400
Message-ID: <20070823183111.GB15684@fieldses.org>
References: <20070823092254.GA5976@kroah.com> <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com> <20070823164322.GC5528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHSi-00019Z-I5
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764536AbXHWSbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764413AbXHWSbP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:31:15 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38066 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763614AbXHWSbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:31:14 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IOHSZ-0007J7-SJ; Thu, 23 Aug 2007 14:31:11 -0400
Content-Disposition: inline
In-Reply-To: <20070823164322.GC5528@kroah.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56511>

On Thu, Aug 23, 2007 at 09:43:22AM -0700, Greg KH wrote:
> I really do like quilt, but wanted to see how well my current workflow
> could be by using stgit as I'm constantly rebasing the main kernel
> version against -git snapshots and sometimes that isn't frequent enough.

So just want to be able to rebase more than once a day?  Then why not
just run quilt on top of git?  Pop off all your quilt patches, git pull,
push them all back on again....

Maybe I'm misunderstanding your use case.

--b.
