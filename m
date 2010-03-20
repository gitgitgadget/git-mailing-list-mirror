From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [RFC][PATCH] grep: enable threading for context line printing
Date: Sat, 20 Mar 2010 12:21:05 +0100
Message-ID: <4c8ef71003200421n5d67fb39u11c706702acec548@mail.gmail.com>
References: <4B9D2864.9090808@lsrfire.ath.cx>
	 <4c8ef71003141303h474429aegc0a2eb2f97e7ff69@mail.gmail.com>
	 <4B9E5E76.9000702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 20 12:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nswk0-0005P7-JM
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 12:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab0CTLVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 07:21:10 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:40394 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab0CTLVI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 07:21:08 -0400
Received: by fxm19 with SMTP id 19so1284065fxm.21
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DPJby9dad/PWIXylUF8kbm5XvJGKO5pDD1OMB9T0InE=;
        b=jda2+j9az2usGKtTmOzXpQ4WiGWF8EJ75VmwB9qC7ec/Z55Fbr6uVQ5HNI1B9ROhFd
         VXTE+VJGY5a3Erx5iB0o0aNqB25JMSbWEQ81uCq6qpMZC5LIohD7jcSfPwlrz7RFqdkt
         B61Xrq+CNExE614OUKZIGNX4tdL8iws+iZi5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sCwf1NZTatvm4F/BkMZ9PIT8rtIHAdlCSHp5BzmUAF+jbYaxeB+2Cv9DaA314G/ZCx
         fBq+FsYTKAp2Uh8fMTHXl1RQBnjdgzEfczt5zKjQOIDC1zi8+7qagbj2MuoGylmc/gOd
         giQW8yFz/wTpY04zvRb/bEfLXH3pSyc4rxt5o=
Received: by 10.239.184.7 with SMTP id w7mr220199hbg.25.1269084065818; Sat, 20 
	Mar 2010 04:21:05 -0700 (PDT)
In-Reply-To: <4B9E5E76.9000702@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142702>

On Mon, Mar 15, 2010 at 17:21, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath=
=2Ecx> wrote:
> Yes, that was a bit too complicated. =A0I shuffled the code around a =
bit,
> so the patch is now a bit smaller and avoids introducing value 2 for
> show_hunk_mark. =A0Better?

In my opinion, yes.

- Fredrik
