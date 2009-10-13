From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Tue, 13 Oct 2009 09:09:33 +0200
Message-ID: <4AD427AD.3010701@drmicha.warpmail.net>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>	 <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>	 <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>	 <4AD3216B.7030507@drmicha.warpmail.net> <94a0d4530910121014k666207b9ub38fcecd47641ace@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:20:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbfz-0001jz-0r
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580AbZJMHKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933577AbZJMHKn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:10:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43054 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933572AbZJMHKn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 03:10:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 25953A4C67;
	Tue, 13 Oct 2009 03:09:41 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 13 Oct 2009 03:09:41 -0400
X-Sasl-enc: Qex/uTDbxpk8TDWNCtBENCv2zzsumpHURuZfLPzbZr9V 1255417780
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 36E4A702F;
	Tue, 13 Oct 2009 03:09:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091013 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530910121014k666207b9ub38fcecd47641ace@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130135>

Felipe Contreras venit, vidit, dixit 12.10.2009 19:14:
> On Mon, Oct 12, 2009 at 3:30 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 12.10.2009 12:03:
>>> On Mon, Oct 12, 2009 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> The value is what it is, the --bool and --bool-or-int options don't
>>>>> specify the value type, just how it is interpreted. For example: a value
>>>>> of '1' can be interpreted as 'true'.
>>>>
>>>> It is not really about "interpreting", but about showing, isn't it?
>>>
>>> Unless you are setting it, instead of reading it.
>>>
>>
>> I'd still suggest fixing the typo ("interpreted") and spelling out
>> "boolean".
> 
> Oops! You mean s/intepreted/interpreted/?

Yep :)

> 
> If we spell 'boolean' we might as well spell 'integer'; I think bool
> and int are fine.
> 

"int" is at least a standard type name in C, whereas "bool" is not; but,
yes, feel free to spell out "integer", or use "--int or --bool" as it
is, which is a back reference to the corresponding entries for "--int"
and "--bool", where things should be spelled out.

Michael
