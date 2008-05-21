From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Wed, 21 May 2008 15:07:44 +0100
Message-ID: <b0943d9e0805210707s5af76462wc92a4cf55e5d4a9d@mail.gmail.com>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
	 <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com>
	 <20080520070441.GB7324@diana.vm.bytemark.co.uk>
	 <b0943d9e0805201019x10bf87ecr1c11c8ee474f6138@mail.gmail.com>
	 <20080520210249.GA19465@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 21 16:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyozj-0004YQ-Qr
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934328AbYEUOHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 10:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbYEUOHs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:07:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:23557 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765459AbYEUOHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 10:07:47 -0400
Received: by ug-out-1314.google.com with SMTP id h2so157006ugf.16
        for <git@vger.kernel.org>; Wed, 21 May 2008 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6aCCraWXwCoz7xcpvwYhjuGiKnEssk14rLYSRtmaKFU=;
        b=Ybf/mgU3PceDXd6Stf7J3n3eSvfMpEMldr3p0bu05wYD7otMNuPq9ZTGDbpP9T0fInKqBCPQ1ch7+lbsKUBfe74ZjGAgYI2CwQDnBsEteq+JYJJSOU/qxWlRq0jznDhHGr1ig+AEXVEsEUlIg8yCdVoXNqhG8+FGxAmahmb7fMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZtNu6axoX8JLonb5Ixkj59sP/04aZBoWdoh+Hv7YxAZfAQ6ciEOtXamMXZHFuySL+oUwgAYmSVGDhVAPrfF1N7yHQBRSeZcRw1OyGBFBN9C30hGnMuE7+lGRX1VVXneXGo2VlbL6pkyE1LMYR0Xrv9MsvuLHBcrsb1OObEGxis=
Received: by 10.66.251.3 with SMTP id y3mr1066817ugh.88.1211378865061;
        Wed, 21 May 2008 07:07:45 -0700 (PDT)
Received: by 10.66.242.4 with HTTP; Wed, 21 May 2008 07:07:44 -0700 (PDT)
In-Reply-To: <20080520210249.GA19465@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82543>

2008/5/20 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-05-20 18:19:02 +0100, Catalin Marinas wrote:
>> I build release tarball from the directory under Git control and I
>> always get a builtin_version.py generated. In my initial patch I had
>> a check in setup.py for a .release file. I could add a check in
>> write_builtin_version to ignore the extra .git stuff if I am making
>> a release (only keep the tag name).
>
> Nah, easier to just change the order of the checks (try r2 before r1)
> as I outlined. I'll whip up a patch.
[...]
> If you're exactly on a tagged commit, git-describe will return just
> the name of that tag, so you don't need to do anything extra.

Now that you mentioned this (I didn't know), is there a need to
reverse steps r2 and r1? I always build the release from the current
tag and the version should be clean.

>> BTW, Git seems to use 6 characters for the current commit id and
>> StGIT 5. Should we change this for consistency?
>
> Both git and we call git-describe with --abbrev=3D4, which I think me=
ans
> "describe the commit uniquely with as few digits as possible, but no
> less than four". So we'll get upgraded automatically when it becomes
> necessary.

OK, I didn't know this either.

--=20
Catalin
