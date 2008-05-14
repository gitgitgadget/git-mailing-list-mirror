From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 13:03:02 -0500
Message-ID: <9BD2EC5E-DE16-483B-A6AB-6E4DAF8B3239@sb.org>
References: <1210774947-27995-1-git-send-email-ian.hilt@gmail.com> <19174A63-BE44-4898-9CAD-935BE1A28FFF@sb.org> <alpine.LNX.1.10.0805141329020.28504@sys-0.hiltweb.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ian Hilt <ian.hilt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLKf-0001tf-Qw
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbYENSDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbYENSDM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:03:12 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:41534 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755649AbYENSDL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 14:03:11 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 4EDCC18DB5B;
	Wed, 14 May 2008 11:03:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0805141329020.28504@sys-0.hiltweb.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82124>

On May 14, 2008, at 1:00 PM, Ian Hilt wrote:

> On Wed, 14 May 2008 at 11:57am -0500, Kevin Ballard wrote:
>
>> On May 14, 2008, at 9:22 AM, Ian Hilt wrote:
>>> DESCRIPTION
>>> -----------
>>> The command finds the most recent tag that is reachable from a
>>> -commit, and if the commit itself is pointed at by the tag, shows
>>> -the tag.  Otherwise, it suffixes the tag name with the number of
>>> -additional commits and the abbreviated object name of the commit.
>>> +commit.  If the tag points to the commit, then only the tag is
>>> +shown.  Otherwise, the number of additional commits on top of the
>>> +tagged object and the abbreviated object name of the most recent
>>> +commit are suffixed to the tag name.
>>
>> I disagree that this is more readable. Specifically that last
>> sentence. In the original description it tells me what it's
>> doing (suffixing) before it tells me what objects it's
>> using. In your version, it tells me the objects, then tells me
>> what it's doing (suffixing), so I have to effectively process
>> the sentence in reverse. In other words, it took me two
>> readings of your last sentence to match the one reading of the
>> original last sentence.
>
> How about this?
>
>  The command finds the most recent tag that is reachable from a
>  commit.  If the tag points to the commit, then only the tag is
>  shown.  Otherwise, it suffixes to the tag name the number of
>  additional commits on top of the tagged object and the
>  abbreviated object name of the most recent commit.

How about this?

The command finds the most recent tag that is reachable from a
commit. If the tag points to the commit, then only the tag is
shown. Otherwise, it suffixes the tag name with the number of
additional commits on top of the tagged object and the
abbreviated object name of the most recent commit.

>> Also, you should use a more descriptive commit description. At the  
>> very least, do something like
>>
>> git-describe: Make description more readable.
>
> Something like this:
>
> git-describe: Changed subject from commit to tag in the first
>              sentence, clarified what the number of commits is
>              referring to, and pointed out which object is
>              referenced by the suffixed object name.

Sure, you could say that, but I think that just "git-describe: Make  
description more readable" is enough.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
