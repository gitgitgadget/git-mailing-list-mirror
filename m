From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [msysGit] Re: [PATCH] Add a Windows-specific fallback to
	getenv("HOME");
Date: Thu, 5 Jun 2014 14:15:21 +0200
Organization: <)><
Message-ID: <20140605121521.GA28894@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <alpine.DEB.1.00.1406051354000.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsWZt-00047j-1L
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 14:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaFEMPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 08:15:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48823 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaFEMPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 08:15:24 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id B99331C009B;
	Thu,  5 Jun 2014 14:15:22 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s55CFMRv028938;
	Thu, 5 Jun 2014 14:15:22 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s55CFLMV028937;
	Thu, 5 Jun 2014 14:15:21 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1406051354000.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250833>

Hi,

On Thu, Jun 05, 2014 at 02:03:39PM +0200, Johannes Schindelin wrote:
> Render me even more convinced that the API call is the cleanest way to go,

But not me.  

In a paralel post, Duy Nguyen wrote:
> Thank you for working on pushing msysgit patches upstream. I don't use
> git on windows, but it's nice to see all windows-specific changes in
> one code base so we can try to workaround it when new patches/features
> are developed.

... but we should not obscure that more than necessary.  If the API
call is   getenv("HOME");  it helps.  And the hack with
mingw_getenv() is not that bad, so we should be pragmatic and accept
it.

Stepan
