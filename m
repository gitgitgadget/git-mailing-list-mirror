From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t2203: fix wrong commit command
Date: Wed, 11 Jan 2012 11:43:54 +0700
Message-ID: <CACsJy8Dkcj4Vbow29SBW52JKu7bkEWzk_S=rTrG+fdxiD0w7xw@mail.gmail.com>
References: <1326252098-2891-1-git-send-email-pclouds@gmail.com>
 <CALkWK0kDBFvssyX2ZPJ9WNzfNXD=wEJoXTRVpFWm1TDKJrvNzA@mail.gmail.com> <CACsJy8CjWBRtj3x3guyu-iJeTYxcRriXKbE=Be-rG=Rmesgt=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:44:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkq35-0005cR-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab2AKEo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:44:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38209 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab2AKEo0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:44:26 -0500
Received: by bkvi17 with SMTP id i17so220859bkv.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hJ8wQ2usqO5YSVGz4//clTuVOHMfu0tAPfDr5wCmt04=;
        b=HbuAL50DWdtYTpJ1NNhav9AmC/awvK9sD4yZKmXafgpIDoGE3NEvQk6kk0dxEsi83X
         iEig7q4q+K/JnxouiSJ3qmutR3woOugpDGscGlX2ceQXqCevs2Wj08TaVqS868O74dSc
         5OKrtQ75a+q3GwhYvgJyqsofj4jVvE5zkVx60=
Received: by 10.204.156.156 with SMTP id x28mr9776596bkw.76.1326257065317;
 Tue, 10 Jan 2012 20:44:25 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 20:43:54 -0800 (PST)
In-Reply-To: <CACsJy8CjWBRtj3x3guyu-iJeTYxcRriXKbE=Be-rG=Rmesgt=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188328>

On Wed, Jan 11, 2012 at 11:43 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> 2012/1/11 Ramkumar Ramachandra <artagnon@gmail.com>:
>> Hi Duy,
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>> Add commit message to avoid commit's aborting due to the lack of
>>> commit message, not because there are INTENT_TO_ADD entries in inde=
x.
>>
>> Is there any way to differentiate between the two kinds of errors, s=
o
>> that we can avoid this in the future? =C2=A0Can we grep the error me=
ssage
>> for something, or inspect the exit status?
>
> commit exits with 1 in both cases, so no.

but grepping error message should work, sorry I hit send too fast
--=20
Duy
