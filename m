From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 01 Aug 2008 01:20:10 -0700
Message-ID: <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 10:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpt1-0002TA-8S
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 10:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYHAIUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 04:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbYHAIUS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 04:20:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYHAIUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 04:20:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3226549237;
	Fri,  1 Aug 2008 04:20:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8501D49236; Fri,  1 Aug 2008 04:20:12 -0400 (EDT)
In-Reply-To: <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
 (Giuseppe Bilotta's message of "Fri, 1 Aug 2008 10:11:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB2919E0-5FA2-11DD-8A75-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91043>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> On Fri, Aug 1, 2008 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> so I'll wait for a few days to hear any one of the
>> following happen before deciding what to do with this patch:
>>
>>  (1) Yeah, this is a sufficient and necessary set of keywords, and it
>>     would make my Ruby life so much better;
>>
>>  (2) This might be a good start but you need to cover this and that
>>     keywords as well;
>>
>>  (3) This will misidentify a line that is not the beginning of a
>>     definition, and should not be applied;
>>
>> Needless to say, "Here is a better patch" is appreciated if somebody says
>> (2) or (3).
>
> I wasn't sure about the completeness of the regexp myself, which is

Well, I forgot to say but the above was soliciting third party review;
original submitter does not count ;-)

... nah, I am just joking.

All of the things you said in the message I am responding to are good
background information.  It would have been nicer if it were part of the
initial message, perhaps below the three dash lines, which would have
avoided this extra exchange.

Thanks again for the patch.  Somewhere I heard that there are 10 Rubyista
git users for every non Rubyista git user, so I am sure somebody would
comment on your patch in a day or two.  Perhaps we might even get Python
and Perl hunk patterns (although I suspect Perl people are happy with the
default one we stole from GNU diff) to go with it ;-).
