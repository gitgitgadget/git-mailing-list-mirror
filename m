From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: t9155 fails since "git-svn: fix fetch with deleted tag" with svn
 < 1.5
Date: Thu, 19 Aug 2010 17:21:25 +0000
Message-ID: <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com>
References: <4C6D6274.90009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 19 19:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om8oA-0005td-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 19:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab0HSRV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 13:21:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57914 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0HSRV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 13:21:27 -0400
Received: by fxm13 with SMTP id 13so1237778fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0Eg/t7x16/8xrSOsNvmsj7L34qFS/H0Iu3Oy/tH5tVA=;
        b=lWhU4F7k1Yf7cYgqFAj2qdyF1/b4pIWtaM9C1Xcom0h0yQx+5s2tz9OmKxDrS9xEOZ
         IO1GgI/WZ3uELIJxuOmgNHFf3ZshcQ74L+TnRVSHcCNa1PrRS8mAswWKfvbfuGdg3mf3
         fbIq9uWes5fRu3HCQ0wmRBpfal7GhvqXwVniQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SYEZpyZfxFvZel2Qi6mdPCmHqaK5hiXKmoLkr8Pe6kHLP9xKmJlbRkY4lea2hp7L9n
         4WjShbFUiL3hXe2ZDzZPtvHCogTCLWakU3BtYbiusbh86CmjOf4m3rSKtw8rMKeG9EAt
         p8cNkSmb8JpUFLgx8hPHHtrz69gT1FeV4A+Y4=
Received: by 10.223.115.194 with SMTP id j2mr128357faq.47.1282238485836; Thu,
 19 Aug 2010 10:21:25 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 10:21:25 -0700 (PDT)
In-Reply-To: <4C6D6274.90009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153944>

On Thu, Aug 19, 2010 at 16:57, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> t9155 fails on current next when running the testsuite on a Fedora
> Core 7 system. The reason is that FC7 comes with svn 1.4.4, while
> in commit 3235b70 the --parents option was introduced into t9155
> which was added in svn 1.5.
>
> What minimum svn version is required for git svn? I didn't find any
> information about that, but I might have overlooked something ...

We currently require >= 1.1.0 of SVN::Core for the git-svn tests at least.
