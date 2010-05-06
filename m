From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Wed, 5 May 2010 20:35:24 -0600
Message-ID: <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 04:35:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9qwK-0001y3-6R
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 04:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab0EFCfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 22:35:46 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:46157 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0EFCfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 22:35:45 -0400
Received: by pzk42 with SMTP id 42so1747999pzk.4
        for <git@vger.kernel.org>; Wed, 05 May 2010 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=Dx+wwl/PtVbPKPtq+SAkYCMsIQOGOSN4qqoqCRBfLYg=;
        b=u9BycjJG3lJfgtf5NDll7Zi5IuMSEiGuJasiIFXv5ZT6bEjA/JZl/XvsGqlLNGASqC
         yOGFt3BelgIucbXI+lJvF0wMI1kzJMUZpdM9u+Sl9LNmSsAOj3WeBtpeDND01MtEq8eo
         7lxGRGL6sZX6qya13KpGKDsLiFK+ZDBeFS14c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=khvaIZKU6t8rv7lebdphqf3+qcL2+txRHa2YakvYdpUTxFhPemMt5QCMEG6JnGQBlq
         6DLjl60OMK8G37QYvlYaFNmhK1lIb46o6zO0qlGDXa2jt+Hoy1LYqf8rJvJFYZF6DxGS
         GHenbd19CRlG/zx1ujYDoPAnyUHYilG6QM7bc=
Received: by 10.143.21.24 with SMTP id y24mr3115919wfi.254.1273113344305; Wed, 
	05 May 2010 19:35:44 -0700 (PDT)
Received: by 10.142.180.3 with HTTP; Wed, 5 May 2010 19:35:24 -0700 (PDT)
In-Reply-To: <4BE141E3.2060904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146432>

On 5 May 2010 04:01, mat <matthieu.stigler@gmail.com> wrote:
>
> Hi
>
> I have two git projects:
> -one (A) with linux people only
> -one (B) with someone using windows
>
> As we had "end of line" problems with the person using windows (B), I used:
>
> git config --global core.autocrlf true
>
> Following advices from:
> http://help.github.com/dealing-with-lineendings/
>
> So everything now if fine with project B, but now some problems using project (A): I wanted to copy the whole project file to another dir, and now it is complaining about the change, signaling warning:
>
> CRLF will be replaced by LF in .../A.
>
> So I don't know exactly what I should do...Should I change all the CRLF from project A, but people will have also problems, or can I switch the config, once I'm using project A and B? It is not so clear in my mind and I would appreciate any advice!!
>
> Thanks a lot
>
> Matthieu Stigler

I personally find that autocrlf causes more confusion than it solves problems.

I've yet to see a text editor on windows that can't handle \n line
endings. (Notepad doesn't count)

Just keep the project with \n line endings, disable autocrlf, and make
sure that people are aware of this.
