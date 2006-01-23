From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Mon, 23 Jan 2006 14:07:18 +0100
Message-ID: <81b0412b0601230507n34311c14l5f1c14528f90ec14@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <7voe277lbe.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com>
	 <7vzmlqaf5o.fsf@assigned-by-dhcp.cox.net>
	 <20060120215314.GA4203@steel.home>
	 <7vpsmmt32x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 14:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F11Po-00060U-8K
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 14:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAWNHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 08:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAWNHV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 08:07:21 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:15505 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932186AbWAWNHU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 08:07:20 -0500
Received: by uproxy.gmail.com with SMTP id s2so744787uge
        for <git@vger.kernel.org>; Mon, 23 Jan 2006 05:07:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZoRBcBpRBp9Y1W2pVdYhSf+1Oog5xLvUYhwsIdCfTWJFHA7vrzPJ7eJvupVBaP8fQHaiGvgcyCOqiF92tf1eyznWO7Po4ni9CTla1C7WVE4oqhtsMWsfFcg9CAYIKTccKq2pwcQLUz3yJFqAKpjtCq0rCJ6ITNjv0oG98pZQo6c=
Received: by 10.48.43.4 with SMTP id q4mr330074nfq;
        Mon, 23 Jan 2006 05:07:18 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Mon, 23 Jan 2006 05:07:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsmmt32x.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15084>

On 1/21/06, Junio C Hamano <junkio@cox.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> >> +#undef DT_UNKNOWN
> >> +#undef DT_DIR
> >> +#undef DT_REG
> >> +#undef DT_LNK
> >
> > yes, of course
>
> That is technically correct but I suspect it would not matter in
> practice.  The only thing you are avoiding is four compiler
> warnings when compiling for Cygwin of this week (I heard this is
> already fixed in Cygwin CVS).  On older Cygwin you simply would
> not use NO_D_TYPE_IN_DIRENT, since d_type worked before.  No?

Yes :)
