From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 14:26:00 +0200
Message-ID: <4BF135D8.70106@drmicha.warpmail.net>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net> <1274084247216-5064104.post@n2.nabble.com> <4BF10623.5000705@drmicha.warpmail.net> <1274094574729-5064574.post@n2.nabble.com> <4BF12B11.2090002@drmicha.warpmail.net> <1274098383422-5064764.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git_user101 <m.aqadjanimemar@student.ru.nl>
X-From: git-owner@vger.kernel.org Mon May 17 14:26:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODzOt-0003C7-NW
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 14:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab0EQM0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 08:26:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40669 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884Ab0EQM0V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 08:26:21 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 889A6F76F3;
	Mon, 17 May 2010 08:25:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 17 May 2010 08:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=SrVBLtsdhq37N6PhNAMFRlyx7ZI=; b=h8d0nkATgOaTB9t2x71aS7QVhqslGLnEUaqP9wlzyTbaCjaLdUEJAq6EUD1KMhuL8VTw4+9phawNcKevwT699K7RbP8WF27JXsPt8YUkJPf4EO6t3gVdrL6Jhf+kVfc5Jtx7pcrChVN3nHg3gK6ENGAh5cCYr7dPpZToKDPI04w=
X-Sasl-enc: 4LMM1n3vTBZYqitf0Zi+8lFe1Y1z/aSuDKPosZNxoW3k 1274099153
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 97CA74DE2B9;
	Mon, 17 May 2010 08:25:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274098383422-5064764.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147230>

git_user101 venit, vidit, dixit 17.05.2010 14:13:
> 
> Thank you, Michael!
> I do not understand what you exactly mean with "Also, you'll have to fix-up
> permissions manually at least
> on logs/HEAD (and probably others)"
> If you mean that I have to change the permission of logs/HEAD to read, write
> for the group,

I meant all files & dirs under ${repo}.git should be owned by the group
and +rw for the group. ["All" is actually overkill but sufficient.]

> it is already done.
> All files and directories in the repository are accessible for the group.

Hmm. If really all files and dirs (!) are group writeable I'm puzzled.
What is the complete report and error message (besides failed to push)?

A push can also fail due to non fast-forward, of course.

Michael
