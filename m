From: John Tapsell <johnflux@gmail.com>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 04:07:08 +0000
Message-ID: <43d8ce651003042007o4e41e527j8f64c898e7492d70@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org>
	 <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
	 <43d8ce651003041900x66000be4s9a15ab0cde3a0fe7@mail.gmail.com>
	 <32541b131003041919u6a477b46s447a6aeb18f3b393@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 06:25:48 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnOq9-0002qR-VG
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 05:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab0CEEHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 23:07:10 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40511 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0CEEHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 23:07:09 -0500
Received: by pzk32 with SMTP id 32so1134265pzk.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 20:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TrKn6rU8spv0V0RI1RcO5FLAM7udhTvLuPTR3LvT/wo=;
        b=n+zYzD9M/zvwcK9+J4gLqcOH7KN5WJ9UyXZOtMx7TuGigYrdlJNRsKthutM7MIOfZE
         ACMi7btOQ0f+m048XmTdtwjNyaIc1H3wF4Qrbbyt+lhPut0ZRfN0o8kYM4UXEFCZvz7k
         hpIvCOn2i+PSsQYtSwoTjgOhtXrlh//3uHqg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WM+Q488l3bqT+/bRzPKrGD9CF6V+LZ+NhRIa7ZI2bbKfAtjO/dFDsk2pV+yEfuxGgn
         NyDzCo+2uFZ/WfLBTRXZwjFjMmVgb5mklXkQqCQHO5FjPPH9V6BXw6kUwjj564/guDxC
         X7atcAgKKlGxXXCJEpNKVccCivU/gLZlugUd4=
Received: by 10.114.164.7 with SMTP id m7mr336474wae.125.1267762028443; Thu, 
	04 Mar 2010 20:07:08 -0800 (PST)
In-Reply-To: <32541b131003041919u6a477b46s447a6aeb18f3b393@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141560>

On 5 March 2010 03:19, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Thu, Mar 4, 2010 at 10:00 PM, John Tapsell <johnflux@gmail.com> wr=
ote:
>> On 5 March 2010 02:03, Avery Pennarun <apenwarr@gmail.com> wrote:
>>> modified code would be a little more interesting. =C2=A0git makes t=
his sort
>>> of thing pretty much impossible to do without it being *noticeable*=
 at
>>> least. =C2=A0Traceable, not so much, because you can create a commi=
t with
>>> whatever committer/author names you want and then push them in.
>>
>> Which is why you simply record the username of whoever pushed them i=
n.
>> =C2=A0This is what gitorious.org does etc.
>
> Not bad, but it's still very hard to trace properly. =C2=A0Imagine I =
pull
> from a peer, then push my combined branch into the central repo.
> It'll say I'm pushing in patches from me *and* my friend. =C2=A0Did I=
 forge
> them or are they real?

While true, it's still traceable back to you.  You did the push, so
you are responsible for that code.  It wouldn't be any different to
just pushing a bad commit yourself.
