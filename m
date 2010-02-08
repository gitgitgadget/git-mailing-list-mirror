From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Unix root dir as a work tree
Date: Mon, 8 Feb 2010 09:03:03 +0700
Message-ID: <fcaeb9bf1002071803o343bed87u2e1df2ef77db607f@mail.gmail.com>
References: <4B6F6971.6000106@jonny.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
X-From: git-owner@vger.kernel.org Mon Feb 08 03:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeIyI-0006LB-1o
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab0BHCDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 21:03:25 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:40966 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab0BHCDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 21:03:24 -0500
Received: by pzk2 with SMTP id 2so2103748pzk.21
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6YTY7LE/MV8wohppX5AtwiiETaSZIkfFm7nVNrHYqWM=;
        b=xRwmjEjeGB4dlAcT2M6aTmJ4nE8lnZIE+SKeOrkkQ3uZgHsHIVYYfHmss9u9eR6Oyj
         prQC55cCtUBsnaBif4gcI96FvUqpOi6cekVscs8tnC4QwYL+/t1oaBwJhZZwV4YtffH0
         tYddpicizJYRPEdrhQBbAeHGJ++6/mOIaQPQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lkEc+a2EEHzSWeL1ttREK+PRMyAjQPEiVdso2DNTR20BTFAUfNUvBS84/bAbN18B1Y
         3lazj9ZPsIvpsyl512kZB/53Ea7nSSf4kL7iN9bRvFoE/KCuhnrCLaHZXPXQ10Hd2dhu
         aSkJF0I1IWVR+6aCbOOlHcDLqDKp+f6ik42Xk=
Received: by 10.114.252.39 with SMTP id z39mr3937524wah.93.1265594603151; Sun, 
	07 Feb 2010 18:03:23 -0800 (PST)
In-Reply-To: <4B6F6971.6000106@jonny.eng.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139271>

2010/2/8 Jo=C3=A3o Carlos Mendes Lu=C3=ADs <jonny@jonny.eng.br>:
> Hi,
>
> =C2=A0 Sorry if this is a FAQ, but I could not find any reference.
>
> =C2=A0 I have been using CVS as a version control system for unix con=
figuration
> files for a long time. =C2=A0I know it has some limitations, and I kn=
ow git also
> has its. =C2=A0But I expect to work around all of them using etckeepe=
r.
>
> =C2=A0 The problem is that etckeeper was created with /etc only in mi=
nd, and I
> want to keep track of important files everywhere, not only below /etc=
 (think
> /opt, /usr/local). =C2=A0The obvious solution appear to create the re=
pository at
> the system root, and not at /etc, but it did not work. =C2=A0I think,=
 because of
> a bug.
>
> =C2=A0Now, I have a patch that appears to work, but since I am a begi=
nner to git,
> I don't know if this is the best way to implement it, if it has any s=
ide
> effects, or even if it works for other operating systems (probably th=
ey
> don't even have the bug). =C2=A0Would any git wizard care to look at =
it, check if
> it is ok, and maybe commit in HEAD or give me any advice against my p=
atch?

How did you set GIT_DIR and GIT_WORK_TREE? What command failed?
--=20
Duy
