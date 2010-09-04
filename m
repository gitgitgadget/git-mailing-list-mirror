From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Fri, 3 Sep 2010 21:19:30 -0500
Message-ID: <20100904021929.GB9467@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
 <20100902235429.GB6466@burratino>
 <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
 <20100903235820.GC4471@burratino>
 <7vsk1qxpbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 04:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OriNi-0000g1-GG
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 04:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab0IDCVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 22:21:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32975 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab0IDCVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 22:21:20 -0400
Received: by gyd8 with SMTP id 8so1054776gyd.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SRRuR8szLBoiXzH60cZheNkgHUHE2z5IhdWWpwDeICQ=;
        b=jUhWKkP117tsOGUhnJH5R88+uqyIKAb9jf9F4vHO1dEUCcwU9qod5WkQx9OURxCE7v
         pQmI7OhUK/Lsm2IsG+CnmD6HQuArv8JFDXazfLuQ36rBd3addFSpIpvxJp/GCSBFFAe/
         rYO77DKE3xE5X8rUqPlzwPQdCP7aNAwXvVPH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lXFVEeFJpWyWYEIv9pZKtz01xVLCmvVvjvaZ9w18j/hdY93yPxqbVWs7WOuB9n9BrI
         G/bX0QRJHSr8oTjAyfNcpzdMJVJm9ohp+5fDaKHI2BYsVjyTFcwrSSOFZsLhj2/P27U5
         ZPpI/x0NVpQcAIMCgFPQNq4QEm8yrE3f/q8CA=
Received: by 10.101.209.31 with SMTP id l31mr344606anq.191.1283566879593;
        Fri, 03 Sep 2010 19:21:19 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w1sm3740480ana.36.2010.09.03.19.21.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 19:21:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsk1qxpbp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155299>

Junio C Hamano wrote:

> Ah, you mean "instaweb wants to use a specific layout but whatever is
> specified in /etc/gitweb.conf will interfere with it"?

Exactly.
