From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 13:23:29 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102081320350.4475@debian>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 19:23:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmsE1-0007Ca-GM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 19:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab1BHSXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 13:23:36 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55293 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1BHSXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 13:23:35 -0500
Received: by qyk12 with SMTP id 12so5019366qyk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=Xh0J64E+CEckLUGkpUM1tj1VxlQRpscDrs9zN4zss8Y=;
        b=NRSab9k5Z1nUcp5fZ2d0X/3nLrrvv3xrdiBNJ8rCLIOVQ0Uh4oq46KtvhtbSCqhWOl
         wmHRd9kbaeYdF6Y49kannIxCifraZ3Yg5T2bTftM2hP51n0nlIxlguQQEVpNEuYc3G8s
         ki3cmVIr/9bFS+kY/TufTuQTCv30vcFyqkViI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=wBoOHM80L2g6Ah9p3ZYMprptLaQq8RvR3V2LxOH7jXfNnVxSgt1pp0lAc+QufDnS2A
         oxg3VmApTmrkwFQwu3FPjNxgjMDsGLOCQx7j0k7YMOzE0BazK0ASMoghPNhS4S8Y1a3Y
         FaBKtc0q/5ssdkPChtCDXz3zC22RqZvQb+PuE=
Received: by 10.224.29.5 with SMTP id o5mr7586731qac.164.1297189413479;
        Tue, 08 Feb 2011 10:23:33 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q12sm3834043qcu.30.2011.02.08.10.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 10:23:32 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166363>

On Tue, 8 Feb 2011, Sverre Rabbelier wrote:

> Heya,
> 
> On Tue, Feb 8, 2011 at 01:37, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> > Defaulting to @{upstream} will make it possible to run e.g. 'git
> > rebase -i' without arguments, which is probably a quite common use
> > case.
> 
> I particularly like that you explain to the user clearly what they
> have to do to make this work (e.g., configure the upstream). Nice.

Thanks, but that was stolen from git-pull.sh ;-). Federico Mena
Quintero added it there in 8fc293c (Make git-pull complain and give
advice when there is nothing to merge with, 2007-10-02).

/Martin
