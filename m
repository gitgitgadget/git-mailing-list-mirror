From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
   998 symbols
Date: Fri, 21 Nov 2008 13:49:18 +0100
Message-ID: <4926AE4E.5000604@drmicha.warpmail.net>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com> <20081121115813.GB3747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3VT5-0003Rk-1p
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbYKUMtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbYKUMtX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:49:23 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55784 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753938AbYKUMtW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 07:49:22 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9B52F1C17D2;
	Fri, 21 Nov 2008 07:49:21 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 21 Nov 2008 07:49:21 -0500
X-Sasl-enc: e9qWfcc1C3cps6bZDJ0pzwOKGhETN9fcu3wf7sN/O2Gg 1227271761
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E1CB71E711;
	Fri, 21 Nov 2008 07:49:20 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <20081121115813.GB3747@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101523>

Jeff King venit, vidit, dixit 21.11.2008 12:58:
> On Fri, Nov 21, 2008 at 11:59:24AM +0200, Andy Shevchenko wrote:
> 
>> By default git-send-email does not accept patch which is contain lines longer
>> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
>> variable in shell script. So, define environment variable
>> GIT_SEND_EMAIL_LONGLINE to something to avoid that restriction.
> 
> This already exists as "git send-email --no-validate", which
> unfortunately doesn't seem to be documented. Care to send in a
> documentation patch instead?

In fact it is documented in git-send-email.txt:

--[no-]validate::
        Perform sanity checks on patches.
        Currently, validation means the following:
+
--
                *       Warn of patches that contain lines longer than
998 characters; this
                        is due to SMTP limits as described by
http://www.ietf.org/rfc/rfc2821.txt.
--
+
Default is the value of 'sendemail.validate'; if this is not set,
default to '--validate'.


Cheers,
Michael
