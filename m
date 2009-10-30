From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 20:13:11 -0200
Message-ID: <55bacdd30910301513u6ba6a575w2c65358ff368aeab@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<7vljisk1m7.fsf@alter.siamese.dyndns.org> <55bacdd30910301505xe712b74m837dc862a6ee953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Oct 30 23:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zj6-0001ob-Gu
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbZJ3WNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbZJ3WNd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:13:33 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48767 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbZJ3WNc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 18:13:32 -0400
Received: by ywh40 with SMTP id 40so3115417ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:cc:content-type
         :content-transfer-encoding;
        bh=fJwvvONXGBg9uQtDB77qGN3v+TJCcnKyZUd1c90vg8E=;
        b=OFdZTH4qx/ovwpMCYvp1VEuzNALjwqfedI5bhsvtQTAbeZm9pMUEkaPLWEA5VBtzBK
         zeAYWbgviWDG35JS71QwyCyAwI23ygyGMZ4M1ZYabS01ksnpA1hARRvv5K+amXZVk6Yk
         gitSHmRjxb28zkp5NokHju7aJYalniVFvvK1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type:content-transfer-encoding;
        b=KXNwD2Ol5mqwF2r9W7M4dgzxKL12Q9+iZ4KgPtwDKSb88yW0LT5i6AovuW+f4q6tun
         S0fRB+dt0aDSl1rXRMx3yG0ukyEPTgHSfr4j0VnvZUJRuz8QRmB5FynsCVZ7iJm4JVyy
         qYGb5huORbk0/GA9QIG4vyHlsQW2PWCWDqJaU=
Received: by 10.150.9.4 with SMTP id 4mr3888254ybi.343.1256940811088; Fri, 30 
	Oct 2009 15:13:31 -0700 (PDT)
In-Reply-To: <55bacdd30910301505xe712b74m837dc862a6ee953@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131765>

2009/10/30 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
> A patch always changes something so the title "Changed ... behavior" =
does
> not carry enough information

Sorry but I thought It was enough. =C2=A0First submitted patch.

>(besides, you write logs as if you are making
> an order to the codebase to "do this!").

Not a chance! =C2=A0Just trying to help. =C2=A0A way for paying back al=
l the
benefits I enjoy by your software.

>> The code herein changes commit timestamp recording from a source in =
a
>> more intuitive way.
>>
>> Description:
>
> Remove the above. =C2=A0Instead, start with a description of what the=
 current
> code does, e.g.
>
> =C2=A0 =C2=A0Subject: commit -c/-C/--amend: allow 'current' timestamp=
 to be used
>
> =C2=A0 =C2=A0When these options are used, the timestamp recorded in t=
he newly
> =C2=A0 =C2=A0created commit is always taken from the original commit.

Demand accepted.

>
> Then the rest of your text flows much more nicely...
>
>> When we use one of the options above we are normally trying to do ma=
inly
>> two things: one is using the source as a template and second is to
>> recreate a commit with corrections.
>>
>> In the first case timestamp should by default be taken by the time w=
e
>> are doing the commit, not by the source. =C2=A0On the second case th=
e actual
>> behavior is acceptable.
>
> ... and the reader does not have to wonder what "the actual behavior"=
 is;
> instead you can say "the current behavior" here.
>
>> ...
>> Those options are also useful for --amend option which is by default
>> behaving the same.
>
> Also the reader does not have to wonder what "the same" means here.

Done again.

> I agree that the issue the patch addresses is worth improving, and I =
think
> it is sensible to default to reuse the timestamp for -C and not to re=
use
> for --amend. =C2=A0I am not sure about -c myself, but it probably sho=
uldn't
> reuse the timestamp by default.
>
> I however think (old|new)-timestamp is suboptimal.
>
> We already have --reuse-message, so why not trigger this with a singl=
e
> option --(no-)reuse-timestamp?
>
Don't you think it would be a little big? =C2=A0I had compared the opti=
on
name so it would be more or less of reuse-message.
