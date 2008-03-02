From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sun, 2 Mar 2008 20:38:16 +0100
Message-ID: <20080302193816.GA4276@efreet.light.src>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <m3tzjrkie4.fsf@localhost.localdomain> <47C8FFFC.3050901@vilain.net> <200803011339.50978.jnareb@gmail.com> <47C95823.5090006@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	eric miao <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 20:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVu1X-0001aV-Mm
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 20:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYCBTi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 14:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYCBTi1
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 14:38:27 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:43138 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYCBTi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 14:38:26 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id DBF40574CF;
	Sun,  2 Mar 2008 20:38:24 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 3y0GVPymCnQ8; Sun,  2 Mar 2008 20:38:22 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A2EA0574B6;
	Sun,  2 Mar 2008 20:38:21 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JVu0m-00036H-P8; Sun, 02 Mar 2008 20:38:16 +0100
Content-Disposition: inline
In-Reply-To: <47C95823.5090006@vilain.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75832>

On Sun, Mar 02, 2008 at 02:20:35 +1300, Sam Vilain wrote:
> Jakub Narebski wrote:
> > And last, KDE repos should most probably be split into submodules.
> 
> Mmm.  Everyone always says that; what it really needs I think is someone
> to really take the conversion on board and come up with a workable plan
> on this front.  I think the counter-argument to this was "but you always
> want to have 70% of the repository checked out for development".

KDE should not be the case. The source for Debian packages is split in
several independent source packages (which are compilable on their own). You
should rarely need more than 1 or 2 (the one you hack + base) checked out.

> Counter-counter argument is "yes but they don't always need to be deep
> clones".  Anyway, it's not my baby, just thought I'd let you know about
> it :-)

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
