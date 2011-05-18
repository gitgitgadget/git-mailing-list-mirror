From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Wed, 18 May 2011 11:26:07 +0200
Message-ID: <4DD390AF.9020705@drmicha.warpmail.net>
References: <20110517071232.GA19396@mrq1.org> <4DD369C3.4070806@pcharlan.com> <20110518064515.GA29612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 11:26:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMd1E-0002yI-MJ
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 11:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab1ERJ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 05:26:10 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44238 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754865Ab1ERJ0J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 05:26:09 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1901C20910;
	Wed, 18 May 2011 05:26:09 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 18 May 2011 05:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=eHXWsTXV9JingSLw4gAX/4g3tyA=; b=jLyKyS+7vrz1+KnfnRa+TGmOH7ikU2l6ngeLBkp+Qquztin7zKY2qf5eHCiIB8cULAxHaor60SAwMObKD00M8/lPfJ8eMP/dkejBidanJu3WOiub/xqD90i0fgze+0IbD+z2Uw3qd8R8ba9is9+lCCqWEBe3adrYYtp/amQRZd0=
X-Sasl-enc: GbHhVpAyeRKfrY60PTD7jiz5KSv1ZGplKn/dZWz7+ZJY 1305710768
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 594154441BC;
	Wed, 18 May 2011 05:26:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110518064515.GA29612@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173868>

Jeff King venit, vidit, dixit 18.05.2011 08:45:
> On Tue, May 17, 2011 at 11:40:03PM -0700, Pete Harlan wrote:
> 
>> On 05/17/2011 12:12 AM, Hermann Gausterer wrote:
>>> this combines the two "add -i" commands "y"+"q" to one.
>>
>> ...
>>
>>>         y - stage this hunk
>>>         n - do not stage this hunk
>>>         q - quit; do not stage this hunk nor any of the remaining ones
>>> +       Q - stage this hunk but none of the remaining ones
>>>         a - stage this hunk and all later hunks in the file
>>>         d - do not stage this hunk nor any of the later hunks in the file
>>>         g - select a hunk to go to
>>
>> If "q" means "quit", I would expect "Q" to mean something like "quit
>> immediately" (perhaps even undoing earlier adds), not "do something
>> that 'q' wouldn't do, and then quit".
> 
> I agree. There was some discussion in another thread recently of the
> atomicity of git-add (right now it applies the changes to each file
> after all of its hunks are done). I would expect "q" to be "quit and
> apply what I told you so far" and "Q" to be "quit and do not apply
> anything".
> 
>> Perhaps "o" (for "stage exactly [o]ne commit"), or "t" for "stage
>> [t]his commit" would be reasonable alternatives?
> 
> We could also allow multiple commands at once, like "yq" (even in
> single-key mode, this would do the same thing).

So instead of having to

press y press q

I can now

hold SHIFT press q

Seeing the gain in that fails me completely. Also, why doesn't "yd"
deserve a shortcut? I would expect that to be used more often, as in:
"Yes, that was the hunk I wanted to add from this file, but what other
files have changes"?

Michael
