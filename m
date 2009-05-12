From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 22:37:09 +0200
Message-ID: <200905122237.10173.markus.heidelberg@web.de>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com> <4A08A28C.3020202@gmail.com> <20090512155301.GA21556@macbook.lan>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: MALET Jean-Luc <jeanluc.malet@gmail.com>, git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 12 22:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yir-0007js-SE
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbZELUg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZELUg6
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:36:58 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52300 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZELUg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:36:57 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id D5BA8FC3F9B9;
	Tue, 12 May 2009 22:36:57 +0200 (CEST)
Received: from [89.59.116.180] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M3yif-000607-00; Tue, 12 May 2009 22:36:57 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090512155301.GA21556@macbook.lan>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX181+JvikbDrnV2pehIF6KhOAyWIC1d0GxShN1EW
	pW6Rf0OqRpH0ho9S/KKWVpSboTtfaipCk7PTAkc6ZtK1bxyS3N
	6y3Hb0BWwMC3yp6C2BfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118951>

Heiko Voigt, 12.05.2009:
> On Tue, May 12, 2009 at 12:11:24AM +0200, MALET Jean-Luc wrote:
> > As far as I know you can't push stashed  
> > information, I'm wrong?
> 
> AFAIR, git stash cannot be pushed. Well you could by creating a branch
> and pushing that but thats not native stash functionality.

I tried "git clone --mirror" with a repo containing a stash, the clone
had a stash entry in .git/packed-refs. "git push --mirror" didn't work,
though. Not sure what should be intended.

Markus
