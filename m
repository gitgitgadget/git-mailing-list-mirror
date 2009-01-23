From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 09:45:29 +0900
Message-ID: <20090123094529.6117@nanako3.lavabit.com>
References: <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
 <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAD0-0003yu-Jy
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbZAWAqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbZAWAqI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:46:08 -0500
Received: from karen.lavabit.com ([72.249.41.33]:43052 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbZAWAqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:46:04 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id DF250C888B;
	Thu, 22 Jan 2009 18:46:03 -0600 (CST)
Received: from 9837.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id PTWLV8ZJNWD5; Thu, 22 Jan 2009 18:46:03 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=RR2ck8ThkrWEYr7M0a6OKQ0foe2zc7pdJAEvYn1ofH5PJ19hqZvzw2ttSe4NPAc5/ic/Z7pBLYzOodbbSZHvspSkfbQG2MZCsyc0stajCyi5rpJfU14LqpVnZnRtYIX8EvPt2ZmWRL6eyNtQbfshoomw9pr2wzJ1Magv2e0Zzc8=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106812>

Quoting Junio C Hamano <gitster@pobox.com>:

> Christian MICHON <christian.michon@gmail.com> writes:
>
>> I'd like to force the commit date to match the info/date from the time
>> I received the email (and therefore always get back the right
>> sha1sums).
>>
>> is this possible ?
>
> "am" being a tool to accept patches written in some past to faithfully
> record both author timestamp and committer timestamp, what you seem to
> want is outside of the current scope of the tool.
>
> A patch to butcher "git-am" to copy GIT_COMMITTER_DATE from
> GIT_AUTHOR_DATE and export it should be trivial to implement, though.
>
> Perhaps something like this totally untested patch.

You have test scripts already, but you say it is untested?

I often wanted to have an opposite of what Christian wants. I always have some changes I am holding off, and when I decide to trickle them out to the main repository, I do not want the resulting commit to carry old dates that are recorded in the format-patch output. Instead I want to pretend that I worked on them today. Is this something you can teach git-am and git-rebase to do easily?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
