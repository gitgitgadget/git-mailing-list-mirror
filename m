From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone --depth and git describe
Date: Fri, 10 May 2013 08:36:35 +0700
Message-ID: <CACsJy8D=getgkDV9A57=_N+u-XPPy8Cxdx5W+QADnCiGZxFRWQ@mail.gmail.com>
References: <201305100107.59115.sweet_f_a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ruediger Meier <sweet_f_a@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 10 03:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UacGo-0007G2-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 03:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab3EJBhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 21:37:07 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:58569 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab3EJBhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 21:37:05 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so4330602oah.10
        for <git@vger.kernel.org>; Thu, 09 May 2013 18:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sDn84qMiq7yBmy9y9QW44Fif3x5XOSMl0/fNwlwFqOg=;
        b=l1n+docMq86ccTvMydlrzCgs3s9lNNdYp7+SP4YVvJuLdW72n8sMVPIN5x+a47kpCf
         G93llqMuQFHwUMeCFDiQ7npX71pM2j/tmaD1FPbyclGV2R6e3ZkFOvK9BTdECfgXDEhb
         1L9BHDmrXVKryxv7pNmHxVa8sB/53on0avd+uBCK+yeDCKQQrinWLEMQ9OGYt6wUneLT
         SvcKKDGJvXtOMCir6GoL2UnGXv1EdQIIS9yxdULjfC3ubAZOG7IznBFxuGf4ksp/r3zL
         pv4RMZVVGW+ROol9/SHnMQj7BaxfaourWpeoz0F3w9ipGlKmPFCPg/C8+9AmBkKW06Gn
         AWLg==
X-Received: by 10.60.65.68 with SMTP id v4mr5796306oes.13.1368149825383; Thu,
 09 May 2013 18:37:05 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 9 May 2013 18:36:35 -0700 (PDT)
In-Reply-To: <201305100107.59115.sweet_f_a@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223810>

On Fri, May 10, 2013 at 6:07 AM, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> Hi,
>
> I have a use case where I'd like to improve performance using "git
> clone --depth". But I also need "git describe" working on that clone.
>
> So something like
>  git clone --depth=describable
> would be nice to have.

What does --depth=describable do?

>
> Would it be possible to add such feature?
--
Duy
