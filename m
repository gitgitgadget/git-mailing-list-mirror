From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 26 Nov 2010 01:40:39 +0100
Message-ID: <AANLkTimbGZYBwG83KxJV8thHqmnFGO__3SQGoqx6u+Uv@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
	<AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
	<AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
	<AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
	<AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
	<AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
	<AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
	<AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
	<AANLkTin-kF_+DKDAu=gt12WfOcEVJaED-Qny8sFQ=oKP@mail.gmail.com>
	<AANLkTi=hRk-bqNvvMRCmbSu8Mc4uux5aowgLGnPLnD4A@mail.gmail.com>
	<AANLkTi=G0m_AY3PMVs93=u=cKtVrAjFD56KPURYAyhyh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 01:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLmVy-0002GG-Sc
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 01:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab0KZAuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 19:50:06 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35608 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab0KZAuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 19:50:05 -0500
Received: by fxm15 with SMTP id 15so306667fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+Gks4HadH4C1/PuuxWgiLsl4DGO5xRejzdTC4FZ9T/E=;
        b=ZpYsoNoFmjb0wGyVcVQLKOYDLQkG0sm9OTCpuzFuK+pUyD7Vx4WIeM17sagseVWf3E
         8EsM1XSTB3ms9moeGRtmY/PfKYUg9ZqcQG4SHFPQLXDXywXt12ou8Qxas6GB7UBHYoMD
         tYtV/I9/kdjUAygA+3W7oW5DuMIc9l2yZa43U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SVuJKJ4ruM08LhRzZ2nFGdfek6VMKCOLCCc4FaqWZMOTVpbQnMR3WEBrqJvuYlQ9Bo
         PZxbx6HPruCI77H5SAWdNRAb6rk7UVMDr0DZUCUFhmbCk8KB6KW/OK12b0koyE9wtNdJ
         i1y2G/TIzF5HdcffqugGMt8g+MmXFe8lCI3ls=
Received: by 10.223.108.147 with SMTP id f19mr1437790fap.68.1290732039191;
 Thu, 25 Nov 2010 16:40:39 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 16:40:39 -0800 (PST)
In-Reply-To: <AANLkTi=G0m_AY3PMVs93=u=cKtVrAjFD56KPURYAyhyh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162159>

On Thu, Nov 25, 2010 at 21:02, Erik Faye-Lund <kusmabite@gmail.com> wrote:

> Well, there you go. That's one of the things that needs to get fixed ;)
>
> I don't quite understand why you won't do it the way I just proposed
> (and IIRC a while ago by Hannes), though.

Does it help if I don't understand it either ? :)

Anyway, there's obviously a bug that needs to be fixed. I'm just going
to have to poke the Makefile to see how to fix it. When I do I'll make
sure to try both ways and see which one makes sense, then document
that in the commit message.

Hopefully you or some other win32 dev can help test whatever I come up
with, thanks for all your help so far on that front.
