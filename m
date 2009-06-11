From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been removed from CVS
Date: Thu, 11 Jun 2009 10:04:54 -0700
Message-ID: <7vzlcehfbd.fsf@alter.siamese.dyndns.org>
References: <4A1F1CF5.8030002@yahoo.co.uk>
	<e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
	<4A311053.5060802@yahoo.co.uk>
	<7vr5xqixd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Woolley <nickwoolley@yahoo.co.uk>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:05:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEni9-000205-Hq
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 19:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZFKREx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 13:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbZFKREx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 13:04:53 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52928 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZFKREw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 13:04:52 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611170455.VOMP17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Thu, 11 Jun 2009 13:04:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 2h4u1c0054aMwMQ04h4u73; Thu, 11 Jun 2009 13:04:54 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=BAjMoHc70cUA:10 a=UCtxeOKJ4AkA:10
 a=ybZZDoGAAAAA:8 a=BrDiTsk0AAAA:8 a=HicG_C9RLb5HKpLDdNsA:9
 a=MGjA21EUCEZpExFOYRWQSM2Djl4A:4 a=qIVjreYYsbEA:10 a=-hJg1tCh9CgA:10
X-CM-Score: 0.00
In-Reply-To: <7vr5xqixd1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 11 Jun 2009 08\:49\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121351>

Junio C Hamano <gitster@pobox.com> writes:

> Nick Woolley <nickwoolley@yahoo.co.uk> writes:
>> Mike Ralphson wrote:
>>> cvs commit: Up-to-date check failed for ` space'
>>> cvs [commit aborted]: correct above errors first!
>>> * FAIL 15: re-commit a removed filename which remains in CVS attic
>>> * failed 1 among 15 test(s)
> But it does seem to be repeatable; I wouldn't rule out a race condition.

Ehh, sorry, it "does not" seem to be repeatable.  Sometimes and only
sometimes it fails...
