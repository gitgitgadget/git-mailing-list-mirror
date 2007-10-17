From: "Josh England" <jjengla@sandia.gov>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 13:52:20 -0600
Message-ID: <1192650740.6223.24.camel@beauty>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net>
 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net>
 <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
 <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena>
 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <1192645509.6640.21.camel@athena>
 <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
 <1192649598.6640.44.camel@athena>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Tom Tobin" <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEuC-0001lj-8V
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762504AbXJQTt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762162AbXJQTt5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:49:57 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:2462 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760728AbXJQTt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:49:56 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 17 Oct 2007 13:49:40 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.1/8.14.1) with ESMTP id l9HJnafX024849;
 Wed, 17 Oct 2007 13:49:37 -0600
In-Reply-To: <1192649598.6640.44.camel@athena>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.10.17.122934
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20071017194942; SEV=2.2.2; DFV=B2007101715;
 IFV=2.0.4,4.0-9; AIF=B2007101715; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230312E34373136363733422E303032453A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007101715_5.02.0125_4.0-9
X-WSS-ID: 6B08B8DE2G01395276-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61420>

On Wed, 2007-10-17 at 14:33 -0500, Tom Tobin wrote:
> That disk space translates into memory usage exactly *how*?  Compiled
> code?  Or the in-memory text while you're editing?  The former can't be
> the issue, and the latter is trivial.

Think compression.  Worse yet in my opinion is the bandwidth spike that
the larger tarball would create.  Estimates earlier in the thread put
the difference at upwards of 40MB.  Disk space may be cheap, but highly
available redundant mirrored disk space is not, and neither is
bandwidth.

> And, of course, this still comes up against the *benefits* of
> all-spaces.  Benefits which have been mentioned by several people;
> benefits which you refuse to *acknowledge*, even if they don't sway you.

I think what Linus is trying to say here is this:  THE "BENEFITS" DO
*NOT* OUTWEIGH THE DRAWBACKS.  Accept it and move on.

> You've essentially demonstrated that git's "benevolent" dictator is an
> asshole, and even worse, an irrational asshole.  It's one thing to deal
> with a community member like that; when it's the BD, I think I'll move
> along elsewhere.  Congratulations.

Lovely.  Personal attacks are such an effective way to get your point
across.  You, sir, are a tool.  Good riddance.

-JE
