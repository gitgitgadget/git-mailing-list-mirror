From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [msysGit] Re: [PATCH] mingw: redefine the wrapper macro after
	the corresponding function
Date: Thu, 5 Jun 2014 17:13:38 +0200
Organization: <)><
Message-ID: <20140605151338.GA29385@camelia.ucw.cz>
References: <20140605080519.GB28029@camelia.ucw.cz> <539083FB.6040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZMP-0004Uj-0g
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbaFEPNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 11:13:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55353 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaFEPNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 11:13:40 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 18FB11C00BB;
	Thu,  5 Jun 2014 17:13:39 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s55FDc0W029575;
	Thu, 5 Jun 2014 17:13:38 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s55FDcbp029574;
	Thu, 5 Jun 2014 17:13:38 +0200
Content-Disposition: inline
In-Reply-To: <539083FB.6040707@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250843>

Hello Karsten,

On Thu, Jun 05, 2014 at 04:51:39PM +0200, Karsten Blees wrote:
> In the current msysgit HEAD, most of these #undef's can simply be
> removed or have already been removed [...]

not "most of."  According to my quick count, 6 of 20 have been removed,
2 more can be removed.  The remaining 12 do play their role.
(The point you overlooked is that there are several socket related,
like bind().)

> If you apply this patch in msysgit, you'll most likely get compile
> errors due to redefining macros.

It would be warnings only.  But a quick test shows that redefining
with identical definition does not trigger the warning.

Stepan
