From: John Tapsell <johnflux@gmail.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Thu, 5 Mar 2009 11:37:45 +0000
Message-ID: <43d8ce650903050337n48924fc3l89ef991d578f5849@mail.gmail.com>
References: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
	 <49AF9601.9060709@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBv2-0004Ey-Jj
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbZCELht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 06:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZCELhs
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:37:48 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:42803 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZCELhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 06:37:47 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4495463wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 03:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=xsfbe/XkQpdeQF9SPuJk/BS+H/gI5I8qPu8XOVn7J2M=;
        b=uhXtGntqT1Th3OIoNK6idkjcHQFshEW3eFoXiTlHDS3x4w08dF9CoKgnOiIlPq6zUQ
         L5Nc5bxZzOYjD72hD8daC45wn04tKfMKAeSgfTiqqCd6yeYLUxac38tgrPCx6Frnytq1
         sbA8EE46+PZA5OWOz5VJNg/6235eBaAT7edAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=adz3xpg9L96trNSpXxbb1Qp09LspZOHS0suH5hB3AevjNLf1+gTEoo9nqHbRzoUJAK
         xhQQuNZg2y0jMO8xjCm7c/xwyrI/g6fvQc6RCyWdq80bxKhHw9mgcI+xNif2YBqnQqSY
         PcnuW0yi+FFpQ9nPBmYN7wXMUQb/UnM5xqPWk=
Received: by 10.142.13.13 with SMTP id 13mr493770wfm.43.1236253065710; Thu, 05 
	Mar 2009 03:37:45 -0800 (PST)
In-Reply-To: <49AF9601.9060709@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112301>

2009/3/5 Andreas Ericsson <ae@op5.se>:
> Joi Ellis wrote:
>>
>> On Fri, 6 Feb 2009, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> Now, in this case, it was only one tweak and other responders have
>>>> already pointed him in the right direction. So just making that tw=
eak
>>>> manually is probably the sane thing to do in this situation.
>>>>
>>>> But I wanted to point out that autoconf is not totally without val=
ue
>>>> here.
>>>
>>> I am not saying something that strong, either. =C2=A0If autoconf ge=
nerated
>>> configure works _for you_ without hassle, great. =C2=A0Keep using i=
t.
>>>
>>> The original message that started this thread was what to do when i=
t does
>>> NOT work for you, and my point was in general it is much nicer to p=
oint
>>> at
>>> the knob to tweak from the make invocation command line (or in
>>> config.mak)
>>> than having you spend time on upgrade autoconf, generate configure =
and
>>> run
>>> it.
>>
>> Actually, guys, if you go back and re-read my original message, I wa=
s
>> pointing out that if you use a 'git clone' to get a build tree, THER=
E IS
>> NO CONFIGURE SCRIPT in the tree.
>>
>> The problem is not that the configure script does not work. =C2=A0I =
pointed
>> out in the first paragraph that the configure script in the TARBALL
>> works just fine. =C2=A0What I pointed out is that the build tree DOE=
S NOT
>> PROVIDE THE CONFIGURE SCRIPT. =C2=A0All I asked you to do is to cons=
ider
>> adding the configure script to the repository so that it gets pushed=
 out
>> in a clone.
>>
>>> Fanboys may say that autoconf generated configure is the greatest t=
hing
>>> since sliced bread. =C2=A0But let's face it. =C2=A0Honestly, the tr=
ack record of
>>> those people in keeping autoconf part in this project up-to-date ha=
s not
>>> been all that great. =C2=A0There are things that the generated conf=
igure file
>>> does not detect nor configure correctly (we had --with-expat patch,=
 and
>>> we
>>> also saw "the trailing slash in template_dir definition in config.m=
ak.in"
>>> discussed fairly recently). =C2=A0You are much better off tweaking =
known
>>> peculiarity of your platform in config.mak, when configure does not=
 work
>>> out of box for you.
>>
>> I've been building and installing multi-platform *nix software on
>> various flavors for two decades now. =C2=A0"./configure && make && m=
ake
>> install" has been the standard build process even before GNU. =C2=A0=
The whole
>> point of
>> autoconf/configure/make tools is to eliminate the need to manually t=
weak
>> makefiles so that software is easily portable between platforms.
>
> ./configure is a generated script. Including it in the repository is =
not
> something many projects do, since one of the things developers will b=
e
> working on is to change how that file is generated. Including it in t=
he
> release tar-balls is something every project (that uses autoconf) doe=
s,
> since those are aimed at end-users.

Reason that it should be included:

* configure scripts usually are included.  git was the first source
code in a long time that I've seen without one
* we have lots other files in git.git that are autogenerated (the
documentation files, for example)
* people are used to being able to do "./configure; make; make install"
* It doesn't hurt anyone to do it.

John
