From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make install error
Date: Thu, 28 Jan 2010 11:27:29 +0100
Message-ID: <81b0412b1001280227q6ab45a52i8df56ef4cfb4219c@mail.gmail.com>
References: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
	 <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
	 <81b0412b1001280048y6f91ad25t5c636f959630825@mail.gmail.com>
	 <7vockemwu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kap4lin <kap4lin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:27:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRb7-0008RM-73
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0A1K1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 05:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791Ab0A1K1c
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:27:32 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37841 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0A1K1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 05:27:31 -0500
Received: by bwz19 with SMTP id 19so402639bwz.28
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 02:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Zln89wB1Mp77lUBHbiASRJIKgHDZ9Fs+TKeREWTivsM=;
        b=JvrzWBtT21lS+1s+C1W9jyUgY24dZBcA7TpATNvbAmm1/mp6jWHUHzBgq7sfN0C2MJ
         60hsDhd1ZCTXwMAfDZk56Zb+D55jZnnt92QFWmEYaxTyqIXCs5nhX3RXUA3I9QWeUYwr
         ouVX+Issd/Yo4jRaOaeVpz/gAB2bAPVI2JoX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KIsqmNKve3vQdRefSQqFnHcl3uQMIrV9WPdScQgLPXHRN8P/zM7RN1srcYkKdsZAUQ
         cwq7OpL6l4ebmFmZtG6uRiRtvUYUsuKYpxdDl81lypV1mTmdTe0BDRngGEOH957yf7uz
         g4FTwHg1R/0BEG83rj6KfKd3d96Jcbg6j/oms=
Received: by 10.204.26.148 with SMTP id e20mr3496388bkc.25.1264674449370; Thu, 
	28 Jan 2010 02:27:29 -0800 (PST)
In-Reply-To: <7vockemwu3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138243>

On Thu, Jan 28, 2010 at 09:56, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>> BTW, will "cd ./blt &>/dev/null" also help and prevent this problem from
>> happening ever again?
>
> Except that (1) it would be ">/dev/null", and (2) why contaminate Makefile
> command lines with such unreadability to work around stupid misdesign of
> CDPATH?

Eh... Right :)
