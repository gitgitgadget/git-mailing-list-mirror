From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 22:39:42 -0600
Message-ID: <AANLkTinH8UWbkCUBFa1yr1fOQJgs9rLOj_kcp2UR3iua@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
	<AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
	<AANLkTinQYfpWYJ8Lr3=VX+x2Xj+eQfYztT1GHh2AQKff@mail.gmail.com>
	<AANLkTi=3tGf=Gw6SnRLOSaURw7JX=qEPtLCzLhZN1D+y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 06:39:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoUFk-0003Ca-89
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 06:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0HZEjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 00:39:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40817 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab0HZEjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 00:39:44 -0400
Received: by fxm13 with SMTP id 13so1022433fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iQlKjATsmgGfXaKLvOM6HeEVmgYXGkO32b+zJsdKPNQ=;
        b=PtTyEbPyV9Y/M4GBcQcJbLj3LaGq8G28Qi51RkjKcLTVxBN14BotbhesffDtIVC3N8
         8rPwFJ7R1bkQw1hXf4rB4cXz/Qtz+0S0Lky2rsc7QDU08l+GwK+OAJFzPm2b74vSwcMk
         geaWl0MfZ7HL439I4LhMK75G9Fn5Dx57R2cwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q5Os7JgV9mJvRZRmBvzUIK9wWhZa/zBgifm9votcN+jRYCdEjWTA+d5ywqpJibkdGu
         Uv5k3I+TftkS6FYtgoYfnp0GlV1uwRBa6UaED6KvYccaqikhosXw8yjbRL53XrOLtCq5
         67nLHszmg4xCHGy0SvueD86GuDIUoiJaZXLFI=
Received: by 10.223.109.7 with SMTP id h7mr2411432fap.100.1282797582749; Wed,
 25 Aug 2010 21:39:42 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 21:39:42 -0700 (PDT)
In-Reply-To: <AANLkTi=3tGf=Gw6SnRLOSaURw7JX=qEPtLCzLhZN1D+y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154506>

On Wed, Aug 25, 2010 at 9:52 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Let's say in "ancestor" tree, we have
>
> t1/f0
> t2/t3/f0
>
> In "you" tree, we have
>
> t1/f0
> t2/t3/f0
> t2/t3/f1
>
> In "upstream" tree, we have
>
> t1/f0
> t2/t3/f0
> t2/t3/f2
>
> The narrow tree is t1, so we the trees we have are toplevel tree and

How would you get the "you" tree?  Since you don't have the data for
t2 or t2/t3, there's no way you can create and commit this tree.
