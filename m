From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 11:18:49 +0100
Message-ID: <20051224101849.GY1279MdfPADPa@greensroom.kotnet.org>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Rob McDonald <robm@asdl.gatech.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 11:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq6UK-00051x-Hs
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 11:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbVLXKSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 05:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbVLXKSx
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 05:18:53 -0500
Received: from smtp14.wxs.nl ([195.121.247.5]:12162 "EHLO smtp14.wxs.nl")
	by vger.kernel.org with ESMTP id S1422654AbVLXKSx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 05:18:53 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IRZ00H2UZBD1K@smtp14.wxs.nl> for git@vger.kernel.org; Sat,
 24 Dec 2005 11:18:49 +0100 (CET)
Received: (qmail 7874 invoked by uid 500); Sat, 24 Dec 2005 10:18:49 +0000
In-reply-to: <43AD1E63.4040103@op5.se>
To: Andreas Ericsson <ae@op5.se>
Mail-followup-to: Andreas Ericsson <ae@op5.se>,
 Rob McDonald <robm@asdl.gatech.edu>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14016>

On Sat, Dec 24, 2005 at 11:09:39AM +0100, Andreas Ericsson wrote:
> The worst trouble you're likely to run into is all the hardcoded paths. 
> They are everywhere and ofcourse use the / for path entity separation.

AFAIR, '/' is a valid path separator on Windows.
It's just command.com (does that still exist?) that insisted on '\\'
separators.

> The fact that there are 39 bash'ish shell-scripts does little to help a 
> native port, and although they can be fairly easily replaced by "real" 
> programs it still means quite a bit of work with little real value for 
> the unix-version, so I'm guessing you'll have to write those up for 
> yourself.

Or just use MinGW's bash.

skimo
