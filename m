From: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
Subject: RE: missing: git api, reference, user manual and mission statement
Date: Wed, 20 Apr 2005 13:15:46 -0400
Message-ID: <004e01c545cc$97d9b780$9b11a8c0@allianceoneinc.com>
References: <20050419165809.GE12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Petr Baudis'" <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 20 19:15:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIlv-0002yn-Me
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDTRRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDTRRi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:17:38 -0400
Received: from mail.allianceoneinc.com ([65.213.221.36]:61445 "EHLO
	mail.allianceoneinc.com") by vger.kernel.org with ESMTP
	id S261739AbVDTRQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:16:41 -0400
Received: from epa20012 [192.168.17.155] by mail.allianceoneinc.com with ESMTP
  (SMTPD32-8.14) id AE424C300B4; Wed, 20 Apr 2005 13:15:46 -0400
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050419165809.GE12757@pasky.ji.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-IMAIL-SPAM-VALFROM: (8e4204c300b4b26c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis graced us with:
> Dear diary, on Tue, Apr 19, 2005 at 02:36:32PM CEST, I got a letter
> where Klaus Robert Suetterlin <robert@mpe.mpg.de> told me that...
> > 1) There is no clear (e.g. by name) distinction between ``git as done
> > by Linus'', which is a kind of content addressable database with added
> > semantics, and ``git as done by the rest of You'', which is a kind of
> > SCM on top of Linuses stuff.
> 
> There is git and git-pasky (git-pasky is superset; therefore various
> patches floating around either get to git-pasky or to both). I'm not
> sure what else do you mean.

This goes back to the question of whether to rename git-pasky to cogito.  

Perhaps the crucial question is:  will the git plumbing be used for anything
other than SCM?

If so, then it could be useful to differentiate by program name, so that we
would know whether another project was utilizing git-plumbing or git-SCM.

If not, then there is effectively only one tool and the plumbing is a
[crucial] portion thereof:  a git (SCM and the file system around which it
was built).

So what's the answer to the question?  Anyone planning to use git (the file
system) outside of the SCM?


