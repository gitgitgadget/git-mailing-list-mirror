From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 08:11:01 +1100
Message-ID: <CACsJy8Du2f=SZUnV_y6A_x3Uc1o__5EYbhveQ5fu5ivXZ-0adg@mail.gmail.com>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com> <20111002223805.0bd6678b@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 23:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RATJx-0001ea-LU
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab1JBVLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 17:11:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50072 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1JBVLc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 17:11:32 -0400
Received: by bkbzt4 with SMTP id zt4so4475200bkb.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=avUUa0EPfAMezhAoQeZ0mEpIX7crBw6uONzHGt5Hdbg=;
        b=Xom7vsudKW962339qzD0h3U1s729Mtlk1KAY6QQ59HhhGWzvFg8ELDCm/GaDs5mpS3
         1x4rGkuYYA02abtYjsTTelCVTLhPQkfL0Qu92Bfa/uBmX9MIPLUhnbeuggXvzmHI8Tq5
         bPy+s+x6UT3Uci6KcPiQ2DYl8jecoWhMZrllE=
Received: by 10.204.141.134 with SMTP id m6mr4513371bku.199.1317589891102;
 Sun, 02 Oct 2011 14:11:31 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sun, 2 Oct 2011 14:11:01 -0700 (PDT)
In-Reply-To: <20111002223805.0bd6678b@zappedws>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182609>

2011/10/3 Alexey Shumkin <alex.crezoff@gmail.com>:
>> This protocol has never been designed for pushing. Attempts to push
>> over git:// usually result in
>>
>> =C2=A0 fatal: The remote end hung up unexpectedly
>
> hmmm.. So, how does my project work? ))
>
> $ git remote -v
> origin git://drcis/d/Data/GitRepos/projects/billing+beeline.git (fetc=
h)
> origin git://drcis/d/Data/GitRepos/projects/billing+beeline.git (push=
)
>
>
> $git daemon --help
> ...
> SERVICES
> ..
> =C2=A0 =C2=A0 =C2=A0 receive-pack
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This serves git send-pack clients,=
 allowing anonymous push.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 It is disabled by default
> ...
>
> It does not correspond your words...
>
> What do I miss?

=2E. what I said in a later mail, my patch is wrong :)
--=20
Duy
