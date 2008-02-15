From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition
 to X11
Date: Fri, 15 Feb 2008 13:46:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site>
 <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se> <alpine.LSU.1.00.0802151050340.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 13:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPzyB-0006lr-9Z
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 13:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYBOMqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 07:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYBOMqf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 07:46:35 -0500
Received: from ds9.cixit.se ([193.15.169.228]:33364 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbYBOMqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 07:46:34 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m1FCkW3X015435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Feb 2008 13:46:32 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m1FCkV6f015430;
	Fri, 15 Feb 2008 13:46:31 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0802151050340.30505@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 15 Feb 2008 13:46:32 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73954>

Johannes Schindelin:

> Can you please test?  The we could at least add a "Tested-by:" to the 
> commit message.

When starting from the "Git bash" shell, it works.

When starting from a Cygwin prompt, it does not work ($MSYSTEM is not
set).

-- 
\\// Peter - http://www.softwolves.pp.se/
