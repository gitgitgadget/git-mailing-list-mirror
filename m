From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sun, 13 Sep 2009 02:43:35 +0400
Message-ID: <20090912224335.GC30385@dpotapov.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <20090912103156.GA30385@dpotapov.dyndns.org> <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com> <20090912214428.GB30385@dpotapov.dyndns.org> <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbOo-0006Q1-Sx
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZILWsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 18:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbZILWso
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:48:44 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40220 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbZILWso (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 18:48:44 -0400
Received: by fxm17 with SMTP id 17so176064fxm.37
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1vPpF2Ny9UDXPBHHmhtU5FYuQJNFT891EbdyqkzKrs4=;
        b=TxJvzOv5s1RXq8WT1Xwh4lhu5dihuDPkB8fAu0E1aDTUHvuLo6M3x84lWICJPtLOsF
         whFty7Ia1KHacdkQHGB4ODA11ZHn4YWAn/JFKo3iSv7m3Uwr3nmmiVXI0FsG6gIRN+Tz
         cauB4kAcFF2lXOf9TXZM6GzVYzSRh0+pCoo6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IfXIIEjrkqxNiw+1SBAHZoejDnfMVqY+/Qa4sx0468427KcunW2r0lreyiKJHEFBtr
         QANuwJHJJlFFM6dUz8n0X9kBpK+h9sgIbMDg4XeagQko6IWOntZQrPSKvM7FgYpwJTaG
         CCaW0cMDENFvutF90iss5VC2f4dTedZhOEgIE=
Received: by 10.86.251.40 with SMTP id y40mr3509476fgh.57.1252795726840;
        Sat, 12 Sep 2009 15:48:46 -0700 (PDT)
Received: from localhost (ppp91-77-226-194.pppoe.mtu-net.ru [91.77.226.194])
        by mx.google.com with ESMTPS id 4sm2956633fgg.12.2009.09.12.15.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 15:48:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128310>

On Sun, Sep 13, 2009 at 01:21:43AM +0300, John Tapsell wrote:
> 
> Because I wouldn't call this just a few keystrokes to do the common case:
> 
>     git archive --format=tar --prefix=HEAD/ HEAD | gzip > head.tar.gz
> 
> I honestly don't understand the backlash against Brenden's point that
> this could be made a bit simpler.

You do not have to specify '--format=tar', because it is default. The
prefix name is a matter of one's preferences. Brenden wanted it to be
$myproject, while I have used three different versions. Now, you suggest
some other. IMHO, having it empty by default makes much more sense when
there is no obvious value on what most would agree. Finally, 'HEAD' is
required, because we do not want 'git archive' being run without any
parameter to write a binary file to the terminal. (Yes, it is foolish to
run command that you do not know to see what it does, but some people do
that, and we want all commands to be safe). BTW, I wonder whether use of
HEAD is really common with git-archive. Normally, you would archive a
tagged release, and then it is better to use the tag name to be sure
that you have archived the right thing.


Dmitry
