From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 12:33:06 +0100
Message-ID: <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
References: <4B768807.3030003@gmail.com>
	 <20100213112342.GA1299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGFU-0000vG-Rq
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0BMLdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:33:10 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:9105 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0BMLdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 06:33:09 -0500
Received: by ey-out-2122.google.com with SMTP id d26so818756eyd.19
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 03:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vCZLU2+wCVtauKS8KTFMGdv/62jr4tZ2Z7II9RtCbuU=;
        b=gdXz7npzBx53pZhuz476AWWnb9n+vOcOF3cksB7l/y6vj2TpzQHWnRjIzJtrcAkqoE
         zcUuZyyUlW0kPiqyS3WugrHJBUKqiYIliz1gzTd1SutBn8vhYTSdrQNscZgMGb3wKxlQ
         MNu/YnhGVUDQaP6fOU36R6n8UAJKVhlJvit6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=liY9BiAs8fnzmu8ong3qdjAx8MMdEj4Ai9wRX0q2h9rYH4i2NI2D31WygVt0TOLFh8
         4pV+ndtLlvFnNJ1X5yLWIlyduhaHgljkOFnX2wwlXzcBYHojrzaCQxI9tPyeNlUnyEcO
         Tc817Y5Fj03BZQGUcp/O1INbT0RzJIT1egNXI=
Received: by 10.216.88.205 with SMTP id a55mr1617638wef.122.1266060786774; 
	Sat, 13 Feb 2010 03:33:06 -0800 (PST)
In-Reply-To: <20100213112342.GA1299@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139786>

2010/2/13 Jeff King <peff@peff.net>:
> On Sat, Feb 13, 2010 at 12:07:51PM +0100, Bj=C3=B6rn Gustavsson wrote=
:
>
> Wow, I find this terrifically ugly. I guess you don't use
> color.interactive, which will output a colored hunk header?

I do use color.interactive, but I didn't find that distinctive enough.

> Or is it that small hunks tend to confused with the previous hunk?

Yes, my hunks were small and I wanted to go through them
really quickly, but still be sure that I did correctly, so I found that
I spent a lot of time making sure that I have found the beginning
of the current hunk.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
