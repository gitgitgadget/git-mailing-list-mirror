From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 01:27:54 +0100
Message-ID: <4D38D30A.3040707@hartwork.org>
References: <4D3893EA.5090907@hartwork.org> <201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org> <7vk4hzqnbx.fsf@alter.siamese.dyndns.org> <20110120231649.GC14184@vidovic> <20110120233429.GB9442@sigill.intra.peff.net> <4D38CDC4.6010803@hartwork.org> <20110121002020.GA7874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4rC-0004ra-L1
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab1AUA16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:27:58 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:50457 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab1AUA15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:27:57 -0500
X-Greylist: delayed 15803 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2011 19:27:57 EST
Received: from [78.52.102.233] (helo=[192.168.0.2])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Pg4r5-0007FQ-1d; Fri, 21 Jan 2011 01:27:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110103 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110121002020.GA7874@sigill.intra.peff.net>
X-Df-Sender: hartwork@binera.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165352>

On 01/21/11 01:20, Jeff King wrote:
>> I agree with Thomas here.  (1) is the only option I find acceptable,
>> personally.  If you'd rather not do that, then at least know I now.
>> Great to have --color-words around btw.
> 
> I'm curious why (4) doesn't work for you. I assumed you came to the
> problem by one of:
> 
>   - you wanted to know which options "git show" had, so you looked in
>     the manpage. Nothing told you about "--color-words", nor referred
>     you to a list of diff options. With (4), you would find that it
>     accepted all diff options, and then go read the list of diff options
>     (if you weren't already familiar with it).
> 
>   - you knew about --color-words, and wondered if "git show" supported
>     it. In the current case, searching the page turns up nothing. In
>     option (4), a search would find it (with a reference to diff options
>     if you wanted more details).
> 
> The downside is that you sometimes have to be referred. The upside to me
> is that it becomes explicit that there is a concept of "diff options"
> that you can look up easily and which we can refer to easily in other
> parts of the manual. That helps establish a mental model of how git's
> options work.
> 
> So is it just that being referred is annoying, or something else?

Actually that approach is perfect.  I misunderstood (4) on the first
read somehow.  Really not my day today, sorry.  I would love to see you
push (4) forward.

Best,



Sebastian
