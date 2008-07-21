From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: doc restructuring
Date: Mon, 21 Jul 2008 09:22:24 -0700
Message-ID: <7viquztdfj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <48806D03.30603@fastmail.fm>
 <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness>
 <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org> <48842FA8.5070309@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 21 18:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKyAn-0004fS-Q4
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 18:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYGUQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbYGUQWl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 12:22:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYGUQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 12:22:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1153135639;
	Mon, 21 Jul 2008 12:22:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9392435630; Mon, 21 Jul 2008 12:22:26 -0400 (EDT)
In-Reply-To: <48842FA8.5070309@op5.se> (Andreas Ericsson's message of "Mon,
 21 Jul 2008 08:41:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39850C36-5741-11DD-B6EF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89365>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> So what I really would like is this: leave the plumbing pages as
>>> they are, but enhance those pages that users (especially new ones)
>>> are likely to see most often.
>>
>> Regarding the original "do we want to ever teach plumbing to new users?"
>> issue, I suspect that, with sufficient enhancement to Porcelain, we might
>> be able to reach a point where end users can work without ever touching a
>> single plumbing command at all.
>>
>> 	Side note, that was why I suggested us to first think about use
>> 	cases in our every day work that we still need to resort to the
>> 	plumbing, so that we can identify what that enhancement would
>> 	consist of.
>>
>
> Half a year or so ago, there were some mailings to the list along the lines
> of "what git commands do you use?", using the bash history and a shell
> oneliner to dig out some crude intel. Here's mine:
> cat ~/.bash_history | grep ^git | awk '{ print $2 }' | grep -v '^--' | sort | uniq --count | sort -nr
>     29 status
>     26 diff
>     19 show
>     17 log
> ...

While that stat might be interesting to look at, it does not have 
much relevance to what I was suggesting.
