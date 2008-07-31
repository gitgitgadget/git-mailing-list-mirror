From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Fri, 1 Aug 2008 00:10:31 +0200
Message-ID: <bd6139dc0807311510j38d7064dufbf5ded4ad49cddb@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
	 <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
	 <20080731215818.GD24631@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: cte <cestreich@gmail.com>, "Dmitry Potapov" <dpotapov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgMw-0001kZ-8y
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbYGaWKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbYGaWKd
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:10:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:57432 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbYGaWKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:10:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1008287wfd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iyhsoptLm14bHzJYNBEAhAVbjCPfazj2iSpXOjPrWEM=;
        b=IGAjqcpzb3hkPZECj4NVb2HxFFS95CULbKU0nKwP+73g1OuTC4Eok7dkPVNVYI0J23
         tpjt0q2HG5EBn3vc1MUp2Srby+LTYT5JjKk6R7DIWynSj2jUshFvjHT5xyb2W0PDDA13
         tucimDvZHbqsYOx1pREafHzFqAYo92RTDabf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=c+CalA5uAFdUohr+2imJgYRgy3Blj4XihDRCODasfuGVWxqMA3jdk0iMirPk3V/f4X
         KOdEzxNYYRnEvxySiuJ3BOYUZhonPT/qZ57uRSv+46VpWruwxGYEVgWTvwhyrqvJXQw1
         B/md1pfKn+AkgkB0njg4Cphop2swSiJY0Y074=
Received: by 10.143.168.4 with SMTP id v4mr3459607wfo.39.1217542231961;
        Thu, 31 Jul 2008 15:10:31 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Thu, 31 Jul 2008 15:10:31 -0700 (PDT)
In-Reply-To: <20080731215818.GD24631@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91006>

On Thu, Jul 31, 2008 at 23:58, Shawn O. Pearce <spearce@spearce.org> wrote:
> And actually if you try to use topo-order internally in C you still
> have to wait for the post-processing.....

Aye, that's what I was reffering to, thanks for clarifying :).

>> Especially since that'd mean that integrating it into other languages
>> (by means of wrappers), such as Python or Ruby, becomes a lot easier.
>
> I'm going to be shot for saying this, but both Python and Ruby
> have implementations that run on the JVM.  So does Git.  Want
> to use Git and Python?  Use JGit and Jython.  :)

Heheh, nice plug :P, but thanks but no thanks. I'd rather have
something more native than "JGit + Jython", two levels of 'emulation'
can't be good!

> Too many people have scripts based upon plumbing to make incompatible
> changes.....

Exactly! :)

-- 
Cheers,

Sverre Rabbelier
