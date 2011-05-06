From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git status
Date: Fri, 06 May 2011 09:48:52 +0200
Message-ID: <4DC3A7E4.30204@drmicha.warpmail.net>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org> <BANLkTi=teRP8cMJeDC+khUtYD61SmeSdLA@mail.gmail.com> <20110505232650.GD636@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 09:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIFmX-00058H-6p
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 09:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab1EFHsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 03:48:55 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33643 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282Ab1EFHsy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 03:48:54 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 914EA208E5;
	Fri,  6 May 2011 03:48:54 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 06 May 2011 03:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LiWYZ3eQLFKs/s4ao5MQEGe/lmA=; b=Fs1sZBNgtwgv48l8Wi/whf0uJ6sCy6GquQ+jIGW5VlzuTPRFPkt42I6E94tlc30snNYJ/TcD3ojobxL90Hb+lBQBtAvo4LZI0oZvx5KdfFEZ05iDUA0QpWHYTIyf/kIpDE1IUQkpxyXFt67HDd0yemjAfmASb+bPD5GrOxgHBQ4=
X-Sasl-enc: /XsO8X6+9XiN8UdP2xdnTbJATPXvA1mAxx0QJS+mx/Ct 1304668134
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA914404A24;
	Fri,  6 May 2011 03:48:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110505232650.GD636@madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172953>

Pierre Habouzit venit, vidit, dixit 06.05.2011 01:26:
> On Fri, May 06, 2011 at 01:06:45AM +0200, Sverre Rabbelier wrote:
>> Heya,
>>
>> On Thu, May 5, 2011 at 23:48, Pierre Habouzit <madcoder@debian.org> wrote:
>>> This provides the same information as the git bash prompt about the
>>> current operation that is going on: rebase, merge, am, cherry-pick or
>>> bisect.
>>
>> Can you show how this will look like?
> 
> Sure, it adds a line on the top with the same color as "not on any
> branch" iff there is an ongoing operation.
> 
> Of course in this setup it makes no sense since my shell shows it
> already, but I'm frustrated when I use git on a remote machine where I
> don't have zsh installed or configured, and at work many people would
> like to know where they left stuff before they grabbed coffee and talked
> for 1h instead of taking 5 minutes ;)

I think this is useful and nice in the compactified version suggested by
Junio. Be prepared for someone requesting it with "status -s -b" :)

What became of the colouring of the git-prompt, btw? I see you're using
some, and I remember a stalled effort to have this in our shipped
completion. Do have something shareable in that respect?

Michael
