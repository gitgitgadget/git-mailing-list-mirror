From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 17:50:52 +0200
Message-ID: <4E3033DC.6020103@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com> <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org> <4E2FCAC4.7020408@drmicha.warpmail.net> <7vbowfpw8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6Nw-0002Lg-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab1G0Pu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 11:50:56 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43950 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752928Ab1G0Puy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 11:50:54 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED74D20A56;
	Wed, 27 Jul 2011 11:50:53 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 27 Jul 2011 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5MsrSb4KFTR/jx5z/c1Dhn
	pDVD0=; b=OTZQgKc5iZQBtdAXHWBFnISpQnb6jhx4iEZJcAMQWX0lSFwfXXw85c
	/Ylln8HebGh0sKqDJn/luDC6cD525zK/W5hqLDgX03RhJW2ldjFvndNIkEowKxso
	6+K6rss4rvJqRpQH1mrLBXWCr4r+85x/aI6KXc7Mh8JlIxOzKtA48=
X-Sasl-enc: nbR4hKAMplJAM0/okrGL7lx1xc/hD0V8iDKvpMQFgsqG 1311781853
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6102B413AA7;
	Wed, 27 Jul 2011 11:50:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <7vbowfpw8c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177977>

Junio C Hamano venit, vidit, dixit 27.07.2011 17:41:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The one reported by the OP for commit:
>>
>> git rm ../a
>> git commit -m "blurb" ../a
>> error: pathspec '../a' did not match any file(s) known to git.
> 
> That does look like a bug given that (starting from a state where that
> "../a" is a tracked file that appear in the HEAD commit):
> 
> 	git rm ../a
>         (cd .. && git commit -m "removed a" a)
> 
> does work. For "git add ../a" after removing the path from both index and
> the working tree, see my other message.

Full agreement on both.
Now I really gotta run, sorry. But "I'll be back" :)

Michael
