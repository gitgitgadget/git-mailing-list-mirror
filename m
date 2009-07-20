From: Geoffrey Irving <irving@naml.us>
Subject: Re: bug with .git file and aliases
Date: Mon, 20 Jul 2009 11:25:33 -0400
Message-ID: <7f9d599f0907200825j69ee3c9cj4aef26796c3917d6@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> 
	<adf1fd3d0907200704sb097a99h1ab8f118be5854f9@mail.gmail.com> 
	<7f9d599f0907200727v5b258a73n3fa664f134c0eead@mail.gmail.com> 
	<adf1fd3d0907200818l429e701ds6a42ec49f02d5ba9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSukc-0002Lz-Nl
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbZGTPZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 11:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbZGTPZy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:25:54 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:55784 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZGTPZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 11:25:53 -0400
Received: by vwj40 with SMTP id 40so191486vwj.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=wRltmozAXl1r9+ow2x0GAW4/qZtj4z7+9h+yGTsYGFg=;
        b=FhKGXW/YZeblWW3TEcp5di0QGK4ty7Z508uNTpZMgyx9L+L421JdRiRi/5CiVl9E3W
         0Z37DXiIvpJAe7PEaI4u2umjyHlw0DmKJXJMorUYP3/thSK47knk94q/NrgCo0fdSG9p
         VZg5P1cV0ZTZ2gK/kAYtoNDOuMau8GzIar0aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=X/J+b7Meqz7EWBgi2DRFdrV+yYXtc5hsez3DttXapcb6cn8eWoC/TC/eJsUY9d3kTi
         NKzKxUJQR0hEnWc4Jj5255DC/DhlAYzvtAi/5X8SjE3Z4gVqpz7+G9HGwpt3jwhV2OPZ
         w7J/dL/2HGiX2Nef+eu6NZJ9tbWYgJAvPBCrk=
Received: by 10.220.76.73 with SMTP id b9mr4935000vck.85.1248103553082; Mon, 
	20 Jul 2009 08:25:53 -0700 (PDT)
In-Reply-To: <adf1fd3d0907200818l429e701ds6a42ec49f02d5ba9@mail.gmail.com>
X-Google-Sender-Auth: 70eb7cfb42cb2de3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123613>

On Mon, Jul 20, 2009 at 11:18 AM, Santi B=E9jar<santi@agolina.net> wrot=
e:
> 2009/7/20 Geoffrey Irving <irving@naml.us>:
>> On Mon, Jul 20, 2009 at 10:04 AM, Santi B=E9jar<santi@agolina.net> w=
rote:
>>> I suspect that the $GIR_DIR and .git file works equally in this
>>> aspect, so you should specify where is the workdir in .git/config w=
ith
>>> respect the repository:
>>>
>>> git config core.workdir `pwd`
>>
>> Nope, that has no effect.
>
> Here it has the desired effect. From where did you run the above
> command? What is the output of:
>
> git config core.workdir

top:a% git config core.workdir
/Users/irving/tmp/tmp/repo
top:a% git st
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	deleted:    a/b
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	b

It doesn't matter, though, since setting workdir should not be necessar=
y.

Geoffrey
