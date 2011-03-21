From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Mon, 21 Mar 2011 10:36:06 +0100
Message-ID: <AANLkTikNprk74FnSfw=n3ePvwOZT_WaeSpnKQCqD9mpa@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
 <7vsjujq8kf.fsf@alter.siamese.dyndns.org> <AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
 <AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:37:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bY5-00008V-7J
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab1CUJhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 05:37:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59999 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab1CUJhJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 05:37:09 -0400
Received: by fxm17 with SMTP id 17so5288908fxm.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HI8yURCs8vjTVkSrniPzg+cLWrgJbG6qYBzdmtC5yrU=;
        b=MVHXgIF4/VLa4NNESJnloltHYMUQgEhDM3J1Zk7d21bmhmicjQo0ORuCyToCdHNUOY
         3OqihG/xp/cc8qpjOXHp88HSiJ2WVCwvWR5jxgE1LcLtUOctj+2S5vw2QWzCmzj5f9VM
         wC6FoaRj5K+/KljNloetzEyiKxUaLr2E3eN/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=DAqugUxsYSGzH3WTGbezW93y/Ydxy/o8QrKzuYVnBVs8mad4zhIjOxJKb+5ZZNiQk0
         3BowBJvvaZoc8RZUQYhf/LsfpmlcvdpskPlDLIAcQlY53CiqyCnihbYqwAVSPe1qBa8b
         CBsJKKpYiOew7JYFBSrAeUYCXbQwkA8uIdfLY=
Received: by 10.223.20.144 with SMTP id f16mr4636122fab.68.1300700186704; Mon,
 21 Mar 2011 02:36:26 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Mon, 21 Mar 2011 02:36:06 -0700 (PDT)
In-Reply-To: <AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169566>

On Sun, Mar 20, 2011 at 1:35 AM, ryenus =E2=97=87 <ryenus@gmail.com> wr=
ote:
> oops, corrected the script with the test strings in upper cases
>
> #!/bin/sh
> echo $(uname -s)
> case $(uname -s) in
> *MINGW*|*CYGWIN*)
> =C2=A0echo "detected MinGW/Cygwin"
> =C2=A0;;
> *MINGW*)
> =C2=A0echo "detected MinGW"
> =C2=A0;;
> *CYGWIN*)
> =C2=A0echo "detected Cygwin"
> =C2=A0;;
> esac
>

Output:
MINGW32_NT-6.1
detected MinGW/Cygwin
