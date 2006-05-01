From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Mon, 1 May 2006 16:07:04 +0200
Message-ID: <20060501140704.GA6096@mars.ravnborg.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <20060501140410.GA3505@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 16:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaZ3L-0000Qs-BD
	for gcvg-git@gmane.org; Mon, 01 May 2006 16:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWEAOHD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 10:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEAOHD
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 10:07:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:14607 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932117AbWEAOHC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 10:07:02 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 6E4B01EC329;
	Mon,  1 May 2006 16:07:01 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id F256E43C069; Mon,  1 May 2006 16:07:04 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060501140410.GA3505@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19379>

> 
> I usually do something stupid like:
> git ls-files | grep Kconfig | xargs grep DEBUG

Which is indeed studip. I just learned I could say:
git ls-files '*/Kconfig*' | xargs grep DEBUG

	Sam
