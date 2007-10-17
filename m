From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 16:59:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171654300.26902@woody.linux-foundation.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
 <471302D2.6010405@trolltech.com> <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
 <200710150902.52653.johan@herland.net> <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
 <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
 <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com> <85ve98gl57.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710180045160.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	David Symonds <dsymonds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiInf-0001qU-AR
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbXJQX7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbXJQX7d
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:59:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49898 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757429AbXJQX7c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 19:59:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HNx303004343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 16:59:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HNx3OM014745;
	Wed, 17 Oct 2007 16:59:03 -0700
In-Reply-To: <Pine.LNX.4.64.0710180045160.25221@racer.site>
X-Spam-Status: No, hits=-3.217 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61445>



On Thu, 18 Oct 2007, Johannes Schindelin wrote:
> 
> Could we, _please_, first decide if the implementation has merits, and 
> just apply it as is in that case?  We can rename it whatever anybody likes 
> later, and we can paint the bikeshed brown if you want to.

I thought everybody really agreed that being able to skip commits that you 
cannot say good/bad about is a feature worth doing?

Right now we actually have some docs in the man-page about doing that 
avoidance manually, so it's not like it's debatable whether this issue 
comes up. It most definitely does come up.

Does anybody really think it's not a good feature? And I've not seen 
negative comments about the implementation either apart from some small 
details that I think got fixed up already (but maybe the complaints were 
all hidden by the shed color discussions ;)

			Linus
