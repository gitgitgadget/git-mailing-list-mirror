From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Wed, 14 Oct 2009 18:09:34 +0200
Message-ID: <4AD5F7BE.9000704@drmicha.warpmail.net>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>	 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>	 <4AD32024.6020005@drmicha.warpmail.net>	 <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>	 <4AD42A1C.1080709@drmicha.warpmail.net> <94a0d4530910140726i4465e919h77045904aa33c61a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6gu-0001oP-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761988AbZJNQKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761982AbZJNQKv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:10:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49562 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761977AbZJNQKs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 12:10:48 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DA6CAA83D8;
	Wed, 14 Oct 2009 12:09:45 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Oct 2009 12:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=PoKq+HmYbyI+MhDoK/+8afH7+Qg=; b=SnykdVOlD6D7xGWN3aRKGbFX5SOuqp7vxWZddUO2yIUWITtnmo7vesiqnlTZGxTzL9PTmVGIwyoLzQ8Mk4Qc3KgRbIYXmtQGc/aDq5nB7TBGi0oAXRJ0p3kw4la+lhj430dP8mZdjPr6sDi9tmPadu1q3tWFDhkV/7s5B1UOU4A=
X-Sasl-enc: VlaB3YC9m1P0yr+CZs24diT7Eo8kkAtHmQN8Uw1KxFpl 1255536582
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 727EB6A8F9;
	Wed, 14 Oct 2009 12:09:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091013 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530910140726i4465e919h77045904aa33c61a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130305>

Felipe Contreras venit, vidit, dixit 14.10.2009 16:26:
> On Tue, Oct 13, 2009 at 10:19 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 12.10.2009 19:09:
>>> On Mon, Oct 12, 2009 at 3:25 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Well, you do talk about "system" below, and that's about it. Also, the
>>>> configuration is not really distributed among different locations. Most
>>>> newbies interested in a *D*VCS will misunderstand this (as git having
>>>> distributed configuration).
>>>>
>>>> Alternative:
>>>>
>>>> Git's default configuration can be changed on a system wide, global (per
>>>> user) and local (per repository) level, in the order of increasing
>>>> precedence.
>>>
>>> When I read that it's not clear if the local level discards the global
>>> level completely or it's aggregated. If we specify that it's only the
>>> variables that take precedence it might be clearer:
>>>
>>> Git's configuration is composed of variables that are stored in
>>> multiple locations: 'system' (all users), 'global' (for the user), and
>>> 'repository' -- in decreasing order of precedence.
>>
>> Yep, although established lingo is "options" (not "variables"), and it's
>> really increasing order, not decreasing.
> 
> Really? I remember clearly Junio stating otherwise:
> http://marc.info/?l=git&m=123460371724873&w=2
> 
> ----
>> +	OPT_BOOLEAN(0, "unset", &do_unset, "removes an option: name [value-regex]"),
> 
> Please don't introduce a new noun "option" that has never been used to
> mean a "configuration variable" in git documentation.  It unnecessarily
> confuses everybody.
> ----

Well, Junio certainly is authoritative, and I don't want to risk any bad
patch-acceptance-fu ( :) ), but

2d2465c (Add documentation for git-config-set, 2005-11-17)

is the origin of that doc for git-config. I'm not just claiming it
myself. That commit introduced "option", uses it in all but one place,
and this never changed since then! [The ratio went up from 6:1 to 40:5]
I have no objection to changing this established notion, but established
it is. I haven't tracked down the use of option vs. variable in other
places than git-config.txt and its predecessors.

Michael
