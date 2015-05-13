From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cmd_struct
Date: Wed, 13 May 2015 16:24:14 -0700
Message-ID: <CAPc5daUF1SaCOqb0iEZ527q-CgQn3YyMSWufOsQx9Lo1+aUBrg@mail.gmail.com>
References: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 01:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysg12-0004mf-EC
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 01:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965498AbbEMXYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 19:24:36 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36010 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965125AbbEMXYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 19:24:35 -0400
Received: by obbkp3 with SMTP id kp3so41519980obb.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CX0PKsSPzanTi9K0i5rmvwzkV/7dLmkt+qQNxZKuogM=;
        b=b68/1fx0cVgm4HwYbh95ep7E0ZiWxrb6OuCDL6saWFGmk9PTwarCUQRpJuOyE58iZJ
         m51eWr2N+sUZgglTzjQUOrVZ0VttLODeYl6JC1Z/ijzi+54WeQR7blZK08cNKDBNBIUt
         qnxkGL+gz7Aw2ERFMqJMRmudJ5SiEloIVPk0ViDz/5RIATLy9clvEI5Es8+QqEBiCwVj
         N9HsKi7xarX57YKoNgH+4AOvaAP99Ed0PMx2susSzS5xkSSd6XRpySx4NoEfyu1IXHm1
         /g3dx6q+YUPMOGTIA+/UVbQOi+8C/5J+naspJ+n1yxKxXsEZbPsYd+EN2smpE81Vfchi
         11Ew==
X-Received: by 10.182.29.101 with SMTP id j5mr1147141obh.0.1431559474940; Wed,
 13 May 2015 16:24:34 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Wed, 13 May 2015 16:24:14 -0700 (PDT)
In-Reply-To: <CACnwZYe5i3p0f7cvprya=VdhFnnMW_H=K18BFqjq_Qn86cjXeA@mail.gmail.com>
X-Google-Sender-Auth: PjU_S0MsoxEY6St5e8UwaCL_oEU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269018>

On Wed, May 13, 2015 at 4:10 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>
> Would be too churn/noise (at this point) to rename cmd_struct to builtin_cmd?

The name has served us well, I do not see a compelling reason to change it
to anything else, and I suspect the name stayed unchanged because nobody
else found such a reason, either.

So... if you are unwilling to make a compelling case telling us why the current
name does not work, I do not think it is likely that anybody finds such a change
necessary, welcome, or even tolerable.
