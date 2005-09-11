From: Nathan Laredo <laredo@hera.kernel.org>
Subject: Re: git problems on Kernel.org?
Date: Sun, 11 Sep 2005 11:26:04 -0700
Message-ID: <20050911182604.GB14417@hera.kernel.org>
References: <4323E3C0.1090109@tuxrocks.com> <4324531B.3080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Sorenson <frank@tuxrocks.com>, webmaster@kernel.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 20:27:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWWt-0005Xs-Hf
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVIKS0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVIKS0M
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:26:12 -0400
Received: from hera.kernel.org ([209.128.68.125]:28126 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964997AbVIKS0L (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:26:11 -0400
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.13.1/8.13.1) with ESMTP id j8BIQ4W1014650;
	Sun, 11 Sep 2005 11:26:04 -0700
Received: (from laredo@localhost)
	by hera.kernel.org (8.13.1/8.13.1/Submit) id j8BIQ4eX014649;
	Sun, 11 Sep 2005 11:26:04 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <4324531B.3080209@gmail.com>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8314>

On Sun, Sep 11, 2005 at 11:54:03AM -0400, A Large Angry SCM wrote:
> >This is probably a temporary error that will periodically (and 
> >probably very rarely) occur when pulling from a source with more 
> >than a single IP and some lag before the mirror is updated.
> >
> >Is this an issue that we need to watch for and program around (other
> >than forcing www.kernel.org's IP in /etc/hosts), or is it just one of
> >those things that should be such a rare occurrance that we shouldn't
> >have to worry about it?
> 
> From a gitweb perspective, one of the servers appears to be about 24 
> hours out of date as of Sun Sep 11 15:50:53 UTC 2005. Broken rsync process?

The filesystem on one of the machines got remounted read-only, so
nothing was being updated.

-- Nathan Laredo
laredo@kernel.org
