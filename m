From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 1 Jun 2010 18:36:13 +0200
Message-ID: <AANLkTinLoLr2adyLpVSUHkh0_6heaCNsnHWyzrESDLPu@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	<4BF7B751.7050704@pileofstuff.org>
	<4BFB7F7F.5090407@drmicha.warpmail.net>
	<4C041656.7000008@pileofstuff.org>
	<AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
	<AANLkTimenYsHEhTO3wqW_BRMMKZbA6ExLOOytaopGLjh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 01 18:36:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJUSA-0001P4-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 18:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab0FAQgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 12:36:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61025 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0FAQgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 12:36:16 -0400
Received: by gye5 with SMTP id 5so1291908gye.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3hab65AvROqBgF+nfdj+4fZp2kqW9/qWj3hQIwhADnE=;
        b=BKOaH7wCFkdEAzadYaaIQ9uzJMv6nUMbi3weIeVuVd2MDPlJFSAopLKzxzB6GcAQoF
         7qY0lSKPI5GHM6ZtvItmrVJJ3uWGRbJaLBSjzW25MnIygndQpqF9E41Qgh7fyoyUJVrv
         YcuAOOyFiP7AmIBRh8AhcCuyHq0y0YgBUDOJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rOoDVnbf3yIMIjWapSw0pkCfEuUvY04bNxlJx7MoX3dtFlW1mwTrKC81GuGHponnZw
         IVstNDan98QETRTVPcKTBJAScfagAu44eNMjhiEG87dtndTsNFCLOYrlnVm0NHYnpO0W
         tOc7ZmXbloAHkLFdxanLpdcg5DUSbStKOKyd0=
Received: by 10.101.4.26 with SMTP id g26mr7554136ani.157.1275410175332; Tue, 
	01 Jun 2010 09:36:15 -0700 (PDT)
Received: by 10.100.34.5 with HTTP; Tue, 1 Jun 2010 09:36:13 -0700 (PDT)
In-Reply-To: <AANLkTimenYsHEhTO3wqW_BRMMKZbA6ExLOOytaopGLjh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148138>

On Tue, Jun 1, 2010 at 6:25 PM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> = Empty directories =

> This has been solved in recent versions of git: git-svn creates the
> empty directories when you check out. It might not be 100% robust (I'm
> not saying it isn't robust, I'm saying I don't know if it is), but it
> works for my setup.

Oh, i see, i'm using an old version of git and I did not noticed this.

>> You also can't create new Subversion branches or tags with git-svn,
>> you'll had to use subversion directly for that.
>>
>
> Incorrect. git-svn have sub-commands called 'branch' and 'tag' for this purpose.

I wasn't aware of this command. it is strange I did not notice them before.
But thanks for the correction!

Regards,
Daniele Segato
