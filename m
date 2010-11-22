From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 22:29:55 +0800
Message-ID: <AANLkTim19WCCz6_iMrRj9cLU1-Q=MGAWnvYOc8=NBC_F@mail.gmail.com>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
	<vpq4ob9qy6f.fsf@bauges.imag.fr>
	<AANLkTi=uxRfsy2vG+4CBJv8Vhjrr2roVOXeNLvPA+6U+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 15:30:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKXPA-00046w-IN
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 15:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0KVO36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 09:29:58 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54018 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab0KVO35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 09:29:57 -0500
Received: by ewy5 with SMTP id 5so1623358ewy.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k73HV1jmxNbYWpYGEKGVr+A4JF7GlQn3vxdGVGqCB1Y=;
        b=EuwzFvTcZwDa7YRzM1TFeh7at08izzpobFYseWlJabtyYdopK0gCnA0Fmk7gUapyE0
         bckQVfTAQdcjsXDsAd9iULX9AlDBc+tyE1d0kKFKI10KvKPo2qpchQcHS/DVagB2T9NI
         BSNYsS6iPFIChMZ4cBfv9xct0iantAQ9gwv9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=If6AOFyt5K5+iwqxUoUtVzUgOEbR/cjKYihdp4+NA0SdFA78C4jBu2y4c0gOA5M7yE
         ZJNs3cJ7oeAKV98eWBLjtXJUGGT3A327G08dv8gvTBALy1zC/gHF9fSrOuECZzN6J0cs
         am11HNOFtTRDNX4QYXSUtoa31I+X3n1++gJnI=
Received: by 10.213.28.133 with SMTP id m5mr7703565ebc.28.1290436195766; Mon,
 22 Nov 2010 06:29:55 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Mon, 22 Nov 2010 06:29:55 -0800 (PST)
In-Reply-To: <AANLkTi=uxRfsy2vG+4CBJv8Vhjrr2roVOXeNLvPA+6U+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161897>

Hi,

On Mon, Nov 22, 2010 at 10:22 PM, Patrick Doyle <wpdster@gmail.com> wro=
te:
> That looks kinda scary to me. =A0The last time I played with git-rese=
t,
> I ended up losing(*) the commit at the head of my branch. =A0((*) Wel=
l,
> I didn't "lose" it in the sense of "it's gone forever", but I lost it
> in the sense of "it doesn't show up in git log anymore".)

That's the whole idea of git reset. If you want to see what the "lost"
commit was, try git reflog; it's very likely at HEAD@{1}.

--=20
Cheers,
Ray Chuan
