From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:44:45 +0200
Message-ID: <81b0412b0808280744q7ab0aa9l2064117c4e147351@mail.gmail.com>
References: <20080826164526.GM26610@one.firstfloor.org>
	 <20080826171255.GI26523@spearce.org>
	 <20080826171623.GE5318@coredump.intra.peff.net>
	 <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com>
	 <20080827202707.GA25233@coredump.intra.peff.net>
	 <48B5BB35.8090606@pobox.com>
	 <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org>
	 <48B5E822.1020901@pobox.com> <20080828065124.GB16186@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Kristian H??gsberg" <krh@redhat.com>,
	"Matthias Kestenholz" <mk@spinlock.ch>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org, "Jeff King" <peff@peff.net>,
	"Andi Kleen" <andi@firstfloor.org>, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"David Woodhouse" <dwmw2@infradead.org>,
	"Willy Tarreau" <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiky-0006DQ-3N
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbYH1Oor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbYH1Oor
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:44:47 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:51097 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbYH1Oor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:44:47 -0400
Received: by yx-out-2324.google.com with SMTP id 8so223809yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/3+H9pFyVBhnV4A8OLQzQmCG8nyREi/jDW9L3mMg8xI=;
        b=CFcxFX/YX69J7HgAxUyfk1/oZIUsL6JW5nPBjbovOuvC7uQnmk0nlATluT9NBrafGJ
         DIdjpFUc97JCliky76ao6Q9ifT5ZKVYEUYoWAfDrJRLXN3mrxKd8Rmwny+ao6Vye/WhD
         47QRyQIDzBzseX/d8vNdV9uD9ho8n0cN99wUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZTjbCpqsk5nYUjfJtV5J/GBC3sy4qxYBB8iRYi9dfDMyLoihQEV9CXVItfkfOf8cnY
         nHPvWliHaB2Xa9+ItCIn4qpY5va3C9+WEM09hEpwJgn3DEMoIxV9DE3OWgZix5oDNIVD
         jJi0OZFWamsyHK0UGnN3lIQHmr8m8gn2FyNZ0=
Received: by 10.114.184.7 with SMTP id h7mr1443951waf.9.1219934685591;
        Thu, 28 Aug 2008 07:44:45 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 07:44:45 -0700 (PDT)
In-Reply-To: <20080828065124.GB16186@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94063>

2008/8/28 Ingo Molnar <mingo@elte.hu>:
> * Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>> 'git show' is quite sufficient, as long as I can pipe its output into
>> patch(1) or write it to a foo.patch file, which appears to be the
>> case.
>
> the only time git show is not sufficient for me in practice, the
> following one is:
>
>  git log --pretty=email -p -1
>

"git show --pretty=email", indeed 8-)

> that's when i want to do precise import/export of patches from/to email.
> (but it's rare)

But it does not export them "precisely". You get no patch for
merges (even if there were changes). Try using "git format-patch
--stdout" (or with "-o <directory>" instead of "--stdout", to split in
patches).
