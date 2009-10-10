From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Sun, 11 Oct 2009 06:54:07 +0800
Message-ID: <be6fef0d0910101554p53d5532cp17768d2c95e9dbf@mail.gmail.com>
References: <4ACF7296.3010809@gmail.com>
	 <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>
	 <4AD09F5E.9090304@gmail.com>
	 <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com>
	 <4AD0AE84.1070500@gmail.com>
	 <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com>
	 <4AD0BBCB.8000306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com
To: eduard stefan <eduard.stefan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 00:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwktA-0008DQ-MR
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 00:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbZJJWyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbZJJWyp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 18:54:45 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:40087 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbZJJWyp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 18:54:45 -0400
Received: by iwn10 with SMTP id 10so1735307iwn.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bQTP+GSH9/EVqJAxSTgq9TgfCZpbQuzTvTRYVPORBx8=;
        b=Wnv5Vs97WWFz4/UmHp39lvE6z7s0vPtG6XmnTjX307dlP+8VoqOkt+k1jx0uRCJcyx
         IT68JsLKQsAq2cR6gm1bS77bzMXYvOhz/eFKT/eJX/r1GPybaQMbTjqMzlYf2zMFY4eY
         RxCnK0eW+LdXQ/XTvB1CMIQJ1p6b1ntUX54j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VT1vMA7UkPeeUYA7BCGXgLJHVOdlqIqT911D+u1+ZyNPvD+2ezE413VolY+6HUTgK7
         jcfKdB+2/2tmrFAUrd5u6m4QXSt11TkW6XpLbkyrp7QABTHaekeck68PKdFkoqfeLYMn
         3FMMgEJJvIzLeIRWD5vHr4CqQ7v4pwcMXOoXU=
Received: by 10.231.6.164 with SMTP id 36mr3773073ibz.39.1255215247782; Sat, 
	10 Oct 2009 15:54:07 -0700 (PDT)
In-Reply-To: <4AD0BBCB.8000306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129898>

Hi,

On Sun, Oct 11, 2009 at 12:52 AM, eduard stefan <eduard.stefan@gmail.co=
m> wrote:
> Tay Ray Chuan wrote:
>> I suspect, as you do, it's got to do with remote-curl.
>>
>> Could you try this command?
>>
>> =A0 echo list | git remote-curl http://github.com/loudej/spark.git
>
> Inside an empty repository it crashes the same way,
> without any additional information.
> "git remote-curl" crashes in the same way,
> but "git remote-curl --help" tries to launch the browser.

just to check, running

  echo list | git remote-curl http://github.com/loudej/spark.git

and

  git clone http://github.com/loudej/spark.git

both gives the same error message:

  An unhandled win32 exception occurred in git-remote-curl.exe [5820].
  Just-In-Time debugging this exception failed with the following
  error: No installed debugger has Just-In-Time debugging enabled. In
  Visual Studio, Just-In-Time debugging can be enabled from
  Tools/Options/Debugging/Just-In-Time.

  Check the documentation index for 'Just-in-time debugging, errors'
  for more information.

in a dialog?

> Is there any way to obtain more information from this crash?
> Some debug mode?

I'm assuming you're using the Microsoft Visual Studio development
tools to compile git from the source. I'm cc'ing this to the msysgit
mailing list, perhaps someone familiar with them can advise you
further.

--=20
Cheers,
Ray Chuan
