From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: Change encoding of RSS feed to latin-1
Date: Sat, 19 Nov 2005 21:14:06 +0100
Message-ID: <20051119201406.GA8985@puritan.petwork>
References: <200511192156.23259.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 21:16:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdZ6P-0000ms-O7
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 21:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKSUOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVKSUOH
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 15:14:07 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:61181 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750792AbVKSUOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 15:14:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051119201404.XOQF9142.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Sat, 19 Nov 2005 21:14:04 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id D2A6BADFE5; Sat, 19 Nov 2005 21:14:06 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511192156.23259.ismail@uludag.org.tr>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12350>

Ismail Donmez wrote:

> As the other thread grew into merits of using UTF-8 I think best fix
> for now is putting encoding=latin-1 into RSS feed so everyone is
> happy. After all its latin-1 encoded data not utf-8. Anyone disagrees?
> Can we now please fix/change gitweb so xml parsers can parse it
> without workarounding?

If you know that your log-messages will be in latin-1 or UTF-8 or
whatever encoding you like, then modify your gitweb.cgi to match.  Just
search for 'utf-8' and change it to what you prefer.

What perhaps is of general interest is modifying the distributed
gitweb.cgi to allow for easily changing the encoding on a
per-installation basis, just like $projectroot is configurable on a
per-installation basis.

UTF-8 is still a sane default for gitweb.cgi.

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
