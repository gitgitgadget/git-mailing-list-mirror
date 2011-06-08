From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 8 Jun 2011 19:50:03 +0200
Message-ID: <201106081950.04910.jnareb@gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net> <20110608173012.GA4279@sigill.intra.peff.net> <vpqlixcns6m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMte-0004Py-F1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1FHRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:50:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56191 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1FHRuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:50:13 -0400
Received: by bwz15 with SMTP id 15so635101bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ePBNV6s+x5EJl6uSuZEOKLPkBCLnLhnSxvzGHy75z8Y=;
        b=IvEdGT1LrBczhjGkYYIs16NVAOCbl0AuVkctxvha2k2mcHjlbm3A0drzCydIqDA42f
         WFm+JPdZkrJa2TR7TtMVnPQEDv4LPACh7rr394zNA5uvKXFcuMQm3sal+VUEZZWUImhT
         /vRCo4j12D9qoSHYU0kpXk50BaBhH+icSlO7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vhvLgn+O0yrLJ3Nz4qo6S6sprH0RVO2qnICYPji42m//LrCNglDR5lqubfWs065xec
         vIOgNiptwesw9qqWiHfUKd4tKqTTok7mEZyJ5Scxe2gmYWvvcdGreChxkDmPA4IoB0ZN
         BQFdPEVVzihC1q/3PnYt8LBy+v223Nw3qHnd8=
Received: by 10.204.74.218 with SMTP id v26mr847607bkj.76.1307555412458;
        Wed, 08 Jun 2011 10:50:12 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id t23sm776511bkf.16.2011.06.08.10.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:50:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqlixcns6m.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175413>

Matthieu Moy wrote:
> Jeff King <peff@peff.net> writes:
> > On Wed, Jun 08, 2011 at 07:28:35PM +0200, Matthieu Moy wrote:
> >> > Jeff King <peff@peff.net> writes:
> >> >
> >> > * @{wtree} would confuse users that it has something to do with reflog
> >> 
> >> Well, we already have @{upstream} ...
> >
> > Yes, but like all of the @{} things, it's a modifier for the left-hand
> > side. So "master@{upstream}" is meaningful, and "@{upstream}" is the
> > same as "HEAD@{upstream}".
> >
> > What does "master@{wtree}" mean?
> 
> Nothing, but then we already have @{-1} ;-).

That's actually HEAD reflog.

-- 
Jakub Narebski
Poland
