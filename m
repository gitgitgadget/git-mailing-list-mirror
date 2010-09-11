From: haller@ableton.com (Stefan Haller)
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Sat, 11 Sep 2010 09:12:40 +0200
Organization: Ableton
Message-ID: <1joncyu.2n3oi9e5w1fpM%haller@ableton.com>
References: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
Cc: git@vger.kernel.org, dsteffen@apple.com (Daniel A Steffen)
To: patthoyts@users.sourceforge.net (Pat Thoyts),
	das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Sat Sep 11 09:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuKiO-0003cC-MX
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 09:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab0IKHlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 03:41:18 -0400
Received: from mail.ableton.net ([62.96.12.115]:42983 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab0IKHlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 03:41:17 -0400
X-Greylist: delayed 1713 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Sep 2010 03:41:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ableton.com; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=VimZbzA0eAbRrHxxvLvCKE2JEN9V1ISot6lha9W/17g=;
	b=otBDiz1pZoZ2CTgjYFPP1xwraSYd+sjHuALrkyAkAAUOY1Mus9KLI/QzSOipAxXWUvPx7U98RYxbywiyhZw7hHvJjDrOYCdFt6n8IXhCwsBZbi03vYZ4ti+6hPweN0XF/n2PQpBQiCHsO7l4kqBV+eAJLUealtpPBW2kB7SPWhE=;
Received: from [10.1.15.239]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <haller@ableton.com>)
	id 1OuKAB-0004Pj-8v; Sat, 11 Sep 2010 09:06:15 +0200
In-Reply-To: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155988>

Stefan Haller <lists@haller-berlin.de> wrote:

> Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
> 
> > This removes the Cmd-J accelerator from the "Revert Changes" menu
> > item. I assume that just changing the menu command to 
> >  {after idle [list do_revert_selection]}
> > doesn't work either?
> 
> No, but "after 100" does for me; "after 10" does not, and "after 50"
> does some of the time.  I'm not sure if this would be suitable as a
> workaround then.

We seem to be stuck with this right now.  What can I do to move this
forward?  I have little experience with Tcl/Tk, so I'm probably unable
to solve this in a satifactory way myself; but I'd like to do everything
I can to make progress here.

Do people think that the "after 100" hack would be acceptable, if it's
conditional for {[is_MacOSX] && $::have_tk85}?  Would it help if I try
to come up with a patch for that?

-Stefan


-- 
Stefan Haller
Ableton
http://www.ableton.com/
