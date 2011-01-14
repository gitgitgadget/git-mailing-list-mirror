From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 17:26:39 +0100
Message-ID: <AANLkTimkROu7W1DDueiaBRgCQuhT=7-vH5n1km65gpq4@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com> <4D3077FE.9090407@spacetec.no>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	JT Olds <jtolds@xnet5.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jan 14 17:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdmUl-0004Bg-9R
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 17:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab1ANQ1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 11:27:19 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62610 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757650Ab1ANQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 11:27:17 -0500
Received: by bwz15 with SMTP id 15so2673774bwz.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=OdsTlmV36PZSoL7TXSlNSc9uqkqIMOQ7TMRI5Y0zVwI=;
        b=Efl71vxPy2kH7riTIRR6rvQueszEgaghppfBqjdaQcr7d3lz1znLnhgTC0+mPGojxV
         wueDt1l0p838w+ObpdtnEdqnObndWHnsFpyih5kVMpRBzWbDPQKSRnU9d597qjORn7P9
         tv4y7R45gkj50auA5iwDyRXKXNmHZc6BV3udI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=SDn3xL0JGIRKNVgro91mJe/bxF1pWnOMJsllRejQxoSgY5Q0zsiyANwAUCFZ30qGBk
         1UY3jYj/Hf9sKYFRhWM+/GWfL4zewO+wUVIQKWiCFgMvbffAuyHSk9w9dr8EPMdAec+G
         XV+TABKFAUjfobWp1FUH2lfdE+I9fr+YEauxc=
Received: by 10.223.96.68 with SMTP id g4mr947389fan.33.1295022419850; Fri, 14
 Jan 2011 08:26:59 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 14 Jan 2011 08:26:39 -0800 (PST)
In-Reply-To: <4D3077FE.9090407@spacetec.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165110>

On Fri, Jan 14, 2011 at 5:21 PM, Tor Arntsen <tor@spacetec.no> wrote:
> On 14/01/2011 17:13, Erik Faye-Lund wrote:
>
>> I think Tor pointed out that he knew a swede with his full legal name
>> to be only one letter long. I would suppose that meant that he didn't
>> have a surename?
>
> Exactly. He didn't. Bank printouts etc. would only have that single
> letter, he didn't use a nickname - that letter was his legal name.
>

Perhaps he could have spelled it out like he usually have to do:
"The artist formerly known as Prince" ;)
