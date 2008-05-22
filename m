From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t3701 if core.filemode disabled
Date: Thu, 22 May 2008 23:22:48 +0200
Message-ID: <81b0412b0805221422m734f019emc7a60bb5d44d7369@mail.gmail.com>
References: <20080518152337.GB3058@steel.home>
	 <20080518190839.GC15506@sigill.intra.peff.net>
	 <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home>
	 <20080519205550.GA24246@sigill.intra.peff.net>
	 <20080520215932.GB10437@steel.home>
	 <20080521143607.GA3575@sigill.intra.peff.net>
	 <20080522132042.GF3206@steel.home>
	 <7vzlqiut4a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 23:24:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzIGl-0000z1-3O
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 23:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbYEVVWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935231AbYEVVWw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 17:22:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:32904 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759459AbYEVVWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 17:22:50 -0400
Received: by fk-out-0910.google.com with SMTP id 18so277541fkq.5
        for <git@vger.kernel.org>; Thu, 22 May 2008 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2356xt8IPT7h0mZWPJclOdnuKspJbUU3F78I2RtAty0=;
        b=LNEdDlxGioplgeBLofN2rajAB+kUs0bX5UxjVE1D6wOon24AY0u9vplC0GdSQl/UF6+l/rtGmHT4IrAjaen5fqq04Z0WzBNx8Vs0mIIwW+2dDnFC6i6UuKCMpY65UiEe6Jf6FYHEy2h4QLNuYuvcwqqF9iShHkwPAPLFDLYJauQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aJOEfyDjdog1qWXbulzhVgjYM5etZnef8c4h2CU7rLzeu7lxYX9vl3sSESwFK1O894gDC0BsxR62IKUyiACItbXX4y/oufW7g5ZIDodtlYI6BDHSXbh/joR94qhCDjPhqwr2zkj52+cXCGzBM733cRnYmr63FFNr12gRTCo6ub4=
Received: by 10.78.170.6 with SMTP id s6mr282452hue.75.1211491368405;
        Thu, 22 May 2008 14:22:48 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Thu, 22 May 2008 14:22:48 -0700 (PDT)
In-Reply-To: <7vzlqiut4a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82655>

2008/5/22 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> Jeff King, Wed, May 21, 2008 16:36:07 +0200:
>>>
>>>   $test_filemode test_expect_success ...
>>>
>>>   But maybe that is just overengineering.
>>
>> But a nice one. I like the idea but Junio already did your other
>> suggestions in master, so I just keep it in mind for the next one
>
> If you like that, I think you would like the way t0050 does even better
> ;-).  It is Steffen Prohaska's invention, IIRC.
>

I do :)
