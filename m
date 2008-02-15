From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition
 to X11
Date: Fri, 15 Feb 2008 10:40:27 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 10:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPx4B-0003wN-5j
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYBOJkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYBOJkg
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:40:36 -0500
Received: from ds9.cixit.se ([193.15.169.228]:42684 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbYBOJkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 04:40:35 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m1F9eS3X029681
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Feb 2008 10:40:28 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m1F9eR0K029676;
	Fri, 15 Feb 2008 10:40:27 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0802141228300.30505@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 15 Feb 2008 10:40:28 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73948>

Johannes Schindelin:

> When deciding if gitk or git-log should be used to visualize the current
> state, the environment variable DISPLAY was checked.  Now, we check
> MSYSTEM (for MinGW32/MSys) and SECURITYSESSIONID (for MacOSX) in addition.

That was quick! I haven't tried it, but I guess it should solve the
problem I was seeing.

-- 
\\// Peter - http://www.softwolves.pp.se/
