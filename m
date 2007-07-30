From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Gitweb and submodules
Date: Mon, 30 Jul 2007 09:06:00 +0200
Message-ID: <20070730070600.GK31114MdfPADPa@greensroom.kotnet.org>
References: <200707271322.50114.jnareb@gmail.com>
 <200707282239.29340.jnareb@gmail.com>
 <20070729163747.GJ31114MdfPADPa@greensroom.kotnet.org>
 <200707300209.03531.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPKR-0001Nr-41
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937966AbXG3HGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937845AbXG3HGE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:06:04 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:47157 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764242AbXG3HGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:06:01 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLZ00IZDD20GV@psmtp12.wxs.nl> for git@vger.kernel.org; Mon,
 30 Jul 2007 09:06:00 +0200 (MEST)
Received: (qmail 28429 invoked by uid 500); Mon, 30 Jul 2007 07:06:00 +0000
In-reply-to: <200707300209.03531.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54195>

On Mon, Jul 30, 2007 at 02:09:03AM +0200, Jakub Narebski wrote:
> On Sun,29 July 2007, Sven Verdoolaege wrote:
> > On Sat, Jul 28, 2007 at 10:39:28PM +0200, Jakub Narebski wrote:
> >>   submodule.$name.path/.git (relative to toplevel of working directory)
> > 
> > Having a relative path for the URL in .gitmodules in a public repo
> > doesn't seem very useful to me.  I know it's only meant as a default
> > value, but if it is a relative path, then it won't work for
> > anyone cloning the superproject.
> 
> Erm, it should be relative path in .git/config (as in example in the
> t/t7400-submodule-basic.sh IIRC). And this is purely local matter.

My mistake.  I misread that as submodule.$name.url.

skimo
