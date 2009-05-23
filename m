From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Sat, 23 May 2009 20:03:56 +1200
Message-ID: <855e4dcf0905230103q33508f0eh3aa2838ee71e0a81@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
	 <4A1671E5.4030400@op5.se>
	 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
	 <4A16822A.2060404@viscovery.net>
	 <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
	 <alpine.LNX.2.00.0905221259330.27232@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat May 23 10:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mG1-0006MH-3m
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZEWID7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZEWID6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:03:58 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:61408 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbZEWIDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 May 2009 04:03:55 -0400
Received: by gxk10 with SMTP id 10so3992432gxk.13
        for <git@vger.kernel.org>; Sat, 23 May 2009 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c0OWmQtWTavbxsDDcYE+kJW5xp81GI9MIzplTzbPSWA=;
        b=tKBLTodwKlh8AN8wh3TlWuBu7GhcrXL37B2r8dsWtzcXcapAiwkYmDu2TbXquHr/5H
         gzcik135ffdXJsUNXNLXSR94c18zdyGgkQYRVJmyFmzqC/7lmzZVhGuevzC2zPDaUQHD
         OpX7GvONNBS7lfiYP6VC4F9nNm5d+NCzGyYKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ioODvK2Nm3yvHxhM5x0UJ8faV5NTRJoLLCIbXZI/N+Za9gISEOBbFrrzJVvkd+99kD
         j7jxFJ954MCaSifb1k/qFrxzUIJFh0iU6N+47cXkGUyRwZj8+JgHdfau7CBl9r4DswXS
         dcFcaTepVz6hDBDaCiKV8xAvKk0u/Cz1PswDw=
Received: by 10.90.93.17 with SMTP id q17mr3996892agb.33.1243065836246; Sat, 
	23 May 2009 01:03:56 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905221259330.27232@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119758>

> What's in the subdirectory? =C2=A0Is it empty? =C2=A0If so, that woul=
d explain what
> you are seeing. =C2=A0Git doesn't track directories - so an empty dir=
ectory is
> always treated as an untracked file.

The directories are not empty. They contain various tests (unit tests,
integration tests etc).

>
> I don't know if mercurial tracks directories, if it does, then this w=
ould
> explain why it behaves diffently to git.
>

That might be the reason.

I am just baffled. I have run that script many times and it always
turns out the same. For example on one run I removed all the .git
directories in all the subdirectories to see if I would get different
results but it didn't help (git mv worked but the messed up
directories remained).

I also tried renaming other directories and similar things happen.
