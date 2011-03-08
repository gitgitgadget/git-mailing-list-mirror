From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH jk/strbuf-vaddf] compat: fall back on __va_copy if
 available
Date: Tue, 8 Mar 2011 14:59:19 -0600
Message-ID: <20110308205918.GC26471@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142647.GA15477@sigill.intra.peff.net>
 <AANLkTin7NBx5NVRkHpgymcZfnaZaJehMMpPv=zD+cKtV@mail.gmail.com>
 <20110308083344.GD26516@elie>
 <7v62rte5nb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px40B-0004km-FM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab1CHU70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:59:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab1CHU7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:59:25 -0500
Received: by wwa36 with SMTP id 36so1628061wwa.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 12:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v04fdmJpMMGnUNHQaCxzL0BLLEgkG9SN5jiHCigWUWw=;
        b=tikAAkCCQ7slThfjADm47LztVU8EQg3wtLUio/AW69UmxgeKrXzKYiLqPadHFDmXt4
         lbbYpauGY1nskqe9IGispzfFZeO/72M9BriVIzxjzYzulyaXo7LKrarzomk5UGPx5B6t
         N2BpWSXEgfjYRvJO7uovnXLim64QHTcJ8NieQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GBXQNflE2fVmkNSAyTZrL0AHaWJ3VTyc9lbw6GMOhWMgVxOTBiTx9sO1K3lrCrD7d6
         sJbTO4Q/IDwBwsVyfgN84ZYL+tXRNJvy8+Sm/mES5Wjm2zPeiqkdzcXddk0p0Rlmkkk0
         96GOf+P/ZDpn7q6s6cwxHNFosmhUNCDnu/+2w=
Received: by 10.227.39.89 with SMTP id f25mr4908125wbe.154.1299617964257;
        Tue, 08 Mar 2011 12:59:24 -0800 (PST)
Received: from elie ([69.209.61.99])
        by mx.google.com with ESMTPS id u9sm867020wbg.0.2011.03.08.12.59.22
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 12:59:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62rte5nb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168691>

Junio C Hamano wrote:

> This is a tangent but when you quote from compiler output could you be in
> C locale so that it would be easier for everybody to get the same result?

Sure, that makes sense.

[...]
> Thanks, the patch looks good.

Thanks for looking it over.
