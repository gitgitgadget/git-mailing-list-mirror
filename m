X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Missing features in git
Date: Wed, 15 Nov 2006 08:50:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611150847400.3349@woody.osdl.org>
References: <20061114195559.40967ee4.froese@gmx.de>
 <20061114213800.28716.qmail@science.horizon.com> <20061115073546.GD5453@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-160515427-1163609426=:3349"
NNTP-Posting-Date: Wed, 15 Nov 2006 16:52:16 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115073546.GD5453@diana.vm.bytemark.co.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31452>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkNzO-0000F9-BD for gcvg-git@gmane.org; Wed, 15 Nov
 2006 17:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030696AbWKOQvu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 11:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030699AbWKOQvu
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 11:51:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43394 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030696AbWKOQvt (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 11:51:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFGoToZ008891
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 08:50:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFGoQfT017856; Wed, 15 Nov
 2006 08:50:27 -0800
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-160515427-1163609426=:3349
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 15 Nov 2006, Karl Hasselström wrote:

> On 2006-11-14 16:38:00 -0500, linux@horizon.com wrote:
> 
> > It also removes a paragraph of excuses from some "using git" docs
> > I'm writing. It's a lot easier to explain why you can't commit if
> > you're not on a branch than to explain why you can't not be on a
> > branch.
> 
> This is precisely why writing documentation is such a good idea: It is
> in many cases easier to fix the warts than finding a pedagogical way
> to explain them. :-)

Heh. Pretty much all of the early git plumbing came about when I started 
to try to demonstrate git to others, and wrote some of the early 
tutorials. So yeah, trying to explain something to others (whether by 
documentation or through examples) is a good way to show what has bad 
interfaces.

Even if it's easy to use for yourself (I had my own scripts to do 
everything _I_ wanted to do), trying to explain why something is done some 
way to somebody who doesn't know the internals is always a good exercise.

		Linus
