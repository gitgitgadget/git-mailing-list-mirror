From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Thu, 08 Sep 2011 11:24:47 +0200
Message-ID: <4E6889DF.7030404@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:25:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1aqz-0004vZ-8O
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab1IHJYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:24:55 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46179 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351Ab1IHJYy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 05:24:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 512662A7EE;
	Thu,  8 Sep 2011 05:24:49 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 08 Sep 2011 05:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=jxVeMYAQBKmru67VFQWdcY
	T2gYw=; b=eDnsE69ocBLtvSqWcn0ZkjVJx4cCvUKC0/VJgYNyMJxJMvgD8tqq3K
	XVUSaqCeWFi92JeVEisB9johIvwfUpB+m1IlWjByHc728pVlBnDVaLz/OKf2L5A/
	sZeXfW6iLu93dFWQsbucKgz0wVBsZTVrkYHBXJCugsLAjk7CiL3vU=
X-Sasl-enc: UoDXx/Ft4vgUPpn8TBnoegWHXhou2m4JiAfM+p/YOLNN 1315473889
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ADE56412A0D;
	Thu,  8 Sep 2011 05:24:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110907195611.GD13364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180957>

Jeff King venit, vidit, dixit 07.09.2011 21:56:
> On Sun, Aug 28, 2011 at 04:37:04PM +0200, Michael J Gruber wrote:
> 
>> Currently, "-m -d" is forbidden", but "-m -v" is "-m", same for "-d -v".
>> Do we want to keep it like that? Probably. I'll add the tests to 4/5.
> 
> Yes, I think so. "-v" just means "be more verbose"; the fact that
> there is currently nothing to be more verbose about with "-m" and "-d"
> is irrelevant.
> 
> It does make me a little nervous about the "'git branch -v'
> automatically means 'git branch --list -v'" patch, though. It closes the
> door in the future to us being more or less verbose about branch
> creation details (and while helpful, it creates a slight inconsistency
> in the interface).
> 
> If we are adding "-l" anyway, is it really necessary? It's not much
> harder to do "git branch -lv" once that is in place.

Well, it will take a while to (re-)take "-l". For the sake of
consistency I wouldn't mind making "--verbose" strictly a "modifier" for
whatever mode/subcommand of the command is going on, even though it
would mean having to type "-v --list" for a long time. In general,
-v/--verbose should always be like that, but is not (e.g. tag -v).

This is in next now but no harm would be done changing it now.

Michael
