From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: color (red) for error messages on all git commands
Date: Thu, 25 Mar 2010 09:43:32 +0100
Message-ID: <4BAB2234.4070202@drmicha.warpmail.net>
References: <hoe4j3$2vg$1@dough.gmane.org>	 <fabb9a1e1003241558t4c4c5cf8t3a7d9b9856937c4f@mail.gmail.com> <81b0412b1003241612m41f6ae2ctaa5b89ed37b58da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 09:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuii8-0004SG-M8
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 09:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab0CYIqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 04:46:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55993 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751616Ab0CYIqW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 04:46:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A6B39E9046;
	Thu, 25 Mar 2010 04:46:21 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 25 Mar 2010 04:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TwHXsCMQLlJ3bcqMtO1Gi4BwWlU=; b=hfN3AeLJt85OV4sJu7HKUwoqJbs89SRvC3P5V9Lwgz6Uppd6vA7IPfxQpKIrcjkV/Cp10Rwm5hun6vaRHvaqmDfX7Jb8JhuoSPleSKPz3OJMT1RtnjyURWMPsRYlGoqVE6bmp/2+ZO/xt5gfwEcGfW1j+B+k6mTjWW0BZa05lrc=
X-Sasl-enc: uo8j7HBTWzFNitmigXRcnjXhqDgt2Jo8D+q2Z1qPNFwv 1269506781
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C46343BB05;
	Thu, 25 Mar 2010 04:46:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <81b0412b1003241612m41f6ae2ctaa5b89ed37b58da2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143169>

Alex Riesen venit, vidit, dixit 25.03.2010 00:12:
> On Wed, Mar 24, 2010 at 23:58, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Wed, Mar 24, 2010 at 23:44, Neal Kreitzinger <neal@rsss.com> wrote:
>>> Desired Solution:  configure git to display all error messages in color,
>>> e.g. red, so that the programmer does not overlook error messages.
> 
> It is considered a good behavior for a UNIX program only to display
> something if there is an error. Git just tries to follow this tradition.

Oh well... Then I presume I'm not the only one who is annoyed by
"Initialized empty Git repository in ...", especially when you clone
locally and that is the only response you get! I'm embracing for the
response to my upcoming RFC...

Note that we also do a lot of progress messages (fetch from remotes,
committing, checking out, ...), and that is why distinguishing
warnings/error messages makes a lot of sense.

>> That's actually something I run into as well, I am so used to git just
>> doing what I want that I don't notice the error messages when they
>> occur. If this is indeed desired (probably controlled by color.warning
>> and color.error?) it should be fairly easy to implement (see usage.c).
> 
> That said, I also like the idea. Don't forget to check for tty in the patch.

Me too :)

Michael
