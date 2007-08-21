From: David Kastrup <dak@gnu.org>
Subject: Re: hiding a certain file from gitweb
Date: Tue, 21 Aug 2007 23:49:38 +0200
Message-ID: <85veb8mubx.fsf@lola.goethe.zz>
References: <20070821190225.GA7133@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INbbk-0003Op-DT
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbXHUVts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbXHUVtr
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:49:47 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:43585 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754531AbXHUVtq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 17:49:46 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E118315BC26;
	Tue, 21 Aug 2007 23:49:45 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id D39981147B5;
	Tue, 21 Aug 2007 23:49:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-062-171.pools.arcor-ip.net [84.61.62.171])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id A2A782BAA23;
	Tue, 21 Aug 2007 23:49:41 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CA5151C36605; Tue, 21 Aug 2007 23:49:38 +0200 (CEST)
In-Reply-To: <20070821190225.GA7133@piper.oerlikon.madduck.net> (martin f. krafft's message of "Tue\, 21 Aug 2007 21\:02\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4023/Tue Aug 21 22:46:27 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56335>

martin f krafft <madduck@madduck.net> writes:

> Dear list,
>
> one of my colleagues checked a file with thousands of email
> addresses into git and pushed the commit, so now the file is on
> gitweb. This was quite a while ago and we have over 500 commits and
> several branches between now and then.

This sounds like you would be ok with the file never having been
committed.  Use git-filter-branch for that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
