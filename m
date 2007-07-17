From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:44:36 +0200
Message-ID: <20070717164436.GA26953@uranus.ravnborg.org>
References: <469CE836.6010508@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAq9X-0005TS-DU
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbXGQQnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbXGQQnY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:43:24 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:38757 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbXGQQnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:43:23 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 1AF88E3170A;
	Tue, 17 Jul 2007 18:43:21 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 97A8F580D2; Tue, 17 Jul 2007 18:44:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469CE836.6010508@arcom.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52774>

On Tue, Jul 17, 2007 at 05:03:02PM +0100, Amit Walambe wrote:
> Hi!
> I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For 
> which I get following error :
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
> Bad rev input: v2.6.22-git6
> 
> The repository is obtained by :
> root@amit:/usr/src # git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 linux-git

The -git# is added by a script and does not exists as tags.
The same place where you retreive the -git files has a file identifying
the commit that is the latest - use the SHA of this and you should
be happy.

	Sam
