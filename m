From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/5] gitweb: Fix error in git_patchest_body for file creation/deletion patch
Date: Sun, 7 Jan 2007 19:53:41 -0800 (PST)
Message-ID: <601528.75484.qm@web31805.mail.mud.yahoo.com>
References: <1168134751748-git-send-email-jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jan 08 04:53:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lZx-0000cw-Tw
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbXAHDxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbXAHDxn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:53:43 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:42878 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030483AbXAHDxm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 22:53:42 -0500
Received: (qmail 91481 invoked by uid 60001); 8 Jan 2007 03:53:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=UeImXhDDlnFc4ezvqJIU6j45De7r93V/T0CdIEXcnOOlupPLsQ7s+YYG69EfSHLoESuZy51V7uhy27TdoaxC+OVaNDHP839+G8L49qxATZi3nh4xc1QxAhGHTma6BdDOtklF5tT6g8sfphCm1yWcJkDg3uxafESPsGoUpgho5+Y=;
X-YMail-OSG: JBVId7AVM1nH363yb4OM01OIe1jr015MK.VjshLuE6VGTXi8YRXasixDZRrjiBR.aIinOhkZPNpTHZUUO_UmN0j_Ji22V.w6AMgTKehrQGwvBTR4U9HicsCXKiDgm18TUFzht_yuLA--
Received: from [71.80.230.185] by web31805.mail.mud.yahoo.com via HTTP; Sun, 07 Jan 2007 19:53:41 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <1168134751748-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36236>

--- Jakub Narebski <jnareb@gmail.com> wrote:

> $from_id, $to_id variables should be local per PATCH.

There. You've already refactored the logic, now pull it into
a separate function.

BTW, I'll try the patches (unless Junio commits them to "next"
first) Monday sometime.

    Luben
