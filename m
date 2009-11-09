From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 4/4] format-patch: Add "--no-stat" as a synonym for "-p"
Date: Mon, 9 Nov 2009 07:22:13 +0100
Message-ID: <6672d0160911082222yd3b1febp736c8d8bde2acbbd@mail.gmail.com>
References: <4AF544DF.6070404@gmail.com>
	 <1257721866.1734.47.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 07:22:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Ndt-0006LU-T2
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZKIGWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 01:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbZKIGWK
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:22:10 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:41436 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZKIGWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 01:22:09 -0500
Received: by fxm21 with SMTP id 21so37183fxm.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ucyO/KsL8Q7bBNr4ssNATbRdSediBNyYqsT4orflAes=;
        b=mFsqtvBrTPteH+RYI7cLbMvh+LyysEhL+bKzK+I8HgwCOmpv6GuwencuLmBBebMeGy
         SygoUlBOdDCQW6h3VNXHpPLaLUc3fUlM7rx3t3p1E2B07aBbHV8FUFn50xP6jtXVflUT
         BUfmVcXvFVCOMldJPfEcA8gMWNqFlSFX6StMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aaQerNXjQRYD1UKyOsR8mn3mgBWbxMXjzg8PUI44BhBJ3rq8XxcH8NbjRQcOVRBIb6
         /f3E/w2N9jJwqgxYWp/3+bKpT7mULWJ3ckqCLq4l3McMWqpPJO2GX4y+1UGQ/NG5B2jj
         hm8zctQlBZLUPRVjMXHj5tLJtWB4HVGUzxPxU=
Received: by 10.204.154.213 with SMTP id p21mr7970433bkw.163.1257747733419; 
	Sun, 08 Nov 2009 22:22:13 -0800 (PST)
In-Reply-To: <1257721866.1734.47.camel@swboyd-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132440>

2009/11/9 Stephen Boyd <bebarino@gmail.com>:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('p', NULL, &=
use_patch_format,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('p', "no-sta=
t", &use_patch_format,
>
> I think this needs to have the OPT_NO_NEG flag so users can't say
> --no-no-stat.

Thanks! I didn't know about that.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
