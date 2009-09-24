From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: 'git am' doubt
Date: Thu, 24 Sep 2009 11:09:21 -0300
Message-ID: <a4c8a6d00909240709r27aff2abwbf5eaa31fe95855b@mail.gmail.com>
References: <a4c8a6d00909231520s53be6654ibf74d4430e7e82f@mail.gmail.com>
	 <20090923235433.GB80337@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 16:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqp0i-0000Fc-Sw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 16:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZIXOJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 10:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZIXOJT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 10:09:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:29671 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZIXOJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 10:09:18 -0400
Received: by fg-out-1718.google.com with SMTP id 22so583457fge.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lxwm88RzUbCkGq8P5yyL+j7qS8rTKDyIgSHQjaSH3Ng=;
        b=EyoNPpJCsjq7i1nGny94aSolJkcELkgsv0kKahzdy2qhtGQSHw1qDffa4thMst2Ic8
         FhtXglAnElitZdLcxd4fRtWLS7kxvdSJQgOcE3iT7KualIxhvEx45l2HKT98RUT5Z35g
         8kz/b86nOLMeFUXLh19smcWR+12lommdNX2Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WqmNPSR3T0sG5hRQOf3SVxrPWlKPXWHaVHDy1dZ3aWapdbArY66dUWDV7+aY32Q+DK
         PKUB28zTOqI/DWpcpAAiLR8yUIjlRPqcr+i78IePL8y9NXsgp5XVq6lwdaVTkHhz7oUO
         Qd+HDkehIjolsG4HTUmAxqnZudLLijYPxYYXc=
Received: by 10.86.17.27 with SMTP id 27mr38830fgq.31.1253801361669; Thu, 24 
	Sep 2009 07:09:21 -0700 (PDT)
In-Reply-To: <20090923235433.GB80337@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129041>

On Wed, Sep 23, 2009 at 8:54 PM, David Aguilar <davvid@gmail.com> wrote=
:
> On Wed, Sep 23, 2009 at 07:20:53PM -0300, Thiago Farina wrote:
>> Hi,
>>
>> I'm trying to apply a patch from the mailing list using 'git am'.
>>
>> What I'm doing is:
>>
>> - In gmail:
>> =C2=A0- Save original, then I copied the content to a text editor.
>> - In text editor:
>> =C2=A0- Remove the first empty line.
>> =C2=A0- Save the file in the same directory where I have the git sou=
rce.
>> - In git directory:
>> =C2=A0- $ git am -s ./filename.mbox
>>
>> Of course I'm doing something wrong here, but I don't know what.
>> The error is:
>> cat: /home/tfarina/git/.git/rebase-apply/next: No such file or direc=
tory
>> previous rebase directory /home/tfarina/git/.git/rebase-apply still
>> exists but mbox given.
>
>
> Perhaps you tried this previously and 'git am' failed?
> In which case, run 'git am --abort'.
I didn't try before.
>
>
> Now.. I've _never_ had luck saving patches out of gmail.
> But, I've had good luck with its imap interface.
> I use mutt, save emails to an mbox file, and use 'git am'
> on them. =C2=A0This has worked great for me.
Yeah, I tried with Evolution, and it worked for me, so the problem was
with Gmail.
>
> For sending emails to the list, I use msmtp and a
> ~/.gitconfig setting:
>
>
> [sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0smtpserver =3D /usr/bin/msmtp
>
>
> Then it's simply 'git send-email <patch-file>'.
>
>
> Here's a random page explaining how to use mutt with gmail.
> http://shreevatsa.wordpress.com/2007/07/31/using-gmail-with-mutt-the-=
minimal-way/
>
> I can send you my .muttrc if that helps.
I'm using send-email to send my patches too. If you could, send me
your .muttrc, I will appreciate, may be I can try to use it instead of
Evolution.

Thanks for your help. ;)
