From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sat, 4 Feb 2012 17:26:01 +0200
Message-ID: <CAMP44s0xfbxLs_r81ppO9hYf3ML_gaYCaW3TKpLM=BjfaM8vHg@mail.gmail.com>
References: <1328368255-10591-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:26:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthVD-0001Q5-2j
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2BDP0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:26:04 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56188 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751927Ab2BDP0D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 10:26:03 -0500
Received: by lagu2 with SMTP id u2so2318883lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mCiSEuVefmleaq8Eq5vlRRbAT/fX4y+C6vl876GHDno=;
        b=FIvHD9yhFb7w/2/Yxrcscj9uQs4ovSymDnqPGHdtPEwsmrsQW8ZHzxaagIGUB/RF2a
         gNF0QsXoFyd32pSUM2HHrJBdWIo/L0C3Ujcb3ZGPv8dPAIkSz7mc6tCHviUU8tHCOxOQ
         q+r/6Mlsxy7xIf9eLkAkKKYbzzIAkwBefOHGw=
Received: by 10.152.125.20 with SMTP id mm20mr1296188lab.6.1328369161531; Sat,
 04 Feb 2012 07:26:01 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 07:26:01 -0800 (PST)
In-Reply-To: <1328368255-10591-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189871>

On Sat, Feb 4, 2012 at 5:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Otherwise, 'git send-email' would be happy to do:
>
> =C2=A0% git send-email --to '<foo@bar.com>>'
>
> And use '<foo@bar.com>>' in the headers.

Er, actually that's not correct: '<foo@bar.com>>' will remain the
same, but 'Foo <foo@bar.com>>' will be sanitized.

--=20
=46elipe Contreras
