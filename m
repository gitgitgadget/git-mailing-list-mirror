From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: BUG: "git add --interactive" does not work with UTF-8 filenames if core.quotepath=true
Date: Tue, 1 Apr 2008 23:29:09 +0300
Message-ID: <200804012329.09565.tlikonen@iki.fi>
References: <200804012232.03559.tlikonen@iki.fi> <m3y77xtk32.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 22:30:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgn7D-0002Yv-85
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 22:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942AbYDAU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757916AbYDAU3M
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 16:29:12 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:40615 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757174AbYDAU3L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 16:29:11 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003274AC; Tue, 1 Apr 2008 22:29:10 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <m3y77xtk32.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78663>

Jakub Narebski kirjoitti:

> git-config(1):
>
>   core.quotepath::

Ah, thanks! This whole bug disappeared when I set core.quotepath=false 
i.e. "git add -i" works fine with UTF-8 filenames too.

However, the bug remains when core.quotepath=true or it's unconfigured.
