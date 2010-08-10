From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-notes: Run partial expensive test everywhere
Date: Tue, 10 Aug 2010 21:56:24 +0000
Message-ID: <AANLkTimQE6q=3jOXZcWrFfRcpA6-Ew79z9+r-RwyaYHZ@mail.gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 23:56:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiwoD-0007KI-F6
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711Ab0HJV42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 17:56:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64943 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0HJV40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 17:56:26 -0400
Received: by fxm13 with SMTP id 13so1014621fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9LmwTecOPwsVCsLMKkia3bvTna7h1+uZh11aj9YgV7E=;
        b=JGqJJ6g4mqE4evfM7cz/VVgUZL0JDV/G0JGAABm5nVz0V81cp0xXXAMg9FR86QClaD
         mBa9+Xms2+F3e5ZtPqSWD8SzmPwcITIx50w8n0Y/qmGzWheTudGqUspgFayQZxqDLIMd
         kpuDjlIzN3InfypQiN0fdCx1Kb0WdghsYGlCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M7CyFQINAddgDVsLwlFrgo+FaXcWKzYz/FR4sKxWt6S6fkK8yCswZJO9GCy3OwPmRX
         TeGIRusqwJ+ESU/2QmIWycIKutK44MS/vag85UueegRUhu3XLYfAnP8AHzomigACaYY/
         r9W0QjzjJ/sTWmObb0fJ1e+3pDBq372Cbo07Y=
Received: by 10.223.106.202 with SMTP id y10mr19004948fao.2.1281477384497; 
	Tue, 10 Aug 2010 14:56:24 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 14:56:24 -0700 (PDT)
In-Reply-To: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153161>

On Tue, Aug 10, 2010 at 19:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> + =C2=A0 =C2=A0 =C2=A0 # Hack around multiple test prerequisites not =
supporting AND-ing
> + =C2=A0 =C2=A0 =C2=A0 # of terms
> + =C2=A0 =C2=A0 =C2=A0 test_set_prereq USR_BIN_TIME+NOT_EXPENSIVE
> + =C2=A0 =C2=A0 =C2=A0 test_have_prereq EXPENSIVE && test_set_prereq =
USR_BIN_TIME+EXPENSIVE
> +fi

In retrospect this may have been some brainfried code, I'll check it
out tomorrow.
