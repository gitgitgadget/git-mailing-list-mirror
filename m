From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 13:53:20 +0100
Message-ID: <4BA373C0.2070506@gnu.org>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 	<b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com> 	<4BA36F5F.9080706@gnu.org> <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>, tytso@mit.edu,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsbi2-0007xf-Pk
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab0CSMx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:53:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64500 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0CSMx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:53:27 -0400
Received: by pwi5 with SMTP id 5so1201539pwi.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HpB6GCHNDlTkHae40uiKL3mDIh2Ln2TmCfonlMIV1ys=;
        b=I9/BT+xaai/ZCK6ccV9GEhKlzpjJrpe5Cp1yqOlltM5N53yNBTF4Kq7i/9hOrIJ9Di
         a9pOIZkSphZO/0TsCSd+Z+Yo8b6XjCozKHy6/chFewORbknoBUZ/JLjdgLEFDf5CDYAX
         +HkhOnBOGrd5tm3U50g7Y+HoJHU+zleRsRbFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lYKVdKDue+F6Ycd9/XtDF59VSoqLvrcmoMI1zTl/uvmWy0aXo642b5HlveQF0OJw6N
         R7UrwAAnLPXgGFVA5eVjZ/8Bhvn0AC0M/udMIWeecShRFR/WvyRL43a3mDWwVVadBUMS
         AP5xyuZziI0gPEILFDV+r4igJ/eb8UOwOrqkA=
Received: by 10.114.242.7 with SMTP id p7mr3208863wah.37.1269003206577;
        Fri, 19 Mar 2010 05:53:26 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 20sm442809iwn.13.2010.03.19.05.53.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 05:53:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142587>


>> While a gnu.org or gmail.com will (most likely) stay with some
>> person forever, hindsight is 20/20 and many people may generate
>> his UUID from a work email.  So, suppose I make my UUID based
>> on<pbonzini@redhat.com>  what will guarantee that in 20 years I
>> won't find a new career as a bartender, and Red Hat wouldn't hire
>> someone with my same name, and give him the same email address?
>
> Firstly, the UUID need not be a name/email pair.

That's what you lastly proposed generating it from.

> Secondly, you're being ridiculous; even if that ridiculous scenario
> played out not-infrequently

It's not a matter of frequency.  If you want a "UU" identification,
collisions must not even happen *once*.

>> I have an idea.  Start your own website uuidemail.com.  One
>> registers and gets an alias for their email, something like
>> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b@uuidemail.com.  Then
>> people can start using
>> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b+pbonzini--redhat.com@uuidemail.com
>> as their git user.email.  I bet nobody will.
>
> This is nonsense that betrays your misunderstanding.

Why?  What does (name, email, uuid) provide over (name, concat(uuid, 
email))?  Nothing.

But the point is, neither really provides anything over (name, email).

Paolo
