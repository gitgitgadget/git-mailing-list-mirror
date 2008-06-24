From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 16:36:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241634590.32759@sys-0.hiltweb.site>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <m363rylknc.fsf@localhost.localdomain> <alpine.LFD.1.10.0806241548140.32759@sys-0.hiltweb.site> <200806242209.07135.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:37:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFGF-0000MW-PT
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYFXUgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYFXUgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:36:09 -0400
Received: from mail.gmx.com ([74.208.5.67]:59305 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753499AbYFXUgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:36:08 -0400
Received: (qmail invoked by alias); 24 Jun 2008 20:36:06 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us002) with SMTP; 24 Jun 2008 16:36:06 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX19UHb4djfJUnRhUuWTUE8tBGgiOzlCGckk16RuYGJ
	BD49BI9/ZI55DF
In-Reply-To: <200806242209.07135.jnareb@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86140>

On Tue, 24 Jun 2008 at 10:09pm +0200, Jakub Narebski wrote:

> Unfortunately \r matches \s (is whitespace), so if line ends with CR LF
> ("\r\n") it wouldn't match first regexp, so it would go to 'else' 
> clause, where it would match /\s$/ and it shouldn't.

Right.  Sorry for the noise.

-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
