From: "Michael J Gruber" <git@drmicha.warpmail.net>
Subject: Re: [PATCH] clone: quell the progress report from init and report on
 clone
Date: Sun, 04 Apr 2010 15:02:15 +0200
Message-ID: <1270386135.1675.1368217929@webmail.messagingengine.com>
References: <7v7houxu8n.fsf@alter.siamese.dyndns.org><4462210481812dc3b720b34f59e3051a65e41336.1270159202.git.git@drmicha.warpmail.net>
 <7vljd6l3dn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 15:02:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyPT4-0003vS-L7
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0DDNCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:02:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42307 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752413Ab0DDNCP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 09:02:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2AFF3EA644;
	Sun,  4 Apr 2010 09:02:15 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Sun, 04 Apr 2010 09:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=14+WvRp6sSelDDHr8PYMlJIGeHo=; b=kv6VMtKmp+egrcF/psr1IbBSOsq5IlPve3uBkGN8biG8Es6tAVz3zGj5Qi8SQvAfeFoNGDKiCyQn5HwZjbd48xDhGPlc2ftwlZT53Zdef0RUgMukPux5RkBntoTXs0nWZhrcUhDhEOarTNMcX2mL5d9IrTIw9OdO5wh417upAMM=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 0AF071898D1; Sun,  4 Apr 2010 09:02:15 -0400 (EDT)
X-Sasl-Enc: RpR8wOgsm/mJL4Si6xZKjepup4R6aiXd0bEOlfbEdtBK 1270386135
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7vljd6l3dn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143921>

On Fri, 02 Apr 2010 00:28 -0700, "Junio C Hamano" <gitster@pobox.com>
wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > Currently, a local glit clone reports only initializing an empty
> > git dir, which is potentially confusing.
> 
> glit?

Sorry, this glitch clomes from the clone clommand of glit.
 
> > Instead, report that cloning is in progress and when it is done
> > (unless -q) is given, and suppres the init report (unless -v
> > is given).
> >
> > Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> > ---
> > I checked the documentation, there is really no place where the output
> > of git clone is documented - no documentation or test change is necesessary.
> 
> Thanks.
> 
> > I made it so that -v will restore the init message.
> 
> I wonder how that would be useful, though.  The new message already says
> which directory is being worked on.  I didn't see a point of repeating
> that and made it silent on purpose.
 
Well, the idea is that '-v' should do at least something, and often (for
other commands) shows the individual steps of an action. The steps here
are init+clone.
Personally, I don't really care for either option.

Michael
P.S.: I'm sparsely online this week. Please don't mind if my responses
come in late.
