From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:57:52 -0500
Message-ID: <b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNjQ-0007Bl-W2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab0CRV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:58:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:19514 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab0CRV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:58:14 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2850030fgb.1
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=p8b5MXEGrOrCvBcMtkbHxDBAXk2QgwmBOfVMAqPskUg=;
        b=Tow0w7BZnQYkaqdakvC1Mqzd79XZPJmRBCCbI9DRjy/iqO53/q7b8SxHqs/C4Sbpg7
         jhwhTr1jbE6F8xs9HKdQR9UFjYm9zuukinMj466S6N+cHwXeWoVDD5rK2pf6CuOT/x/a
         UZzCU+XSOp1PZCssnUmOnLtxvh2fZBv5ouejo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OiQhVBa02XFjVG91/E5ILHfiqfos9zO9GX6Y4jKfw8F+W91meCb39R+XKHv96xURnB
         nbAtSn9aQLus+YeP2Ll7josmljcdTRbz79vdWMnhP6993O+LKBuWkcSOxdi4zjhqDy8D
         khYqCF6LFCz1AbWEjR8xq+pwesKN9yCQmlVLo=
Received: by 10.239.183.147 with SMTP id u19mr198940hbg.106.1268949492245; 
	Thu, 18 Mar 2010 14:58:12 -0700 (PDT)
In-Reply-To: <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142527>

On Thu, Mar 18, 2010 at 16:39, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 5:29 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> On Thu, Mar 18, 2010 at 16:19, Martin Langhoff
>>> What's the value? For me it'll be "Martin Langhoff". I already have that.
>>
>> Well, that's rather egotistical considering you're probably not the
>> only Martin Langhoff in this world. I'd advocate something like
>> "Martin Langhoff <martin.langhoff@gmail.com>".
>
> So you are saying we should change the core datamodel of git to say...
> what we already can say?

You see, Martin, you might want/need to stop using "Martin Langhoff
<martin.langhoff@gmail.com>" as your email account, but there's no
reason why you can't continue to use it for your UUID.

>> At worst, things will be just like they have always been.
>
> No, we'll have another way to have data mismatches. There are _more_
> moving parts in your model. That's what Linus is pointing out.

Mismatches in UUIDs will be the only thing worth worrying about;
fortunately, UUIDs won't change as frequently because they would be
rarely typed by git users and they are not subject to changing email
systems or changing names.
