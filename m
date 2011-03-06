From: lists@haller-berlin.de (Stefan Haller)
Subject: Completion for branches or tags broken with zsh
Date: Sun, 6 Mar 2011 22:38:21 +0100
Message-ID: <1jxqbmc.vc0luayavmrkM%lists@haller-berlin.de>
Cc: jrnieder@gmail.com (Jonathan Nieder),
	lodatom@gmail.com (Mark Lodato)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 22:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwLen-0003Qi-Dv
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 22:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1CFViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 16:38:23 -0500
Received: from mail.ableton.net ([62.96.12.117]:47478 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab1CFViX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 16:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:Cc:To; bh=BylN3lnOuYt1tSRnaCxU5F+8nFMwB5/dSYxDi+nu+a0=;
	b=oqjaugINt5RJttb7qvhGGQPjVPDhLE+y3/BE5pf1D+HvN1UhXTQEHK0VKIm943NpwM2RtMX5i68MxHa/3sgee1XjI9FlJuc53iPx/1uUyL8fOCXTZdzmuRhbg/r9RGSCnfNaW+tOqQupn6AGJMydolOo5NRSAM/oWQcMiO3+PI4=;
Received: from [10.1.15.237]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PwLef-0002Tv-DL; Sun, 06 Mar 2011 22:38:21 +0100
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.6 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168533>

In the current master (and 1.7.4), tab completion for refs doesn't work
in zsh.  When typing "git log orig<TAB>", nothing appears.

A revision that works for me is 5a3a484d57.  I suspect it may have
something to do with dbda3b1090, but it's hard to bisect because many
revisions on the way can't even be loaded by zsh.

I don't know enough about the completion mechanisms to be able to debug
this myself.  Anybody able to help?

(My zsh version is 4.3.9, in case it makes a difference.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
