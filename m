From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 21:20:55 +0200
Message-ID: <200706102120.55758.johan@herland.net>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <200706101514.14954.johan@herland.net>
 <Pine.LNX.4.64.0706101952180.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSyD-00026P-Dm
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbXFJTVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXFJTVA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:21:00 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43951 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbXFJTU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:20:59 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00803PQYPM00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:20:58 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00EIDPQWKZ10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:20:56 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00KGNPQVKB90@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:20:56 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706101952180.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49759>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> On Sun, 10 Jun 2007, Johan Herland wrote:
> > Small typo here. "core.showannotaions" should be "core.showannotations",
> > I guess.
> 
> Yep. I tested it with "core.shownotes", but decided before sending the 
> patch that the name would be inconsistent with the rest of the code.
> 
> However, as I suggested later, I could imagine that an even better way 
> could be to have "core.annotationsRef", overrideable by 
> GIT_ANNOTATIONS_REF, which could possibly even be a list of refs.
> 
> BTW I am not married to calling it "annotations". If you like "notes" 
> better, I'm fine with it.

No problem. Actually I really wanted to call my first
proof-of-concept "annotations", and not "notes", but I
figured it would be confused with the "annotate-as-in-blame"
concept. Besides there is already a git-annotate command...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
