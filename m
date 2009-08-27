From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 22:24:34 +0000
Message-ID: <32541b130908271524o163809alc2f6926d110667b3@mail.gmail.com>
References: <1251387045053-3527289.post@n2.nabble.com> <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com> 
	<20090827164657.GA17090@atjola.homenet> <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com> 
	<20090827204835.GC4399@coredump.intra.peff.net> <20090827213426.GD4399@coredump.intra.peff.net> 
	<7v7hwpors9.fsf@alter.siamese.dyndns.org> <20090827215007.GA6231@coredump.intra.peff.net> 
	<32541b130908271512h255834adl5a606054f6ab20e4@mail.gmail.com> 
	<20090827221631.GA7058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:25:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnP0-0007uc-SY
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZH0WYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbZH0WYx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:24:53 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:56698 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZH0WYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 18:24:53 -0400
Received: by ywh14 with SMTP id 14so2043382ywh.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RpHl3Pg24xpoF4gID2lKH8hRH2M4gfEzm/Hoo1dY+o4=;
        b=hyua4TmxRcNTA9ta6Z27unTf4QhoW2sNzWtH6NrcoHAwhrxB21BrGFfUmVctxzgAOM
         op7yEjfXaVgKqxVXTZjZX98a1PcJ2OO/s4ZwsQbDWiEc/dHLfPAv9AAHAF99Rvzq+yqK
         3wXTRmMIs3DBKHn+y5zqmek7kaxgHadydZyzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AeF/nyqH3ywIa0QtpUIeJLDqGWiibWRo3JrCcalFNJAibOWx8z7uiqVh453tvTBKSj
         nh1R5e3VkXx+icfw3Von8i2kYnNFjVcNiHeQLq6jNlPqZ14NFsod2yjNXpH1Biiwspxn
         tNPMF/3vus3St3GuQ5+lUOqwRyPeD24jfLhuA=
Received: by 10.150.31.11 with SMTP id e11mr695176ybe.314.1251411894064; Thu, 
	27 Aug 2009 15:24:54 -0700 (PDT)
In-Reply-To: <20090827221631.GA7058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127228>

On Thu, Aug 27, 2009 at 10:16 PM, Jeff King<peff@peff.net> wrote:
> On Thu, Aug 27, 2009 at 10:12:50PM +0000, Avery Pennarun wrote:
>> After all, if I *really* care about the prior state of the remote, I
>> can just make it a remote branch. =A0And if (as often happens) I jus=
t
>
> Do you mean "local branch" here?

Yes.

>> want to know what's new in that ref since last time I merged, it's
>> simply
>>
>> =A0 =A0git log master..origin/master
>>
>> This works even if master has extra commits vs. origin/master, since
>> the double-dot invokes git-merge-base.
>
> Well, ".." doesn't use git-merge-base. But yes, I actually do this,
> except I do:
>
> =A0gitk master...origin/master

Sorry, not my day for accuracy, it seems.  I use both, and I should
have remembered that the triple-dot is the one that worries about the
merge-base.

Have fun,

Avery
