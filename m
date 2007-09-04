From: "Josh England" <jjengla@sandia.gov>
Subject: Re: git clone over http
Date: Tue, 04 Sep 2007 10:54:36 -0600
Message-ID: <1188924876.6192.21.camel@beauty>
References: <200709021123.04218.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbf2-0000N9-Os
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbXIDQxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXIDQxn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:53:43 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:1927 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbXIDQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:53:42 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 04 Sep 2007 10:53:28 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l84GrRxp001294;
 Tue, 4 Sep 2007 10:53:27 -0600
In-Reply-To: <200709021123.04218.robin.rosenberg.lists@dewire.com>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.4.92322
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_600_699
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070904165331; SEV=2.2.2; DFV=B2007090413;
 IFV=2.0.4,4.0-9; AIF=B2007090413; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364444384438412E303045373A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007090413_5.02.0125_4.0-9
X-WSS-ID: 6AC352023HO1226786-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57615>

On Sun, 2007-09-02 at 11:23 +0200, Robin Rosenberg wrote:
> git clone (1.5.3) with http is somewhat unreliable. I've noticed if
> can actually give
> me different versions of a branch each time I run it, eventually yielding
> the one I'm expecting.  And now this:

I don't see this behavior, but I do see other wierdness cloning via
http.  Anytime I clone a repo (any repo) via http from behind the
firewall/proxy at work I never get any branches.  'git branch' only ever
shows 'master'.  I can't checkout and work on any other branch.  I can
work around the problem by cloning on a box that is more open, but was
wondering if anyone knows how to fix this.

-JE
