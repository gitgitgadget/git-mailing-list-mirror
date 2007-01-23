From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: A trivial question on GIT
Date: Tue, 23 Jan 2007 14:51:44 -0500
Message-ID: <20070123195144.GE5779@fieldses.org>
References: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 20:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9RgM-0001V0-Uv
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 20:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbXAWTvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXAWTvr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 14:51:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:52933 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932936AbXAWTvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 14:51:46 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H9RgG-0005FW-FK; Tue, 23 Jan 2007 14:51:44 -0500
To: Allexio Ju <allexio.ju@gmail.com>
Content-Disposition: inline
In-Reply-To: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37561>

On Tue, Jan 23, 2007 at 11:45:14AM -0800, Allexio Ju wrote:
> I have trivial question on GIT.
> I've made local copy of Linus's linux-2.6.git repository with
> following git command,
> ---
> # git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6.git
> ---
> 
> After this, I would like to know how to synchronize local copy and
> keep updated  with Linus's.
> I guess cloning everyday would be bad idea as it is heavy operation.

Yes!

> Can someone guide me on how to?

Just run:

	git fetch

--b.
