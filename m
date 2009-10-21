From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] git checkout --no-guess
Date: Wed, 21 Oct 2009 18:51:46 -0400
Message-ID: <32541b130910211551n13e0dd1bha6dcdc82d1d6b4cd@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> 
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> 
	<7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> 
	<7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> 
	<20091022062145.6117@nanako3.lavabit.com> <7vskdcz973.fsf@alter.siamese.dyndns.org> 
	<7vtyxsxtmp.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0k2T-0006sI-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbZJUWwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbZJUWwD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:52:03 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:54317 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbZJUWwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:52:01 -0400
Received: by gxk8 with SMTP id 8so8006999gxk.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=42rSLQ0DF7Ir5NZL7R2FkHz7h+vPz5/MivYygvCpoi8=;
        b=cz3LnXC+fOvLcZw+sD77oRW1rooSHR3ay1JzBxR1FmFFdUhFBFAV7l6INCCTVr41ts
         uCToE+E26C6sdYqu6pCvldPVyy5qhGOciGnLTP4/WIFM/qCqFfVhvBwvCoS0yMER01DN
         r11q7osG/LkrT7eixWyIyVq/wEhf7W2JDb3fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eUAzGbwNru/Aw4FXlzTy8Uj/QMbWcQJ8JYdpz2o/n6WEyM7wJsDXdQiHjox2vkih9c
         0Hm5GTN9DQKQAgTCN0NSjNSqTfgPAxj/uiSUmAQT9OrtZq6MvIi2FjGHCuglZQHcrD8T
         5GAAwH0mxqBjmy1SdnaqkvyaE7BWgBoxv+IzE=
Received: by 10.150.32.1 with SMTP id f1mr14146411ybf.96.1256165526154; Wed, 
	21 Oct 2009 15:52:06 -0700 (PDT)
In-Reply-To: <7vtyxsxtmp.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130984>

On Wed, Oct 21, 2009 at 6:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As this is strictly script-only option, do not even bother to document it,
> and do bother to hide it from "git checkout -h".

Is it a standard git policy to not document script-only options?  As a
person who writes scripts that use git, we will need to discover these
options somehow...

Just curious.  (And now wondering how many other wonderful options are
in there but undocumented...)

Thanks,

Avery
