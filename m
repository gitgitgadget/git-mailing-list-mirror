From: Sultan Shakir <sshakirflhosp@gmail.com>
Subject: Re: Can Git work for us if we are remotely hosted?
Date: Thu, 12 Aug 2010 14:22:11 -0400
Message-ID: <AANLkTi=wa_xdheoKDPr=rfugttpu56s-sd3Q6qFgBALL@mail.gmail.com>
References: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
	<AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com>
	<AANLkTimxYgAwWWoJCxsQ_Rr-eGfWJWoL4Qscw3FBYk9_@mail.gmail.com>
	<AANLkTin_qwk9FxkhVkvfQyc0AFXOKfKX-b+BzgXas_CW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 20:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjcQ4-0002x9-TH
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 20:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760731Ab0HLSWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 14:22:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65387 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0HLSWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 14:22:17 -0400
Received: by vws3 with SMTP id 3so838645vws.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BnCdPbb3s8VJoLcFWpBqiAUIR6n1Pwa3a3yh3I8gKNI=;
        b=F6xDWdAXqwW/Hp6pY4H/ELvJMT6+7vEcoNTziS0N5n9BOieQwRgwVTuxLrWvVpYbR2
         0nEJ/1+2qWateRT59DQE6c6EvZzMg53a7zIyCnLHdZ53J6YmY36JL/MRY/vmzmtZVYxA
         uonpaXaNGBcM84U5O0d5FmfHE7eWmUKgH+mJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ubC9Ica2U3uLm6GSRhjWog2id1v0NRLcDlzhFx3+pJggtFpNUFTz0kIT2UMfILMbTZ
         qyg0KrpQzU7qHmaypFiv+FFWnfxnbx6Q7BmOfeEaZgQUL5PHJ2zEYgOROK85S+rmDROw
         HkTGOPVowhVQNWdVZLaH8fLRS9Rn0laF0Vx8E=
Received: by 10.229.52.38 with SMTP id f38mr375700qcg.224.1281637331715; Thu,
 12 Aug 2010 11:22:11 -0700 (PDT)
Received: by 10.229.69.76 with HTTP; Thu, 12 Aug 2010 11:22:11 -0700 (PDT)
In-Reply-To: <AANLkTin_qwk9FxkhVkvfQyc0AFXOKfKX-b+BzgXas_CW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153398>

On Thu, Aug 12, 2010 at 2:08 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Aug 12, 2010 at 1:59 PM, Sultan Shakir <sshakirflhosp@gmail.c=
om> wrote:
>> On Wed, Aug 11, 2010 at 7:06 PM, Avery Pennarun <apenwarr@gmail.com>=
 wrote:
>>> On Wed, Aug 11, 2010 at 6:51 PM, Sultan Shakir <sshakirflhosp@gmail=
=2Ecom> wrote:
>>>> I've been trying to wrap my brain around how I can get Git to work=
 at
>>>> my organization. =A0The issue is that nearly all of our programs a=
nd
>>>> their IDE are remotely hosted. =A0This means that to even work on =
a file
>>>> we have to connect to the network in order to use the application =
that
>>>> we code in. =A0We do have access to the backend where the files ar=
e
>>>> stored though. =A0How can we use Git in this situation without set=
ting
>>>> up another server?
>>>
>>> If you want, you could just push/pull to a git repo in a file share=
 on
>>> one of your existing fileservers.
>>
>> Please excuse my ignorance. =A0What do you mean by a "file share" an=
d
>> "existing fileservers"?
>
> You said you have "access to the backend where the files are stored."
> Surely that's on a fileserver, like a Windows file sharing service or
> a samba server or an NFS server, right? =A0Any of those are capable o=
f
> holding a git repository.
>
> git is much faster if you store files on your local machine as much a=
s
> possible. =A0But you can push/pull from a shared repository on a
> samba/NFS/whatever server and that generally won't be a performance
> problem.
>
> Have fun,
>
> Avery
>

Thanks Avery.  Wouldn't this defeat the purpose of using Git since we
can't really run nor can we compile files on our local machines?
