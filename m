From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Gitweb and submodules
Date: Sat, 28 Jul 2007 12:40:54 +0200
Message-ID: <20070728104054.GI31114MdfPADPa@greensroom.kotnet.org>
References: <200707271322.50114.jnareb@gmail.com>
 <20070727123229.GB31114MdfPADPa@greensroom.kotnet.org>
 <200707281229.17351.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 12:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEjjK-0000G3-7z
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 12:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760358AbXG1KlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 06:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760356AbXG1KlA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 06:41:00 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:41050 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbXG1Kk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 06:40:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLV00FQ7XO6NU@psmtp13.wxs.nl> for git@vger.kernel.org; Sat,
 28 Jul 2007 12:40:55 +0200 (MEST)
Received: (qmail 7376 invoked by uid 500); Sat, 28 Jul 2007 10:40:54 +0000
In-reply-to: <200707281229.17351.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54023>

On Sat, Jul 28, 2007 at 12:29:16PM +0200, Jakub Narebski wrote:
> What do you think about using "submodule.$name.gitdir" configuration 
> variable for that?

What will be the value?  A path relative to the gitdir of the superproject?

> It has to be configuration variable because the 
> location of repository which has submodule objects doesn't change when 
> checking out (or rewinding) to different commit in supermodule.

Let's hope Pasky provides a way to set this information...

> As a special case I'd use 'no value' to note that submodule objects are 
> contained in the supermodule repository.

How about using '.' for that and no value for submodules that
are not available on this server?

skimo
