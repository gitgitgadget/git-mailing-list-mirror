From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Sun, 11 Apr 2010 00:32:26 +0200
Message-ID: <j2kfabb9a1e1004101532tf16f9d55y404b5f7595d587c3@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com> 
	<r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com> 
	<7vhbnk1gc6.fsf@alter.siamese.dyndns.org> <l2nfabb9a1e1004091423te78b692btd8bbb03785f94a16@mail.gmail.com> 
	<s2l76c5b8581004101530h171f3c2dv6a2fc9d4225fbd4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jES-0004Xm-EA
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0DJWcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:32:47 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:62290 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab0DJWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:32:47 -0400
Received: by yxe1 with SMTP id 1so1942909yxe.33
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=TIrHM3SJtNJCoqeoolBxhmVcWkJoZ2VsH2iCur5TAV0=;
        b=cGB7S4HHpUt4QpCnd9kT35uGwmPyY3Tba7ysxwyegHyFcV+/8S4Lu64Mm8etF760ii
         1hfrTTiBhgB8Bs99DAVF3MoSm85KtdDVJsaHePo4X/RjHX9ez5MDs9dPIhfYo8NKmgdp
         YxbyWjkStVGwpvm6Cl7HqXgQDnIUwb33KT8sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bZN8pj4/hqsv10YOnhEPGnQ19Gp/mp6/nEcF0aOSmRiEh3+t++d0te9mf4qOqQdG0h
         ObCG8OCckckGNYn5XwXEPQJtJF/ksllxu5wlSDmfH2Gnpn+fn3O1QL/xVwQyqCBZWyB4
         34Ubtsj3TS0xEZ3eYhjrpwda+0npELkS9moQA=
Received: by 10.100.206.13 with HTTP; Sat, 10 Apr 2010 15:32:26 -0700 (PDT)
In-Reply-To: <s2l76c5b8581004101530h171f3c2dv6a2fc9d4225fbd4e@mail.gmail.com>
Received: by 10.100.74.5 with SMTP id w5mr3591694ana.206.1270938766109; Sat, 
	10 Apr 2010 15:32:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144608>

Heya,

On Sun, Apr 11, 2010 at 00:30, Eugene Sajine <euguess@gmail.com> wrote:
> How is that possible that it is not an argument to --onto???

What I meant is that it's not "--onto=<value>", "--onto" is a boolean flag.

-- 
Cheers,

Sverre Rabbelier
