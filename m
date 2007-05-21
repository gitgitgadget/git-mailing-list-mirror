From: Raimund Bauer <ray007@gmx.net>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 08:44:46 +0200
Message-ID: <1179729886.6187.15.camel@localhost>
References: <20070520214417.GM5412@admingilde.org>
	 <200705210006.47266.johan@herland.net>
	 <7v3b1rje45.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 08:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1dZ-0000q0-4e
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXEUGov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXEUGov
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:44:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:33221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754528AbXEUGou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:44:50 -0400
Received: (qmail invoked by alias); 21 May 2007 06:44:48 -0000
Received: from p5498B6F1.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.182.241]
  by mail.gmx.net (mp050) with SMTP; 21 May 2007 08:44:48 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1++ce0UP9G+OZZIk4lgcJySlc36OACudDU2S3XdAT
	8crq7dG8x5YqBK
In-Reply-To: <7v3b1rje45.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47973>

On Sun, 2007-05-20 at 15:59 -0700, Junio C Hamano wrote:
> I was wondering if we can get away by just calling them
> "projects", "projects containd in the superproject", etc., as I
> tend to agree with Linus, who used the term "superproject
> support" in his talk, that this is not really about creating
> "subproject" which are somehow different from ordinary projects,
> but more about supporting superprojects that can contain/point
> at other projects, which we did not have before 1.5.2 happened.

The "super" or "sub" only comes from where in a hierarchy it is used.
Somewhere in the middle of the hierarchy it would be both?

I'd have said a repository can have many "modules" or "projects", and
each of those can have several branches. A module can hold other
modules, but from its POV also be part of a super-module (or
superproject), we just have to take care to not build loops.

Is my view of the world correct so far?

-- 
best regards

  Ray
