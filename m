From: Petr Baudis <pasky@suse.cz>
Subject: Re: "strip" the repo
Date: Fri, 20 Apr 2007 22:31:04 +0200
Message-ID: <20070420203104.GQ4489@pasky.or.cz>
References: <f36b08ee0704201228v40e95ac1h8f541b14feb2cede@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HezlE-0001Ie-Kf
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 22:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767238AbXDTUbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 16:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767240AbXDTUbL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 16:31:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37213 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767236AbXDTUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 16:31:08 -0400
Received: (qmail 24295 invoked by uid 2001); 20 Apr 2007 22:31:04 +0200
Content-Disposition: inline
In-Reply-To: <f36b08ee0704201228v40e95ac1h8f541b14feb2cede@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45129>

On Fri, Apr 20, 2007 at 09:28:02PM CEST, Yakov Lerner wrote:
> I am curious, if I remove all files and dirs (except .git),
> and index, will it make it a valid bare repo ?
> Or switching the repo from non-bare to bare is difficult ?

Yes, just removing everything except .git and .git/index (optionally)
will work fine to create a bare repository. Maybe a simpler way (but
more expensive) is to git clone --bare the repository.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
