From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for
 vim/gvim
Date: Fri, 24 Sep 2010 20:17:47 -0700
Message-ID: <20100925031745.GB30550@gmail.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
 <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
 <20100918073428.GA9850@gmail.com>
 <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
 <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
 <20100924190928.GC3768@vfa-6z.perlninja.com>
 <20100924213852.GB19676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Dan McGee <dpmcgee@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 25 05:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzL8d-0000Pi-Tq
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 05:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab0IYDJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 23:09:08 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49704 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0IYDJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 23:09:06 -0400
Received: by pvg2 with SMTP id 2so827936pvg.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CnSHY2PzUO5rSxp8oj2Ln084ptnOr6RsNmODM6Aqxw8=;
        b=sZ9bN9ScJieq5JvrtwISoc1lrWCRND742Z2EcRKm5sJRdpza+AdPjjh8aLwDIjQu4W
         Mv5cxUQOd5uV67FDokQUE6JFsq52wJbs/K2QVUvvO14VV0Soj+mdocPfEA1QkmGpQyku
         a2UAVSPSH9lFaz27Sm41XmkqgSxbMbJ2SguRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RLGFQz7jwjFhE+JMilT3/Fu2+GNCc4lCjXQxHbPFCgI+UuPJOOXx/DIscZLJWwaaj3
         2qdz11TW90loXVW9X9s/U2nePFqfFMBdAZzGZEnt9fXpiovB5Qih2OBZU7jgxWAqWCIm
         ET6p18twIkpc+fsqxI58EPKz11LCshz3r062I=
Received: by 10.114.136.19 with SMTP id j19mr4511214wad.170.1285384146166;
        Fri, 24 Sep 2010 20:09:06 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 33sm4755833wad.6.2010.09.24.20.09.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 20:09:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924213852.GB19676@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157110>

On Fri, Sep 24, 2010 at 05:38:52PM -0400, Jeff King wrote:
> On Fri, Sep 24, 2010 at 12:09:28PM -0700, Jacob Helwig wrote:
> 
> > > So are these patches good to go forward with? No major objections in a
> > > over a week's time.
> > > 
> > > -Dan
> > 
> > I'd +1 David's suggestion of calling this "vimdiff3", I'd like to still
> > be able to access the current behavior, since I have merge.conflictstyle
> > = diff3, and already see the merge base when I use (g)vimdiff with
> > mergetool.
> 
> Of course as soon as I say "nobody objected" in my other email, this
> arrives. :)
> 
> Can we provide both, but make the vimdiff3 behavior the preferred
> default? It better matches the default merge.conflictstyle, and people
> who are using diff3 obviously understand how to tweak config.
> 
> -Peff

+1 to Peff's suggestion.

Dan, can you reroll the patch so that the new behavior is
"(g)vimdiff" and the old behavior is available as
"(g)vimdiff2"?

I do slightly dislike having both from the maintenance POV.
But, it's better to keep it around than to rip it away from
happy users' hands.  Thanks for speaking up Jacob.


Cheers,
-- 

		David
