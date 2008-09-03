From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 09:45:08 +0200
Message-ID: <200809030945.08619.johan@herland.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <200809022339.20123.johan@herland.net>
 <20080902214428.GA20355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 09:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kan4t-0001vL-8N
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 09:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYICHph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 03:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbYICHph
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 03:45:37 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50689 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYICHpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 03:45:36 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6M0072507Z2G00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Sep 2008 09:45:35 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6M002HS0785H70@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Sep 2008 09:45:08 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6M007NA0782H50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Sep 2008 09:45:08 +0200 (CEST)
In-reply-to: <20080902214428.GA20355@sigill.intra.peff.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94757>

On Tuesday 02 September 2008, Jeff King wrote:
> On Tue, Sep 02, 2008 at 11:39:20PM +0200, Johan Herland wrote:
> > I'm not sure I like this personally, but if we _really_ don't want
> > newbies to shoot themselves in the foot, we could make "git commit"
> > fail on a detached HEAD unless the user has indicated that s/he knows
> > what's going on; i.e. something like this:
>
> This was discussed to death when detached HEAD was introduced, and the
> decision was to go with the current behavior. Try looking in the list
> archives around December 2006 / January 2007 if you are truly
> masochistic.

Ok. Scratch that.

But what happened to the various suggestions in that original thread on 
adding a safety valve when _leaving_ the detached state (i.e. preventing 
the user from leaving their detached commits unreachable)?

It seems to have been suggested (in various forms) by several people and 
generally well-received in the original thread, but nothing seems to have 
come of it (at least nothing that has survived till today).


Apparently masochistic,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
