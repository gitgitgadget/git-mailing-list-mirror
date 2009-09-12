From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sun, 13 Sep 2009 02:08:50 +0300
Message-ID: <43d8ce650909121608t2b9c4b9bw44104acceea26e12@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
	 <20090912103156.GA30385@dpotapov.dyndns.org>
	 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
	 <20090912214428.GB30385@dpotapov.dyndns.org>
	 <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
	 <20090912224335.GC30385@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 01:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbiF-0001tI-2o
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 01:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbZILXIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZILXIt
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 19:08:49 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:65027 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZILXIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 19:08:46 -0400
Received: by ywh4 with SMTP id 4so2872961ywh.5
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K+WYZ48y++OxpeLE+ubfuYdw9LT0Lcc7t1OeZQEEtOU=;
        b=NfTE9+9/uwRlaQbjNoTO0KAfDCAv/ochZL5cbDAqqdQX9ApydCS/OH6zhlBlrrZ8AC
         91UWMWzxHmrA9XkCw07xTLzhYjhbqwPcgIaH8Yva8Ooxf+AyRhWH/7B5KEDxRQE9JNdM
         uyupFS5B+x3Vjp3n29WqcpHnxJLS9CgckBvqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e0zwbc5VRb+tu5TTZKdKg9Oi+/r6ZoIyzcdmvbD4kzSIElNGSANIIt53uVAvOBUHEC
         TJfyD7BgBHlwKwfYG/AVe5PsZVUFMMnFbKbck9/2DIl79BPQVkfaEAtOJGUr8u6DK/SF
         Fea56wWJQFId704IJ6wPCganMcwMMs5V6vTrA=
Received: by 10.150.61.3 with SMTP id j3mr7400627yba.76.1252796930075; Sat, 12 
	Sep 2009 16:08:50 -0700 (PDT)
In-Reply-To: <20090912224335.GC30385@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128313>

2009/9/13 Dmitry Potapov <dpotapov@gmail.com>:
> On Sun, Sep 13, 2009 at 01:21:43AM +0300, John Tapsell wrote:
>>
>> Because I wouldn't call this just a few keystrokes to do the common =
case:
>>
>> =C2=A0 =C2=A0 git archive --format=3Dtar --prefix=3DHEAD/ HEAD | gzi=
p > head.tar.gz
>>
>> I honestly don't understand the backlash against Brenden's point tha=
t
>> this could be made a bit simpler.
>
> You do not have to specify '--format=3Dtar', because it is default. T=
he
> prefix name is a matter of one's preferences. Brenden wanted it to be
> $myproject, while I have used three different versions. Now, you sugg=
est
> some other. IMHO, having it empty by default makes much more sense wh=
en
> there is no obvious value on what most would agree. Finally, 'HEAD' i=
s
> required, because we do not want 'git archive' being run without any
> parameter to write a binary file to the terminal. (Yes, it is foolish=
 to
> run command that you do not know to see what it does, but some people=
 do
> that, and we want all commands to be safe). BTW, I wonder whether use=
 of
> HEAD is really common with git-archive. Normally, you would archive a
> tagged release, and then it is better to use the tag name to be sure
> that you have archived the right thing.

Ah, the manpage examples specifically give the --format=3Dtar though.

Why not have  --format=3Dtgz  then or something?  Or better yet, give
the filename on the command line and detect the format from the file
extension.
