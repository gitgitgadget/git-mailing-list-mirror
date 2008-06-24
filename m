From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Wed, 25 Jun 2008 00:48:40 +0200
Message-ID: <486179C8.2000704@gmail.com>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHKY-0007sy-5J
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYFXWsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYFXWsr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:48:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52418 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYFXWsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:48:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1270253fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=o5/ZHWaR27aDle/uVTpS5f76y50/FGl7AgRZUEtIJIY=;
        b=Qifu/lCGN/Vl7RcxkcVJ8UcVSzula2gYJzc1lE0ewr0FMMsWsdl1QtW2cX1UhOzzge
         T/Ox/O2aeBvcq2vWqwVgUMzCOSVB70pLez2OpEG6ydTnpgrwhSCi/8ZGr5bHTsb1M31J
         /oQxznPxTz0uQXfo2DXbIRXt0ZRhk1ENTffU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=g7ukudRCLZsk+Uvg1K4Px3vaWiU0zhw5/rFe2Ra+ZWKK/0kLJ9zxBXpji3CNuykeMJ
         wpD8sqrwJHn+A1NKS4tL6QZtAJ8CEARCOTYAmAnLJeyuWnTegntHwhm+yoUkWU+jz8jT
         bw8UoA/6ZOddumKkiVGzp1kXOFuKExV9N3a9g=
Received: by 10.86.98.10 with SMTP id v10mr9442278fgb.46.1214347722265;
        Tue, 24 Jun 2008 15:48:42 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.195.174])
        by mx.google.com with ESMTPS id 4sm11773746fgg.9.2008.06.24.15.48.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 15:48:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <486153DB.3070502@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86166>

Michael Haggerty wrote:
> Therefore it should be easy to teach git-bisect to locate either kind of
> transition, "bad" -> "good" or "good" -> "bad", depending only on where
> the user places the original "good" and "bad" tags.

I think this is a good suggestion (though I haven't thought things 
through).  Another idea is to add "old" and "new" (or something like 
that) as aliases to "good" and "bad", since that's the only semantics 
that the bisect labels actually seem to have.

-- Lea
