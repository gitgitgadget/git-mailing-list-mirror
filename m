From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Wed, 14 Feb 2007 23:07:25 -0500
Message-ID: <20070215040725.GB29944@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org> <20070214180906.GB21612@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Feb 15 05:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHXuA-0007kX-RU
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 05:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbXBOEHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 23:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbXBOEHa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 23:07:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151AbXBOEH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 23:07:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHXtr-00018p-Gg; Wed, 14 Feb 2007 23:07:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0143720FBAE; Wed, 14 Feb 2007 23:07:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070214180906.GB21612@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39795>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> 1) SSH_ASKPASS (see ssh(1))
>     If ssh needs a passphrase, it will read the passphrase from the
>     current terminal if it was run from a terminal.  If ssh does not
>     have a terminal associated with it but DISPLAY and SSH_ASKPASS
>     are set, it will execute the program specified by SSH_ASKPASS
>     and open an X11 window to read the passphrase.  This is particu-
>     larly useful when calling ssh from a .Xsession or related
>     script.  (Note that on some machines it may be necessary to
>     redirect the input from /dev/null to make this work.)
> 
> This require, that a password helper is installed. One implementation
> is part of every linux distribution (openssh-askpass-gnome).

I had written a Tk based SSH_ASKPASS helper not to long ago,
and hoped it would work here.  It doesn't work on Cygwin for
anything except ssh-agent.  I'm not sure why.  I haven't tested
other platforms.
 
> 2) Simulate user (like http://websvn.kde.org/tags/KDE/3.4.3/kdebase/kioslave/fish/fish.cpp?rev=467549&view=auto)

Yea, that's a difficult one, and very error prone...

-- 
Shawn.
