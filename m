From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Wed, 28 Apr 2010 00:22:22 +0100
Message-ID: <i2o86ecb3c71004271622v115f1f6dp7fbcb5bbdec03cc7@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <4B7E3856.3080609@gmail.com> 
	<20100219135549.GA31796@Knoppix> <4B820B4E.7050405@gmail.com> 
	<20100222105133.GA10577@Knoppix> <4B834989.50502@gmail.com> 
	<20100223124553.GA19153@Knoppix> <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com> 
	<4BD651C6.5050501@gmail.com> <g2ia038bef51004271013i4e085b31u7ee075bf57bc86a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 01:22:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6u79-0002j8-Tf
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 01:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0D0XWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 19:22:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56914 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab0D0XWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 19:22:42 -0400
Received: by mail-pw0-f46.google.com with SMTP id 9so9933012pwj.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=Qxdbej++kWUCFqnm4wPVbheYlDF5oY1ed3Ad1iPXySg=;
        b=HV13DWGEX/FNE/wqcM8XD4U5DKdLY3zZ442F5ZKXNjsc6o7kfISCP/KI0D0ni4hUbv
         9B7Y/WuOO/I1t9cRGeEKoJytSqy0mPUuBHw35jz0NyY8TecXFWNv512gCsewMmShnoOp
         +0//qgNIVbHgQ5AuhcvILm30sAl3dO7+0UPko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=US7SmTFYsy1ETV7CWQ+kE62pfsib9TV3TwhcREBWfwNSLIEITEHsUYxOe1wG/LAYOZ
         x6BYEDs56f5Wq4Z41/nEL1Wr44tV2Zza+MwrlKsFn9zYu43A2c9Gr6fTkxP5yOmoB0dn
         F/ufIjMP09pi5Y3G6GmzgqsBNcUuR9jMzFeqk=
Received: by 10.142.2.29 with SMTP id 29mr3651707wfb.204.1272410562366; Tue, 
	27 Apr 2010 16:22:42 -0700 (PDT)
Received: by 10.142.188.15 with HTTP; Tue, 27 Apr 2010 16:22:22 -0700 (PDT)
In-Reply-To: <g2ia038bef51004271013i4e085b31u7ee075bf57bc86a1@mail.gmail.com>
X-Google-Sender-Auth: bf97f2735351a37c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145961>

I don't know if anyone is interested:

I've did the fast-export | import with marks for all release branches
of upstart.
So I have git repo with code since 0.1 series upto the latest 1.0 series.
I've also committed an update branch which has script to import new revisions.
I might put it into my crontab for updates.... but small bash script
is there to update it.

So far it looks good to me e.g. there is nothing missing what is
present in the upstream branches.

git clone git://gitorious.org/upstart/upstart.git

Happy rebasing ;-)
