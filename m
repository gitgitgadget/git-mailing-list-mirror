From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Two gitweb feature requests
Date: Sat, 29 Apr 2006 22:38:00 +0100
Message-ID: <1146346681.10561.118.camel@shinybook.infradead.org>
References: <1146144425.11909.450.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0604272250420.4963@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 23:37:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZx8M-0002YE-Pz
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 23:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWD2Vha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 17:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWD2Vha
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 17:37:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3995 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750799AbWD2Vh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 17:37:29 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FZx7y-0001ot-In; Sat, 29 Apr 2006 22:37:22 +0100
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.64.0604272250420.4963@mundungus.clifford.ac>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19318>

On Thu, 2006-04-27 at 22:54 +0000, Ben Clifford wrote:
> HTML has a <link> element which can be used to indicate alternate forms of 
> a page. Gitweb already generates one already to point people at the RSS 
> feeds.
> 
> Kinda messy to make all the git tools learn how to read HTML, though... 

They wouldn't necessarily need to. git-clone and git-pull attempt to use
URLs which wouldn't be used in normal gitweb usage -- for example, any
attempt to fetch http://git.infradead.org/?p=mtd-2.6.git/HEAD or
http://git.infradead.org/?p=mtd-2.6.git/refs/heads can be assumed to be
an attempt to clone or pull with git. So gitweb could be modified to
detect those URLs and give a simple textual redirect which the git tools
could understand.

-- 
dwmw2
