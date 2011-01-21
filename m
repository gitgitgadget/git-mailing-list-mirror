From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 01:05:24 +0100
Message-ID: <4D38CDC4.6010803@hartwork.org>
References: <4D3893EA.5090907@hartwork.org> <201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org> <7vk4hzqnbx.fsf@alter.siamese.dyndns.org> <20110120231649.GC14184@vidovic> <20110120233429.GB9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4Vi-0002Hj-Mj
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab1AUAFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:05:31 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:41063 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab1AUAF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:05:29 -0500
Received: from [78.52.102.233] (helo=[192.168.0.2])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Pg4VI-0004Dj-Mv; Fri, 21 Jan 2011 01:05:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110103 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110120233429.GB9442@sigill.intra.peff.net>
X-Df-Sender: hartwork@binera.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165348>

On 01/21/11 00:34, Jeff King wrote:
>>> Yes; the alternative is to list everything.
>>
>> Would it be bad? I tend to think that a manual page is the good place to
>> list everything the program accepts as parameters and how to use them.
>> FMHO, Manual page is not where newcomers look to learn but it should
>> help everybody to find and understand all of the available options.
> 
> The problem is that we have a bazillion diff options that appear in many
> manpages, so you are stuck with one of:
> 
>   1. repeat them all in each manpage (usually via some automagic
>      include), which dwarfs the original content, and makes it hard for
>      users to see subtle differences between commands
> 
>   2. Say "this describes only the most frequently used options", which
>      leaves the user wondering which infrequently used options exist.
> 
>   3. Say "we also take diff options, and you can find out more about
>      diff options in git-diff(1)." This at least points the user in the
>      right direction, but you can't search for "--color-words" in the
>      page.
> 
>   4. Do (3), but also list the all (or common) diff options in a succint
>      list without descriptions, and refer the user to git-diff(1). Then
>      they can grep if they like, and while they won't get the immediate
>      answer, they will get referred to the right place.
> 
> As you can probably guess, I favor option (4), though we already do (3)
> in some places.

I agree with Thomas here.  (1) is the only option I find acceptable,
personally.  If you'd rather not do that, then at least know I now.
Great to have --color-words around btw.

Best,



Sebastian
