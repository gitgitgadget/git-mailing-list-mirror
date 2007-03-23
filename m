From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Installation instructions for gitweb?
Date: Fri, 23 Mar 2007 17:42:48 +0100
Message-ID: <20070323164248.GJ8017@planck.djpig.de>
References: <etufpl$7en$1@sea.gmane.org> <20070323161210.GI8017@planck.djpig.de> <f329bf540703230920r5034d025p5fd169b06837ad4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri Mar 23 17:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmqt-0001zo-3u
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXCWQmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXCWQmw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:42:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:36978 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbXCWQmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:42:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 0DE5888136;
	Fri, 23 Mar 2007 17:42:50 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29557-07; Fri, 23 Mar 2007 17:42:49 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 0285288137; Fri, 23 Mar 2007 17:42:48 +0100 (CET)
Mail-Followup-To: hanwen@xs4all.nl, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f329bf540703230920r5034d025p5fd169b06837ad4e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42949>

On Fri, Mar 23, 2007 at 01:20:25PM -0300, Han-Wen Nienhuys wrote:
> >gitweb_conf.perl is just included as perl code. It is primarly useful
> >for overriding the variables defined at the top of gitweb.cgi
> 
> This explanation doesn't help me. Can you post an example snippet?

e.g. the default config file distributed in the Debian packages for git:

# path to git projects (<project>.git)
$projectroot = "/var/cache/git";

# directory to use for temp files
$git_temp = "/tmp";

# target of the home link on top of all pages
$home_link = $my_uri;

# html text to include at home page
$home_text = "indextext.html";

# file with project list; by default, simply scan the projectroot dir.
$projects_list = $projectroot;

# stylesheet to use
$stylesheet = "/gitweb.css";

# logo to use
$logo = "/git-logo.png";

# the 'favicon'
$favicon = "/git-favicon.png";

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
