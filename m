From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Rebase difficulty
Date: Thu, 24 Mar 2011 21:20:59 +0100
Message-ID: <AANLkTi=+uzVGSi+FO2k3qE_T_By9ynTSE1h6uENFbZ8M@mail.gmail.com>
References: <1300987351-3248-1-git-send-email-lazfamam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Afzal Mohammed <lazfamam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2r21-0008Hs-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 21:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934206Ab1CXUVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 16:21:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50191 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934199Ab1CXUVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 16:21:00 -0400
Received: by bwz15 with SMTP id 15so398809bwz.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C9C4Yb4PuJKuGwCfTWvBAwviqYaUtrWub/VBMjlTc/M=;
        b=AdfECkARutaWsceZ4m7h3k3JLpal4UvWyzxHUMVBZZqyVUdN/vJ9fnF7eQZFgJsA2z
         Jwfsh9MOXW7Bur5bAVL64i9aYf0EANyuZevRzAAo/oCXx0rUVeiOvnLzR5RuzlWsmHgY
         7rOf0qhdRC2x9YcdeVAfy1BgJJhUkR0p4u/RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Z3CKRguvUI6vu+qprwG5oO1/tYsgs4d+dM7kaisyiDTc7YXz5V9cH323EPF2V0tXHv
         Qm56vk9jBifDFBlpZC2qJD72XsIZ8JUmkAoIbEZQe81oNhwk5jV/bmZOYsuLuCws9BIp
         vdPrWgER57iMpgMQNhaBbLaVZWfmbFgeu8VGE=
Received: by 10.204.154.74 with SMTP id n10mr7700829bkw.33.1300998059060; Thu,
 24 Mar 2011 13:20:59 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Thu, 24 Mar 2011 13:20:59 -0700 (PDT)
In-Reply-To: <1300987351-3248-1-git-send-email-lazfamam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169942>

On 24 March 2011 18:22, Afzal Mohammed <lazfamam@gmail.com> wrote:
> Hi,
>
> Is there a way, while in the process of rebasing, to skip multiple patches with single command ?
>
> Current scenario,
>
> "[1] git rebase upstream" has been executed initially, around 500 commits would be present after upstream.
>
> out of this 500, some commits has to be skipped (contiguous at different points) and some has to be applied. After [1], git starts applying, it has to be stopped, skip a few, continue applying a few, skip a few and so on.
>
> Please let me know if there is an easy way of doing it or is there any other command meant for this.

git rebase -i ?

/Lasse
