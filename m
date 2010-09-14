From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Mon, 13 Sep 2010 22:47:30 -0600
Message-ID: <4C8EFE62.7080908@workspacewhiz.com>
References: <4C8866F9.1040705@workspacewhiz.com> <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com> <4C88F2A9.2080306@workspacewhiz.com> <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com> <20100910141527.GA6936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCA=?= =?UTF-8?B?Qmphcm1hc29u?= 
	<avarab@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 06:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvNQd-0000qx-2v
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 06:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab0INEr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 00:47:29 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:47230 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab0INEr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 00:47:29 -0400
Received: (qmail 2714 invoked by uid 399); 13 Sep 2010 22:47:28 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 13 Sep 2010 22:47:28 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100910141527.GA6936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156160>

  ----- Original Message -----
From: Jeff King
Date: 9/10/2010 8:15 AM
> On Fri, Sep 10, 2010 at 03:35:21PM +1000, Jon Seymour wrote:
>
>> This is probably the cultural shift that is hardest for enterprises to
>> accept - why do I need a _person_ to do this _manual_ work when tools
>> like {insert favourite non-DVCS here} can do this for me? To
>> management, this looks like a step-backwards.
> Bear in mind that you can still shift to a maintainer model, but keep
> the maintainer automated. That is, you can queue up "to-pull" heads, and
> then have an automated process pull them one by one and do some basic QA
> (does it merge, does it build, does it pass automated tests, etc). Which
> is not that different from what many shops do in the non-maintainer
> model, except that when you break the build, the maintainer process
> notices _before_ publishing the merged tip, so everybody won't try to
> build on your broken crap.
>
Do you know of any existing software that does this?  This may be ideal 
in the short term.
> I still prefer a human maintainer, because they can do things like
> reorder the queue manually (or outright reject flaky topics) to get more
> sensible merges, or do easy but non-trivial merges themselves to avoid
> kicking code back to the developer.
>
I agree with you concerning how valuable a human maintainer is.

Josh
