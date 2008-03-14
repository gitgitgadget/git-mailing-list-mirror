From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: About detached heads
Date: Sat, 15 Mar 2008 10:13:00 +1030
Message-ID: <93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	 <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
	 <20080314183731.GA2994@atjola.homenet>
	 <alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
	 <m34pb9xgrp.fsf@localhost.localdomain>
	 <BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 00:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaJYx-0003Ek-BI
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 00:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYCNXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbYCNXnF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 19:43:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:3363 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbYCNXnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 19:43:04 -0400
Received: by fg-out-1718.google.com with SMTP id l27so400659fgb.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bNS3+T3jK8q3fMeNFl0ZKsHNBHvcXidXi8YE0aa11m0=;
        b=wvjLHLQzGrKDgsTa0wzBv7tQtqGCmXsZ7Jp3fjvaGoAYDW5ymBntg9QdMRoDNrGMPslkM3WhcRTfvMlslEzQJT6F5pP0E6O8deweEZWasnha7HCFie0JyatHVCh5CEuNfKjHuieLYvdADTwRMPNm6gZdW3Ld8MytsvuX5mxVoBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JcoCLMljUNIqMNR0uq24o0WW92ucnE6/L3BOgTPyO7rkt0UU5trKGS9P7LHI21Dbo8EBIZZZ6TTHblR1IY1sxq+oWwI1KqdgLQjwYT9/7cssaaREEEv4eNN9e2Hsars75eyufdIc8jVlEsUrSUtu2cfynXtvl1b0UVilpRExMd0=
Received: by 10.82.146.10 with SMTP id t10mr28081193bud.6.1205538180582;
        Fri, 14 Mar 2008 16:43:00 -0700 (PDT)
Received: by 10.82.114.1 with HTTP; Fri, 14 Mar 2008 16:43:00 -0700 (PDT)
In-Reply-To: <BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77295>

I thought my question was trivial, but judging by the number of answers, clearly
not!

I understand "git read-tree -u -m 3 ; git commit" and it does exactly
what I want.

The context where I want to use this is for users who update files,
can understand
"take me back to the state I was in at 4pm yesterday before I mucked up
my data" but who don't want to know about merging, branching, topics, etc, etc,
But of course having taken them back to the 4pm commit, they then realise that
they really need the 6pm commit or perhaps the 3pm commit. So anything which
just throws away commits would be risky.

The "git read-tree -u -m 3; git commit" allows me to present a simple
straight line
view of the data, which is perfect for the people I'm dealing with.

Many thanks to you all,

Cheers,
Geoff Russell
