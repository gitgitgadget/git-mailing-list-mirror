From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 8 Jun 2011 20:57:47 +0200
Message-ID: <201106082057.48139.jnareb@gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net> <201106081950.04910.jnareb@gmail.com> <vpq62ogkxs0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:58:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNx3-0003az-Ba
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab1FHS55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:57:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56062 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab1FHS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:57:56 -0400
Received: by fxm17 with SMTP id 17so524743fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=VXeBtUB7anttZ0m/9p6cT3oHjVdRdYwpNV7tnnCtStQ=;
        b=qVDmlf0WzjQ0BjMuCnDvgDylnUm4bHl4WMncdmITrLT78ocI+wVGzZ0YGrJBNTRzhn
         V075KPcuXYnBP+4ezFfUpGtEpq9EHOLtZ2ePT/rH/jYyGa3mZsPc89tFC2xDjftfipGY
         Pqtq7wuZWWN2WFDRL4pqVpnWNyusnuH2bkH7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ntuD/2OufK0H/GLbFTtJeBijpGbbnXVkmobg9CgPXjWc2Jp6DKq9jGDrZMturnEa6x
         6iTuPZ8PISwzRRV6AEVDHDRV9M8/0r8mKq2CFC9qqJws0SWyrr88p+WtHB3WKqMDHnsk
         UKj4uqDU0bS2K2eXgg+A0NK3JtqTJnBcCre58=
Received: by 10.223.55.200 with SMTP id v8mr588745fag.82.1307559473889;
        Wed, 08 Jun 2011 11:57:53 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl. [83.8.212.166])
        by mx.google.com with ESMTPS id a28sm1190111fak.3.2011.06.08.11.57.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:57:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpq62ogkxs0.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175444>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Matthieu Moy wrote:
> >> Jeff King <peff@peff.net> writes:
> >> > On Wed, Jun 08, 2011 at 07:28:35PM +0200, Matthieu Moy wrote:
> >> >> > Jeff King <peff@peff.net> writes:
> >> >> >
> >> >> > * @{wtree} would confuse users that it has something to do with reflog
> >> >> 
> >> >> Well, we already have @{upstream} ...
> >> >
> >> > Yes, but like all of the @{} things, it's a modifier for the left-hand
> >> > side. So "master@{upstream}" is meaningful, and "@{upstream}" is the
> >> > same as "HEAD@{upstream}".
> >> >
> >> > What does "master@{wtree}" mean?
> >> 
> >> Nothing, but then we already have @{-1} ;-).
> >
> > That's actually HEAD reflog.
> 
> Yes, but neither HEAD@{-1} nor master@{-1} work. So we have one instance
> of @{...} which is unrelated from reflog, and another which isn't a
> suffix. @{wtree} would be both.

But both are about refs (upstream of a ref, or previously checked-out ref).
@{wtree} ain't.

-- 
Jakub Narebski
Poland
