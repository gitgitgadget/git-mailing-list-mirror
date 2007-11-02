From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Make git-clone obey "--" (end argument parsing)
Date: Fri, 2 Nov 2007 16:21:50 +0200
Message-ID: <20071102142150.GD9632@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InxPT-0007rO-NC
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 15:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbXKBOVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 10:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbXKBOVx
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 10:21:53 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:54349 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656AbXKBOVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 10:21:53 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 36C8B101F5;
	Fri,  2 Nov 2007 16:21:52 +0200 (EET)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 04578-04; Fri,  2 Nov 2007 16:21:51 +0200 (EET)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 972CF101ED;
	Fri,  2 Nov 2007 16:21:51 +0200 (EET)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 65E6A4E344;
	Fri,  2 Nov 2007 16:21:51 +0200 (EET)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 2C61B4F95F; Fri,  2 Nov 2007 16:21:50 +0200 (EET)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63121>

Junio C Hamano wrote:
> I do not think this breaks anything, but does it _help_
> anything in practice?
> 
> What kind of breakage does this patch fix?

It doesn't fix anything, but it is a good usability standard to obey --.
I was creating a script that would _automatically_ clone repositories of 
other users. As a little bit pedantic shell script writer I added "--" 
and noticed that git clone doesn't handle that, although it's expected 
behavior from many tools.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
