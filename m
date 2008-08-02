From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 1 Aug 2008 17:31:57 -0700
Message-ID: <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com> <7vmyjxtco3.fsf@gitster.siamese.dyndns.org> <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com> <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP53r-0004r5-12
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 02:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYHBAc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 20:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYHBAc3
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 20:32:29 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:54703 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYHBAc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 20:32:28 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id CE5DD1250352;
	Fri,  1 Aug 2008 17:32:27 -0700 (PDT)
Received: from [192.168.1.80] (unknown [192.168.1.80])
	by mail.rapleaf.com (Postfix) with ESMTP id A86371250175;
	Fri,  1 Aug 2008 17:32:27 -0700 (PDT)
In-Reply-To: <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91125>

On Aug 1, 2008, at 1:20 AM, Junio C Hamano wrote:

> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
>> On Fri, Aug 1, 2008 at 9:30 AM, Junio C Hamano <gitster@pobox.com>  
>> wrote:
>> ...
>>> so I'll wait for a few days to hear any one of the
>>> following happen before deciding what to do with this patch:
>>>
>>> (1) Yeah, this is a sufficient and necessary set of keywords, and it
>>>    would make my Ruby life so much better;
>>>
>>> (2) This might be a good start but you need to cover this and that
>>>    keywords as well;
>>>
>>> (3) This will misidentify a line that is not the beginning of a
>>>    definition, and should not be applied;
>>>
>>> Needless to say, "Here is a better patch" is appreciated if  
>>> somebody says
>>> (2) or (3).
>>
>> I wasn't sure about the completeness of the regexp myself, which is
>
> Well, I forgot to say but the above was soliciting third party review;
> original submitter does not count ;-)
>
> ... nah, I am just joking.
>
> All of the things you said in the message I am responding to are good
> background information.  It would have been nicer if it were part of  
> the
> initial message, perhaps below the three dash lines, which would have
> avoided this extra exchange.

As a Ruby user, the regex for the funcname looks fine to me.

> Thanks again for the patch.  Somewhere I heard that there are 10  
> Rubyista
> git users for every non Rubyista git user, so I am sure somebody would
> comment on your patch in a day or two.  Perhaps we might even get  
> Python
> and Perl hunk patterns (although I suspect Perl people are happy  
> with the
> default one we stole from GNU diff) to go with it ;-).

I'd like to point out that Python users are called Pythonistas, Ruby  
users are called... uh, Ruby users, I guess.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
