From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 13:34:39 +0100
Message-ID: <4BA36F5F.9080706@gnu.org>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> <b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>, tytso@mit.edu,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsbQ0-0006q6-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0CSMew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:34:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43495 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0CSMeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:34:50 -0400
Received: by pwi5 with SMTP id 5so1195400pwi.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0f8AQqk2difbPToBhfOhTG5r2yLtZnSVfMU5tSygluk=;
        b=kmmDR1MMAQpEXzjyf597KhNEDACgnrzb6nxrDVK05g/2a5rFueCXD+Wqs9MNOh4iOU
         3RnTFMCK16u0GKOq0XZ4ewqwhBtb5zED07Be2QMj73xerhsFWoK0d7wvZLK0Jnkyk6l1
         8yjCkdpXrG792XB76oiI465iEqmqK6MCkfFpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=mrCELlb7SLkftG3vZg1sN0wEp4C3bvmQbAeyDMogGUMNIoFa/wfLWIHcclrktb/Zi4
         aCvH1NNxGDVY5kN6TbEW/F/yhNHZBduXNwxkGx0YuHD2tbEhlhSzvA5CvxuDOE9+XX9a
         rhdO15S6wg2j5IBwMba7fnLDqfumpF+2Av/Ro=
Received: by 10.141.2.7 with SMTP id e7mr1417485rvi.60.1269002086472;
        Fri, 19 Mar 2010 05:34:46 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 20sm885159pzk.3.2010.03.19.05.34.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 05:34:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142584>

On 03/18/2010 10:57 PM, Michael Witten wrote:
> On Thu, Mar 18, 2010 at 16:39, Martin Langhoff
> <martin.langhoff@gmail.com>  wrote:
>> On Thu, Mar 18, 2010 at 5:29 PM, Michael Witten<mfwitten@gmail.com>  wrote:
>>> On Thu, Mar 18, 2010 at 16:19, Martin Langhoff
>>>> What's the value? For me it'll be "Martin Langhoff". I already have that.
>>>
>>> Well, that's rather egotistical considering you're probably not the
>>> only Martin Langhoff in this world. I'd advocate something like
>>> "Martin Langhoff<martin.langhoff@gmail.com>".
>>
>> So you are saying we should change the core datamodel of git to say...
>> what we already can say?
>
> You see, Martin, you might want/need to stop using "Martin Langhoff
> <martin.langhoff@gmail.com>" as your email account, but there's no
> reason why you can't continue to use it for your UUID.

While a gnu.org or gmail.com will (most likely) stay with some person 
forever, hindsight is 20/20 and many people may generate his UUID from a 
work email.  So, suppose I make my UUID based on <pbonzini@redhat.com> 
what will guarantee that in 20 years I won't find a new career as a 
bartender, and Red Hat wouldn't hire someone with my same name, and give 
him the same email address?

Heck, some people use gmail only for their personal email, and they 
rightly cannot be bothered to create another account to solve a problem 
they don't understand and they probably do not have.

For the UUID to make sense, it would need to be what the acronym says: 
universally unique.  An SHA-1 value is _not_ universally unique, it is 
just a one-way function.  There are tons of git repos out there with a 
blob hashing to e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 or 
257cc5642cb1a054f08cc83f2d943e56fd3ebe99.

I have an idea.  Start your own website uuidemail.com.  One registers 
and gets an alias for their email, something like 
8aacc35ffca0d34fccf8a750e84e3a81bdcb940b@uuidemail.com.  Then people can 
start using 
8aacc35ffca0d34fccf8a750e84e3a81bdcb940b+pbonzini--redhat.com@uuidemail.com 
as their git user.email.  I bet nobody will.

Paolo

ps: Yes, in a perfect world it would be nice for people to know that I 
am the same person independent of whether I contribute as 
bonzini@gnu.org or pbonzini@redhat.com.  But we're not in a perfect 
world, so amen.
