From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t2203: fix wrong commit command
Date: Wed, 11 Jan 2012 11:43:04 +0700
Message-ID: <CACsJy8CjWBRtj3x3guyu-iJeTYxcRriXKbE=Be-rG=Rmesgt=g@mail.gmail.com>
References: <1326252098-2891-1-git-send-email-pclouds@gmail.com> <CALkWK0kDBFvssyX2ZPJ9WNzfNXD=wEJoXTRVpFWm1TDKJrvNzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkq2W-0005Rp-UC
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab2AKEnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:43:37 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46885 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab2AKEng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:43:36 -0500
Received: by bkvi17 with SMTP id i17so220495bkv.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hw9v501pKF/76fsMA8GdCICloH9BTIoErQyL/Qgf220=;
        b=UF69at3OOoiUxD2NwraUZKS07qZmJNTMieA6s+hQLVuGHL1oh6uixYp6CQ3N0KGGeZ
         NSyBTfw0DGh2dAEj1B2zLgYYxlzH9IIAKoDUV5ppFfGJdxNJY3f+fMRTXe88JIkrQGWb
         ivG/JYcuwYM6JQ7QSFepOPhpFqoNmXEIcUT+w=
Received: by 10.205.132.14 with SMTP id hs14mr9720289bkc.130.1326257015126;
 Tue, 10 Jan 2012 20:43:35 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 20:43:04 -0800 (PST)
In-Reply-To: <CALkWK0kDBFvssyX2ZPJ9WNzfNXD=wEJoXTRVpFWm1TDKJrvNzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188327>

2012/1/11 Ramkumar Ramachandra <artagnon@gmail.com>:
> Hi Duy,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Add commit message to avoid commit's aborting due to the lack of
>> commit message, not because there are INTENT_TO_ADD entries in index=
=2E
>
> Is there any way to differentiate between the two kinds of errors, so
> that we can avoid this in the future? =C2=A0Can we grep the error mes=
sage
> for something, or inspect the exit status?

commit exits with 1 in both cases, so no.
--=20
Duy
