From: "Josh England" <jjengla@sandia.gov>
Subject: Re: empty directories
Date: Thu, 23 Aug 2007 09:24:08 -0600
Message-ID: <1187882648.5986.171.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 17:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOEX4-0000R0-Db
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 17:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762553AbXHWPXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762117AbXHWPXf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 11:23:35 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:1351 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762155AbXHWPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 11:23:34 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Thu, 23 Aug 2007 09:23:21 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7NFNCNs010158;
 Thu, 23 Aug 2007 09:23:13 -0600
In-Reply-To: <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.23.75624
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='LEO_OBFU_SUBJ_RE
 0.1, BODY_SIZE_500_599 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0,
 __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070823152323; SEV=2.2.2; DFV=B2007082311;
 IFV=2.0.4,4.0-9; AIF=B2007082311; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364344413636412E303032343A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082311_5.02.0125_4.0-9
X-WSS-ID: 6AD379E33HO111818-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56505>

On Wed, 2007-08-22 at 16:25 -0700, Linus Torvalds wrote:
> But if .gitattributes would work, you probably could introduce both full 
> permissions and ownership rules there. We read git attributes for *other* 
> reasons when checking files out _anyway_, ie we need the CRLF attribute 
> stuff, so adding ownership attributes would not be at all odd.

OK, this looks like it has the desired effect.  commits/pulls/etc catch
and update the execute bit.  I'll try to find how .gitattributes hooks
in.  Any pointers/tips are appreciated.

-JE
