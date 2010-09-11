From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Sat, 11 Sep 2010 09:31:22 +0200
Message-ID: <1jondo9.dzvb0d1am10m3M%lists@haller-berlin.de>
References: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
Cc: git@vger.kernel.org, dsteffen@apple.com (Daniel A Steffen)
To: patthoyts@users.sourceforge.net (Pat Thoyts),
	das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Sat Sep 11 09:31:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuKYd-0000pC-Ox
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 09:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab0IKHbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 03:31:25 -0400
Received: from mail.ableton.net ([62.96.12.115]:53558 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab0IKHbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=DR4xWKlhZq8Eg+fJiDQTX50Fbk842KGDCWva3XAPYug=;
	b=XO3gPqxKeTloVYnPk/eZRbRsjmmuBya4tlpgePZU+V2vEQIJ5lV0HlKeIF4EggBPohPIU9ETztItT15dy4QdXJgDZNRWnO94TUthWgsC0a5z5jW5vL91mzaSYQgP2b6WNPBPxeDXUGF177k682B2a9SNIE5W+9rpMXFVaxbRN+U=;
Received: from [10.1.15.239]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OuKSH-0002Qz-9q; Sat, 11 Sep 2010 09:24:57 +0200
In-Reply-To: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155987>

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
I can to help make progress here.

Do people think that the "after 100" hack would be acceptable, if it's
conditional for {[is_MacOSX] && $::have_tk85}?  Would it help if I try
to come up with a patch for that?

-Stefan


(Sorry for the duplicate mail; I used the wrong return address the first
time, so it didn't got to the list.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
