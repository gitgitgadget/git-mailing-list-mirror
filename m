From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [bug] git svn clone failing with invalid diff stream
Date: Wed, 21 Apr 2010 02:42:25 +1000
Message-ID: <j2x971f65791004200942yf86f51b2mc828dbd19c169b28@mail.gmail.com>
References: <m2q971f65791004192348zab4adf13p93a6a4c1d60f9c16@mail.gmail.com> 
	<4BCDD25F.4030406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 18:42:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4GXJ-0005Fh-Nf
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 18:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0DTQmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 12:42:47 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:64882 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0DTQmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 12:42:46 -0400
Received: by iwn35 with SMTP id 35so3184410iwn.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:received:message-id
         :subject:to:cc:content-type;
        bh=Sw+I/5n4z61hVH0YGl3dM2/QXvuWCWPtK3aBnVP2lHE=;
        b=mhCnR0+TLBaid73YaEngENPjK6nASzcx8LYf05h4hbc1jaB3+4Xz29K/7u4h5185+c
         x4NPs3WTPbuzCHnhY2OUdDrIvnWwuqpJ5oTeiKIUQgYB7W5FYXsod7RqHPwAOjAkCs0N
         mGUcwTqebp35kuFRzG4VrMk6rV6BlyGKOqovQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=mXX2P6DgE8m5oyecMVdUwDkD3YcU+f6LBKhOIX/Pgtc6KoCJXjT5n53Wd+rdtAwsMm
         t2q/4NDnT1JefMEEhuPsiwWpcMnlnci8gpXohwU/Jsat0HdP457JmpbFZE7HQ+IqJIL9
         BlKRf+JzcJRYSicWhIEf4Cn6ealK2CIScCcck=
Received: by 10.231.190.193 with HTTP; Tue, 20 Apr 2010 09:42:25 -0700 (PDT)
In-Reply-To: <4BCDD25F.4030406@drmicha.warpmail.net>
X-Google-Sender-Auth: 4946a9c49c321448
Received: by 10.231.161.143 with SMTP id r15mr2461150ibx.62.1271781765339; 
	Tue, 20 Apr 2010 09:42:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145388>

On Wed, Apr 21, 2010 at 2:12 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Anand Kumria venit, vidit, dixit 20.04.2010 08:48:
>> Hi,
>>
>> Using both git 1.7.0.4 and 1.5.6.5 I am unable to clone the Subversion
>> respository for Serendipity.
>>
>> URL: svn://svn.berlios.de/serendipity
>>
>> It fails consistently on r1341 with:
>>
>> (1.5.6.5): Svndiff data contains invalid instruction: Invalid diff
>> stream: [tgt] insn 335 starts beyond the target view position at
>> /usr/bin/git-svn line 3856
>>
>> and
>>
>> (1.7.0.4): Svndiff data contains invalid instruction: Invalid diff
>> stream: [tgt] insn 335 starts beyond the target view position at
>> /usr/lib/git-core/git-svn line 5047
>>
>> On, seemingly UTF-8 encoded data. Any ideas / pointers would be appreciated.
>
> That message actually comes from the underlying svn diff itself. To me
> it looks like a problem with the underlying fsfs on the server:
>
> http://www.szakmeister.net/fsfsverify/
>
> hg convert runs into the same problem, btw.

Thanks - I was afraid I was doing something incorrect or it might have
been some other issue at my end.

I've reached out to the Berlios and Subversion guys, since the page on
fsfsverify seems to indicate it is a hard to reproduce problem needing
a test case; and this appears to be one.

Cheers,
Anand
