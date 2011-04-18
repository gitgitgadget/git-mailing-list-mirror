From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Inconsistency with -a vs -A
Date: Mon, 18 Apr 2011 08:25:53 +0200
Message-ID: <4DABD971.20108@drmicha.warpmail.net>
References: <loom.20110418T051443-551@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bradly Feeley <bradlyf@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 08:26:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBhuW-0007Gh-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 08:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1DRGZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 02:25:57 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42658 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355Ab1DRGZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2011 02:25:56 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F77620287;
	Mon, 18 Apr 2011 02:25:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 18 Apr 2011 02:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=N4Po1ICu/3Qmy2NFcL7tq1KN0bw=; b=csIMRlFUC4kaw3TR+5SBJZ/olNFBXIlD9DOMZgT4uyAC9dm1jtXzxyK+cerqIF3cCVaO4NasMrg38WCxNhRAobR49NukD3GxITpO0klk6t1eO8OHXkgf3iGMujdHvMUJfT8KNsE3E8O7QJ5CodsSib+dsfqlK9KtVcjNVMmRSFM=
X-Sasl-enc: WRxu4g8jwnbU7+GcWNWWtjIgIQUwiz3SM8RVY7M2x+fR 1303107954
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89D204458C3;
	Mon, 18 Apr 2011 02:25:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <loom.20110418T051443-551@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171737>

Bradly Feeley venit, vidit, dixit 18.04.2011 05:20:
> I was curious if there was a reason that some command use -a and some command
> use -A. For example, to view all branches the lowercase switch 'a' is used, but
> when staging all files with add an uppercase 'A'. Of course I always pick the
> wrong one when running either command. Is there a reason for the inconsistency?

Yes.

> Do you think they should be made the same?

Yes, I do :) For more details on both "yes", see:

http://permalink.gmane.org/gmane.comp.version-control.git/167907

Cheers,
Michael
