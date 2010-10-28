From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/34] Add t1510 and basic rules that run repo setup
Date: Thu, 28 Oct 2010 07:16:06 +0700
Message-ID: <AANLkTinZnsgQnJcZjrvx8NrWEbY+a49+ndSae7VXAc2c@mail.gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
 <1288190977-30875-3-git-send-email-pclouds@gmail.com> <AANLkTiknZEp8EoHr6auqUQQsMj+MvLwhUYxzUD9N-6L4@mail.gmail.com>
 <20101027163047.GA11069@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:16:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGAX-0007JZ-SB
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab0J1AQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 20:16:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34351 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853Ab0J1AQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 20:16:27 -0400
Received: by wwe15 with SMTP id 15so1423964wwe.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=t4v4iKm0j64NvKh47lwLqIF/zzVa1GVtU9GejadJo64=;
        b=Auq86Encp7B5khfF/SY7wTd4dfN3zdxfFTHl/FFqWpnwaSDmcB7cKDiXgzl99tJ8HO
         CVktvGA/t3BoJo2ZW+mw3EyDru4plnb6jGTke5WaEQG/5dkAy1ZmhA+bcW3CtfjEtDXi
         LBU6QhUhoPvSyT7jntct0NNjjVcLjwsjrfdS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BVBysZXw28hn0Q08QZJ+ZkyvlzLeheNakogL+rGGn0s3t8LhylDqhzRi+ZAO2XRlmo
         PSNJXd4YbeEu9ERWPDANkyE90yuKpseY4iqwezGHHSdz9r5jFJEINGkX1j+zzRLIaxcM
         8ER22CxH3IhJ6TucIVN6uw8JDva9MM7EKBp4A=
Received: by 10.216.159.213 with SMTP id s63mr1109395wek.80.1288224986338;
 Wed, 27 Oct 2010 17:16:26 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Wed, 27 Oct 2010 17:16:06 -0700 (PDT)
In-Reply-To: <20101027163047.GA11069@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160139>

On Wed, Oct 27, 2010 at 11:30 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguyen Thai Ngoc Duy wrote:
>> 2010/10/27 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>:
>
>>> +# 2. .git file is relative to git_dir. .git file is basically syml=
ink
>>> +# =C2=A0 =C2=A0in disguise.
>>
>> This is not completely followed in my tests. If .git is a true
>> symlink, its link is relative to .git itself. When .git is a file, i=
t
>> would be more difficult to calculate path relative to .git (you can'=
t
>> chdir to a file).
>
> I'm not sure I understand:
>
> =C2=A0git init repo
> =C2=A0cd repo
> =C2=A0mv .git .git.real
> =C2=A0ln -s .git.real .git
>
> The path ".git.real" is relative to "repo/", not "repo/.git/", no?

Ah, ok. I was confused after writing all those tests.
--=20
Duy
